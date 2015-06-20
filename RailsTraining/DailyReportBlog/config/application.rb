require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DailyReportBlog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Timezone settings
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # locale settings
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # bootstrap-sass settings
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    ## disable field-with-errors
    config.action_view.field_error_proc = proc { |html_tag, instance| "<div class='has-error'>#{html_tag}</div>".html_safe }

    # factory_girl_rails settings
    config.generators do |g|
      g.factory_girl false
    end
  end
end
