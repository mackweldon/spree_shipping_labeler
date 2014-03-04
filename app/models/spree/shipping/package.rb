module Spree
  module Shipping
    class Package < ActiveRecord::Base
      after_save :update_shipment_tracking_number

      self.table_name = "spree_shipping_packages"

      belongs_to :shipment,  validate: true
      belongs_to :shipping_method,  validate: true
      belongs_to :box,       validate: true
      has_one    :order,           through: :shipment

      scope :has_label, -> { where "label_zpl is not null" }

      validates_presence_of :shipping_method_id
      validates_presence_of :box_id
      validates_presence_of :weight
      validates_numericality_of :weight, greater_than: 0

      delegate :fedex?,          to: :shipping_method

      delegate :length, to: :box
      delegate :width,  to: :box
      delegate :height, to: :box

      def destination
        shipment.address || order.ship_address
      end

      def origin
        shipment.stock_location
      end

      # Endicia requires 4.1 precision
      def weight_in_ounces
        raw = weight * 16.0
        rounded_up = (raw * 10).ceil / 10.0
      end

      # Throw away the label ZPL when e.g. shipping method or address has changed
      #
      def invalidate_label!
        self.label_zpl = nil
        save!
      end

      def print_label!(printer_name: nil)
        generate_label!

        # Left out because I didn't write that class:
        Utilities::RawPrinter.new(printer_name).print label_zpl 
      end

      private
      def generate_label!
        # Don't regenerate a label unless it's nil. Regenerating USPS labels
        # costs money.
        #
      
        if label_zpl.nil?
          begin
            response = ::Utilities::Labeler.new(self).generate
          rescue *acceptable_errors => err
            handle_label_error! err
          end

          self.label_zpl       = response[:label]
          self.tracking_number = response[:tracking_number]

          save!
        end
      end

      def handle_label_error!(err)
        Rails.logger.warn("** Labeler error: #{err.inspect}")
        raise Utilities::LabelError, err.message
      end

      def acceptable_errors
        [Utilities::LabelError]
      end

      def update_shipment_tracking_number
        return if tracking_number.blank?

        shipment.tracking = tracking_number
        shipment.save! if shipment.changed?
      end
    end
  end
end
