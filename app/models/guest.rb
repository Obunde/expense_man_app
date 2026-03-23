# app/models/guest.rb
class Guest 
  def admin?
    true # So they can see the Admin links in the navbar
  end

  def guest?
    true
  end

  def persisted?    = false
  def id; nil; end
  def name; "Guest User"; end
  def email; "guest@example.com"; end
  def created_at; Time.now; end
  
  # Stub associations so the profile/dashboard doesn't crash
  def expenses; Expense.none; end
  def categories; Category.none; end
  def budgets; Budget.none; end
end