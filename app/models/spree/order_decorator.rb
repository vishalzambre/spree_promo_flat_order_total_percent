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
end
