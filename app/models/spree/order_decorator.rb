Spree::Order.class_eval do
  # Is this a free order in which case the payment step should be skipped
  def payment_required?
    total.to_f > 0.0 || flat_percent_order?
  end

  def flat_percent_order?
    calculated_total.to_f == promo_total.to_f.abs
  end

  def calculated_total
    ship_total + item_total + tax_total
  end

  # If true, causes the confirmation step to happen during the checkout process
  def confirmation_required?
    return false if flat_percent_order?
    Spree::Config[:always_include_confirm_step] ||
      payments.valid.map(&:payment_method).compact.any?(&:payment_profiles_supported?) ||
      # Little hacky fix for #4117
      # If this wasn't here, order would transition to address state on confirm failure
      # because there would be no valid payments any more.
      state == 'confirm'
  end
end
