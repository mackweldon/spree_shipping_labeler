Spree::ShippingCategory.class_eval do
  def self.default
    where("name ilike 'default'").first
  end
end
