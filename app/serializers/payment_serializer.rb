# frozen_string_literal: true

class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :non_profit_id, :amount, :fulfilled
end
