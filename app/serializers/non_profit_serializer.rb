class NonProfitSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :member, :address, :unpaid_donation_amount
end
