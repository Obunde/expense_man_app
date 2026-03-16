# This file is idempotent. Use: bin/rails db:seed
puts "Starting Seeding Process..."

admin_password = ENV.fetch("ADMIN_SEED_PASSWORD", "password123")
user_password = ENV.fetch("USER_SEED_PASSWORD", "password123")

# 1. SEED USERS (5 Users total)
users_to_seed = [
  { name: "Admin User", email: "admin@example.com", admin: true },
  { name: "Regular User", email: "user@example.com", admin: false },
  { name: "Jane Doe", email: "jane@example.com", admin: false },
  { name: "John Smith", email: "john@example.com", admin: false },
  { name: "Expense Manager", email: "manager@example.com", admin: true }
]

seeded_users = users_to_seed.map do |u_data|
  user = User.find_or_initialize_by(email: u_data[:email])
  user.name = u_data[:name]
  user.admin = u_data[:admin]
  user.password = admin_password
  user.password_confirmation = admin_password
  user.save!
  user
end

puts "✅ Seeded #{User.count} Users."

# 2. SEED CATEGORIES (At least 6 per primary user)
categories_map = {
  "admin@example.com" => ["Office", "Travel", "Utilities", "Marketing", "Software", "Rent"],
  "user@example.com" => ["Groceries", "Transport", "Health", "Entertainment", "Dining Out", "Savings"]
}

seeded_categories = {}

categories_map.each do |email, names|
  user = User.find_by(email: email)
  seeded_categories[user.id] = names.map do |name|
    Category.find_or_create_by!(user: user, name: name)
  end
end

puts "✅ Seeded #{Category.count} Categories."

# 3. SEED EXPENSES (6 per primary user)
today = Date.current

expenses_data = {
  "admin@example.com" => [
    { title: "Internet Subscription", amount: 5000, date: today - 2, cat: "Utilities" },
    { title: "Business Flights", amount: 45000, date: today - 15, cat: "Travel" },
    { title: "Co-working Space", amount: 15000, date: today - 20, cat: "Rent" },
    { title: "Facebook Ads", amount: 8000, date: today - 30, cat: "Marketing" },
    { title: "New Keyboard", amount: 3500, date: today - 45, cat: "Office" },
    { title: "Zoom Pro", amount: 2500, date: today - 60, cat: "Software" }
  ],
  "user@example.com" => [
    { title: "Naivas Groceries", amount: 4200, date: today - 1, cat: "Groceries" },
    { title: "Matatu Fare", amount: 150, date: today - 3, cat: "Transport" },
    { title: "KFC Dinner", amount: 1800, date: today - 10, cat: "Dining Out" },
    { title: "Netflix Monthly", amount: 1100, date: today - 25, cat: "Entertainment" },
    { title: "Gym Membership", amount: 3000, date: today - 40, cat: "Health" },
    { title: "Stock Investment", amount: 10000, date: today - 50, cat: "Savings" }
  ]
}

expenses_data.each do |email, records|
  user = User.find_by(email: email)
  records.each do |r|
    category = Category.find_by(user: user, name: r[:cat])
    Expense.find_or_create_by!(
      user: user,
      category: category,
      title: r[:title],
      expense_date: r[:date]
    ) do |e|
      e.amount = r[:amount]
    end
  end
end

puts "✅ Seeded #{Expense.count} Expenses."

# 4. SEED BUDGETS (5 months of history per user)
(0..4).each do |months_back|
  date = today - months_back.months
  seeded_users.each do |user|
    limit = user.admin? ? (20000 + rand(5000)) : (8000 + rand(2000))
    
    Budget.find_or_initialize_by(
      user: user,
      month: date.month,
      year: date.year
    ).update!(monthly_limit: limit)
  end
end

puts "✅ Seeded #{Budget.count} Budget records."
puts "--- Seeding Complete! ---"