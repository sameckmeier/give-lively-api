class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :non_profit_id, :amount
end
