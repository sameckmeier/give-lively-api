# frozen_string_literal: true

# Non-profits
puts 'Creating NonProfits and Donations'

10.times do |i|
  puts "Creating non-member NonProfit #{i}"
  non_profit = NonProfit.create!(name: "NonMemberRequiresPayment #{i}", address: "test #{i}")

  puts "Creating Donation for NonProfit #{non_profit.id}"
  Donation.create!(amount: 1.0.to_d, non_profit_id: non_profit.id)
end

10.times do |i|
  puts "Creating non-member NonProfit that does not require payment #{i}"
  NonProfit.create!(name: "NonMemberDoesNotRequirePayment #{i}", address: "test #{i}")
end

10.times do |i|
  puts "Creating member NonProfit #{i}"
  NonProfit.create!(name: "Member #{i}", address: "test #{i}", member: true)
end
