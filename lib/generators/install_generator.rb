module SpreeShippingLabeler
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file "vendor/assets/javascripts/spree/backend/all.js", "//= require spree/backend/spree_shipping_labeler\n"
      end

      def add_stylesheets
        inject_into_file "vendor/assets/stylesheets/spree/backend/all.css", " *= require spree/backend/spree_shipping_labeler\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_shipping_labeler'
      end

      def run_migrations
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'rake db:migrate'
        else
          puts "Skipping rake db:migrate, don't forget to run it!"
        end
      end

    end
  end
end
