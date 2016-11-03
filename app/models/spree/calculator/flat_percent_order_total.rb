require_dependency 'spree/calculator'

module Spree
  class Calculator::FlatPercentOrderTotal < Calculator
    preference :flat_percent, :decimal, default: 0

    def self.description
      Spree.t(:flat_percent_order)
    end

    def compute(object)
      computed_amount = (object.calculated_total * preferred_flat_percent / 100).round(2)
      # We don't want to cause the promotion adjustments to push the order into a negative total.
      if computed_amount > object.calculated_total
        object.total
      else
        computed_amount
      end
    end
  end
end
