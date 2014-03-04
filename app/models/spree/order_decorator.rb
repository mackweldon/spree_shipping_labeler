Spree::Order.class_eval do
  has_many :packages, through: :shipments
end
