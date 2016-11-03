module Spree
  class Promotion
    module Actions
      CreateAdjustment.class_eval do
        def compute_amount(order)
          if calculator.is_a?(Calculator::FlatPercentOrderTotal)
            compute(order) * -1
          else
            [(order.item_total + order.ship_total), compute(order)].min * -1
          end
        end
      end
    end
  end
end
