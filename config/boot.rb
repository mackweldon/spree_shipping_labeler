# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

unless %w[staging production].include?(ENV["RAILS_ENV"].to_s.strip)
  require 'dotenv'
  Dotenv.load
end

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
