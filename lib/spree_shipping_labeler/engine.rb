module Spree::ShippingLabeler
end
module SpreeShippingLabelerExtension
  class Engine < Rails::Engine

    #initializer "spree.active_shipping.preferences", :before => :load_config_initializers do |app|
      #Spree::ShippingLabeler::Config = Spree::ShippingLabelerConfiguration.new
    #end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/utilities)
    config.to_prepare &method(:activate).to_proc

    #initializer "spree_active_shipping.register.calculators" do |app|
      #if app.config.spree.calculators.shipping_methods
        #classes = Dir.chdir File.join(File.dirname(__FILE__), "../../app/models") do
          #Dir["spree/calculator/**/*.rb"].reject {|path| path =~ /base.rb$/ }.map do |path|
            #path.gsub('.rb', '').camelize.constantize
          #end
        #end

        #app.config.spree.calculators.shipping_methods.concat classes
      #end
    #end

        # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
    #initializer "spree.assets.precompile", :group => :all do |app|
      #app.config.assets.precompile += %w[
        #admin/product_packages/new.js
        #admin/product_packages/edit.js
        #admin/product_packages/index.js
      #]
    #end
  end
end
