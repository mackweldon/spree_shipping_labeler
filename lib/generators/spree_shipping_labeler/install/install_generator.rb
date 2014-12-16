module SpreeShippingLabeler
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_javascripts
        append_file "app/assets/javascripts/admin/all.js", "//= require admin/spree_shipping_labeler\n"
      end

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_shipping_labeler'
      end

      def run_migrations
        return(run 'rake db:migrate') if ENV['RUN_MIGRATIONS'] == 'true'

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
