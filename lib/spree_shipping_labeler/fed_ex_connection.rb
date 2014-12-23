require 'yaml'

module SpreeShippingLabeler
  module FedExConnection
    def self.connection
      Fedex::Shipment.new(connection_params)
    end

    def self.yamled_params
      @yamled_params ||= ::YAML.load_file('config/fedex_api.yml')
    end

    def self.connection_params
      base_params = yamled_params.fetch(connection_mode).symbolize_keys
      base_params.merge({ mode: connection_mode })
    end

    def self.connection_mode
      test_mode? ? 'test' : 'production'
    end

    def self.test_mode?
      ENV["FEDEX_TEST_MODE"] || (Rails.env.production? ? false : true)
    end

    def self.company
      connection_params.fetch(:company)
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

  end
end
