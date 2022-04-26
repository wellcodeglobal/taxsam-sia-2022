require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaxsamSia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.fallbacks = [:id, :en]

    I18n.config.available_locales = [:id, :en]
    I18n.default_locale = :id

    config.generators do |g|
      g.template_engine = :slim
      g.orm :active_record, primary_key_type: :uuid
    end

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths += Dir["#{Rails.root}/lib/modules/*"]
    config.autoload_paths << "#{Rails.root}/lib/modules"
  end
end
