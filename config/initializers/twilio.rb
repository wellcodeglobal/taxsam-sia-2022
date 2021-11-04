$twilio_config = OpenStruct.new(YAML.load(ERB.new(
  File.read("config/twilio.yml")
).result)[Rails.env])

Twilio.configure do |config|
  config.account_sid = $twilio_config.account_sid
  config.auth_token = $twilio_config.auth_token
end
