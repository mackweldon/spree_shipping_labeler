# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  config.currency               = "USD"
  config.site_name              = "Working Title"
  config.track_inventory_levels = true
  #config.products_per_page      = 48 # prefer multiples of 3
  config.orders_per_page        = 15 # admin page
end

Spree.user_class = "Spree::User"
