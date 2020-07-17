# frozen_string_literal: true

# Non-profits
puts 'Creating NonProfits'
non_member_non_profit_requires_payment = NonProfit.create!(name: 'NonMemberRequiresPayment', address: 'test')
NonProfit.create!(name: 'NonMemberDoesNotRequirePayment', address: 'test')

8.times do |i|
  NonProfit.create!(name: "Member #{i}", address: "test #{i}", member: true)
end

# Donations
puts 'Creating Donations'
Donation.create!(amount: 0.5.to_d, non_profit_id: non_member_non_profit_requires_payment.id)
Donation.create!(amount: 1.0.to_d, non_profit_id: non_member_non_profit_requires_payment.id)
