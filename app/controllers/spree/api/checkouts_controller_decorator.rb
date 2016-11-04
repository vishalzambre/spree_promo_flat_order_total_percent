module Spree
  module Api
    CheckoutsController.class_eval do
      before_action :remove_payment_attributes, only: [:update]

      private

      def remove_payment_attributes
        @order = Spree::Order.lock(lock).find_by!(number: params[:id])
        return unless @order.flat_percent_order?
        params.delete(:payment_source)
        params[:order].delete(:payments_attributes)
      end
    end
  end
end
