# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
APT::Application.initialize!
Rails.application.routes.default_url_options = {:script_name => '/apt'}