module Spree
  # This is somewhat contrary to standard REST convention since there is not
  # actually a Checkout object. There's enough distinct logic specific to
  # checkout which has nothing to do with updating an order that this approach
  # is waranted.
  CheckoutController.class_eval do
    before_action :remove_payment_attributes, only: [:update]

    private

    def remove_payment_attributes
      return unless @order.flat_percent_order?
      params.delete(:payment_source)
      params[:order].delete(:payments_attributes)
    end

    def insufficient_payment?
      params[:state] == 'confirm' &&
        @order.payment_required? &&
        @order.payments.valid.sum(:amount) != @order.total &&
        !@order.flat_percent_order?
    end
  end
end
