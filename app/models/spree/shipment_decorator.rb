Spree::Shipment.class_eval do
  has_many    :packages, class_name: "Spree::Shipping::Package"

  accepts_nested_attributes_for :packages, allow_destroy: true,
    :reject_if => proc { |attributes| attributes['weight'].to_f <= 0 }

  delegate :fedex?, :to => :shipping_method

  scope :not_shipped, -> { where(arel_table[:state].eq('shipped').not) }
  scope :backordered, -> { joins(:inventory_units).
                           merge(Spree::InventoryUnit.backordered) }
end
