# Load the rails application
require File.expand_path('../application', __FILE__)

PRODUCT_NAME = 'OpenVZ Web Panel'
PRODUCT_VERSION = '2.4'

#ActionController::Base.param_parsers.delete(Mime::XML)

# Initialize the rails application
OWP::Application.initialize!

require 'watchdog_client'
Watchdog = WatchdogClient.new unless defined? WATCHDOG_DAEMON
