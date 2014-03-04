Spree::ShippingMethod.class_eval do
  def fedex?
    name.to_s.downcase.include? 'fedex'
  end
end
