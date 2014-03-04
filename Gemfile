source "https://rubygems.org"

# Heroku uses latest patch level and blows up if you specify it explicitly
ruby    "2.1.1"

gem "rails", "4.0.3"

# app server
gem "puma", "~> 2.7.1"

# database
gem "pg", "~> 0.17.1"

# View stuff
gem 'bootstrap-sass',       "~> 3.0.3.0"                                                 
gem "decent_exposure",      "~> 2.3.0"
gem "draper",               "~> 1.3.0"
gem "font-awesome-sass",    "~> 4.0.2"
gem "haml-rails",           "~> 0.5.3"
gem "nested_form",          "~> 0.3.2"
gem "sass-rails",           "~> 4.0.0"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 1.2"

# spree 
gem "spree",              github: "spree/spree",             branch: "2-1-stable"
#gem "spree_gateway",      github: "spree/spree_gateway",     branch: "2-1-stable"
#gem "spree_auth_devise",  github: "spree/spree_auth_devise", branch: "2-1-stable"

# shipping / labels
gem "spree_active_shipping", github: "spree/spree_active_shipping",     branch: "2-1-stable"
gem "fedex",                 "~> 3.4.0"

# local                                                                          
group :development, :test do                                                     
  gem "active_record_sampler_platter", "~> 0.1.0"                                
  gem "better_errors",      "~> 0.9.0"                                         
  gem "binding_of_caller",  "~> 0.7.2"                                           
  gem "capybara-webkit",    "~> 1.1.1"
  gem "capybara-screenshot", "~> 0.3.16"
  gem "database_cleaner",   "~> 1.0.1"                                           
  gem "dotenv",             "~> 0.9.0"
  gem "factory_girl_rails", "~> 4.2.1"                                           
  gem "ffaker",             "~> 1.22.1"                                          
  gem "guard-rspec",        "~> 4.0.3"                                           
  gem "growl",              "~> 1.0.3"                                                        
  gem "pry",                "~> 0.9.12.3"                                        
  gem "pry-doc",            "~> 0.4.6"                                           
  gem "pry-rails",          "~> 0.3.2"                                           
  gem "rspec-rails",        "~> 2.14.0"                                          
  gem "rspec-pride",        "~> 2.2.0"                                           
  gem "shoulda-matchers",   "~> 2.1.0"                                           
  gem "spring",             "~> 1.1.0"
  gem "spring-commands-rspec", "~> 1.0.1"
  gem "xray-rails",         "~> 0.1.6"                                           
end                                                                              
