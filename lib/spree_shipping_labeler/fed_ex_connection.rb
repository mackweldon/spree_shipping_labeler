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
      base = yamled_params.fetch(Rails.env).symbolize_keys

      test_mode = !!base.delete(:test_mode)
      mode_name = test_mode ? 'test' : 'production'

      base.merge({ mode: mode_name })
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
