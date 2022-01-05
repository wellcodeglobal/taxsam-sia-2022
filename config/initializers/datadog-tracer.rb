# frozen_string_literal: true

Datadog.configure do |c|
  c.env = 'production'
  c.service = 'rails'
end
