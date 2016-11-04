module Spree
  CheckoutController.class_eval do
    private

    def insufficient_payment?
      params[:state] == 'confirm' &&
        @order.payment_required? &&
        @order.payments.valid.sum(:amount) != @order.total &&
        !@order.flat_percent_order?
    end
  end
end
