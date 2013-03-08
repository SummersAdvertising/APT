# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
APT::Application.initialize!

ENV['RAILS_RELATIVE_URL_ROOT'] = '/apt'

Rails.application.routes.default_url_options = {:script_name => '/apt'}