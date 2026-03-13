# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_password = ENV.fetch("ADMIN_SEED_PASSWORD", "password123")
user_password = ENV.fetch("USER_SEED_PASSWORD", "password123")

admin = User.find_or_initialize_by(email: "admin@example.com")
admin.name = "Admin User"
admin.admin = true
admin.password = admin_password
admin.password_confirmation = admin_password
admin.save!

user = User.find_or_initialize_by(email: "user@example.com")
user.name = "Regular User"
user.admin = false
user.password = user_password
user.password_confirmation = user_password
user.save!

puts "Seeded users: #{admin.email}, #{user.email}"

categories_by_user = {
	admin => ["Office", "Travel", "Utilities", "Food"],
	user => ["Groceries", "Transport", "Health", "Entertainment"]
}

seeded_categories = {}

categories_by_user.each do |seed_user, category_names|
	seeded_categories[seed_user.id] = category_names.each_with_object({}) do |name, memo|
		memo[name] = Category.find_or_create_by!(user: seed_user, name: name)
	end
end

today = Date.current
last_month_date = today.last_month

expenses_data = {
	admin => [
		{ title: "Team Lunch", amount: 120, expense_date: today - 10, category_name: "Food" },
		{ title: "Cloud Hosting", amount: 300, expense_date: today - 7, category_name: "Utilities" },
		{ title: "Airport Taxi", amount: 55, expense_date: last_month_date + 5, category_name: "Travel" },
		{ title: "Stationery", amount: 40, expense_date: last_month_date + 9, category_name: "Office" }
	],
	user => [
		{ title: "Weekly Groceries", amount: 85, expense_date: today - 8, category_name: "Groceries" },
		{ title: "Bus Pass", amount: 30, expense_date: today - 5, category_name: "Transport" },
		{ title: "Pharmacy", amount: 25, expense_date: last_month_date + 6, category_name: "Health" },
		{ title: "Cinema", amount: 20, expense_date: last_month_date + 12, category_name: "Entertainment" }
	]
}

expenses_data.each do |seed_user, records|
	records.each do |record|
		category = seeded_categories[seed_user.id].fetch(record[:category_name])

		expense = Expense.find_or_initialize_by(
			user: seed_user,
			category: category,
			title: record[:title],
			expense_date: record[:expense_date]
		)
		expense.amount = record[:amount]
		expense.save!
	end
end

budgets_data = {
	admin => [
		{ month: today.month, year: today.year, monthly_limit: 2500 },
		{ month: last_month_date.month, year: last_month_date.year, monthly_limit: 2200 }
	],
	user => [
		{ month: today.month, year: today.year, monthly_limit: 900 },
		{ month: last_month_date.month, year: last_month_date.year, monthly_limit: 850 }
	]
}

budgets_data.each do |seed_user, records|
	records.each do |record|
		budget = Budget.find_or_initialize_by(
			user: seed_user,
			month: record[:month],
			year: record[:year]
		)
		budget.monthly_limit = record[:monthly_limit]
		budget.save!
	end
end

puts "Seeded categories: #{Category.count}, expenses: #{Expense.count}, budgets: #{Budget.count}"
