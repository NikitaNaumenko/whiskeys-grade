# frozen_string_literal: true

require_relative 'boot'
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WhiskeysGrade
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden

    config.generators do |g|
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.channel         assets: false
      g.system_tests    false

      g.factory_bot suffix: 'factory'
      g.view_specs        false
      g.helper_specs      false
      g.controller_specs  false
      g.integration_specs false
      g.models_specs false
    end
  end
end
