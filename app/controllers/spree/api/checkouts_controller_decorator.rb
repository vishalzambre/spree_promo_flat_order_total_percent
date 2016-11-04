module Spree
  module Api
    CheckoutsController.class_eval do
      before_action :remove_payment_attributes, only: [:update]

      private

      def remove_payment_attributes
        @order = Spree::Order.lock(true).find_by!(number: params[:id])
        return unless @order.flat_percent_order?
        params.delete(:payment_source)
        params[:order].delete(:payments_attributes) if params[:order]
      end
    end
  end
end
