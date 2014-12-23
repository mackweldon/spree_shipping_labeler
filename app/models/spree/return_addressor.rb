module Spree
  class ReturnAddressor
    attr_reader :rma, :order

    def initialize(rma_label)
      @rma   = rma_label.return_authorization
      @order = rma.order
      self
    end

    def box
      Spree::Shipping::Box.preferred_for_returns
    end

    def height; box.height; end
    def length; box.length; end
    def width;  box.width;  end

    def weight
      calc_weight = rma.inventory_units.flat_map(&:variant).sum(&:weight)
      calc_weight.zero? ? default_weight : calc_weight
    end

    def return_filename
      "Return filename"
    end

    def origin
      order.shipping_address
    end

    def destination
      Spree::StockLocation.first
    end

    def generate_label!
      labeler.generate
    end

    def labeler
      Utilities::Labeler.new(self)
    end

    def default_weight
      16
    end
  end
end
