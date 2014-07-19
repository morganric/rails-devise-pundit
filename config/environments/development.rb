ENV['PANDASTREAM_URL'] = "https://e316004b0285a30b60e3:3165cec2e770620d6973@api.pandastream.com/59058807b78fc5405c6b63cf44140873"
ENV["MANDRILL_USERNAME"] = 'embedtree@gmail.com'
ENV["GMAIL_USERNAME"] = 'embedtree@gmail.com'
ENV["MANDRILL_APIKEY"] = 'rwAbwfwA5Hq77cYr8lXP2g'
ENV["GMAIL_PASSWORD"] = "3mb3dtr339"
ENV["OMNIAUTH_PROVIDER_KEY"] = "sUedRjJ0a8oHJJfHcnO1x5xBV"
ENV["OMNIAUTH_PROVIDER_SECRET"] = "HikKRSrM2gNNDLRakwCGW1tYj3RkGrErISgE0HT8JqRr3pHVmR"
ENV["FACEBOOK_APP_ID"] = "1440239169528450"
ENV["FACEBOOK_APP_SECRET"] = "884240b8d9bf9d868a1bd0f0465c90bf"

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.  
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.smtp_settings = {
    address: "smtp.mandrillapp.com",
    port: 25,
    domain: "example.com", #Rails.application.secrets.domain_name,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "embedtree@gmail.com", #Rails.application.secrets.email_provider_username,
    password: "rwAbwfwA5Hq77cYr8lXP2g" #Rails.application.secrets.email_provider_password
  }
  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  # Send email in development mode?
  config.action_mailer.perform_deliveries = true


  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
