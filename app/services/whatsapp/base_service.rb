# frozen_string_literal: true

module Whatsapp
  class BaseService < ::BaseService
    def initialize(user_id:, url:)
      @user = User.find(user_id)
      @url = url
    end

    def action
      client.messages.create(
        to: "whatsapp:#{@user.formatted_phone}",
        body: message.strip,
        from: "whatsapp:#{$twilio_config.phone_number}"
      )
    end

    def validate_before_action; end

    private

    def client
      return @client if @client.present?

      @client = Twilio::REST::Client.new
    end

    def whatsapp_params
      {
        to: "whatsapp:#{@user.formatted_phone}",
        body: message.strip,
        from: "whatsapp:#{$twilio_config.phone_number}"
      }
    end

    def message
      "Hello #{@user.email}!,\nWelcome to Taxsam.co Learning Center!\n\nTo activate your account please click the link below to verify your email address:\n#{@url}\n\nCheers,\nTaxsam.co Team"
    end
  end
end
