# Generate ZPLII shipping labels for thermal printers.
# Connects to FedEx and pulls in a plaintext label.
#
# Expects a Spree::Shipping::Package
#
module Utilities
  class LabelError < Exception; end

  class Labeler
    attr_reader :return_label
    def initialize(pkg=nil)
      @package = pkg
    end

    # Create a shipping label for a given package. Supports Fedex
    #
    def generate
      fedex_generate
    end

    def label_service_name_for_calculator(calculator)
      name = calculator.type.gsub(/^Spree::Calculator::Shipping::/, '')

      mappings = {
        'Fedex::PriorityOvernight'     => 'PRIORITY_OVERNIGHT',
        'Fedex::StandardOvernight'     => 'STANDARD_OVERNIGHT',
        'Fedex::TwoDay'                => 'FEDEX_2_DAY',
        'Fedex::ExpressSaver'          => 'FEDEX_EXPRESS_SAVER',
        'Fedex::Ground'                => 'FEDEX_GROUND',
        'Fedex::GroundHomeDelivery'    => 'GROUND_HOME_DELIVERY',
        'Fedex::InternationalEconomy'  => 'INTERNATIONAL_ECONOMY',

        'Usps::FirstClassMailParcels'  => 'First',
        'Usps::PriorityMail'           => 'Priority', 
        'Usps::ExpressMailInternational' => 'ExpressMailInternational', 
      }

      mappings.fetch(name)
    end

    #######################
    # Private Instance Methods
    #######################

    private
    # Makes recursive labeling a bit easier to test
    def companion_labeler
      @companion_memo ||= self.class.new
    end

    def fedex_generate
      begin
        result = self.class.fedex_connection.label({
          packages: [
            {
              weight: { value: package.weight, units: "LB" },
              dimensions: {
                length: package.length,
                width:  package.width,
                height: package.height,
                units: "IN"
              }
            }
          ],
          recipient:  package.destination.fedex_formatted,
          shipper:    package.origin.fedex_formatted,
          label_specification: {
            image_type:       "ZPLII",
            label_stock_type: "STOCK_4X6.75_LEADING_DOC_TAB",
            filename:         nil
          },
          service_type: service_name,
        })
      rescue Exception => err
        raise Utilities::LabelError, err.message
      end

      {
        label:           result.image,
        tracking_number: result.options[:tracking_number]
      }
    end

    def service_name
      label_service_name_for_calculator(package.shipping_method.calculator)
    end

    #######################
    # Private Class Methods
    #######################

    def self.fedex_connection
      @fedex_conn_memo ||= ::Fedex::Shipment.new({
        key:            Spree::ActiveShipping::Config[:fedex_key],
        password:       Spree::ActiveShipping::Config[:fedex_password],
        meter:          Spree::ActiveShipping::Config[:fedex_login],
        account_number: Spree::ActiveShipping::Config[:fedex_account],
        mode:           (test_mode? ? 'test' : 'production')
      })
    end


    def self.test_mode?
      !!Spree::ActiveShipping::Config[:test_mode]
    end
  end
end
