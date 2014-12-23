# Generate ZPLII shipping labels for thermal printers.
# Connects to FedEx and pulls in a plaintext label.
#
# Expects a Spree::Shipping::Package
require 'fedex'
require 'yaml'

module Utilities
  class LabelError < Exception; end

  class Labeler
    attr_reader :package
    def initialize(pkg=nil)
      @package = pkg
    end

    # Create a shipping label for a given package. Supports Fedex
    #
    def generate
      fedex_generate
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
            image_type:       "PDF",
            filename:         package.return_filename,
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
      self.class.preferred_service_name
    end

    #######################
    # Private Class Methods
    #######################

    def self.preferred_service_name
      service_name_mappings['Fedex::Ground']
    end

    def self.service_name_mappings
      {
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
    end

    def self.connection_params
      yamled_params = ::YAML.load_file('config/fedex_api.yml')
      base_params   = yamled_params.fetch(connection_mode).symbolize_keys

      base_params.merge({ mode: connection_mode })
    end

    def self.fedex_connection
      @fedex_conn_memo ||= ::Fedex::Shipment.new(connection_params)
    end

    def self.connection_mode
      test_mode? ? 'test' : 'production'
    end

    def self.test_mode?
      true
    end
  end
end
