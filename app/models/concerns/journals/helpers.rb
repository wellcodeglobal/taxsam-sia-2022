# frozen_string_literal: true

module Journals
  module Helpers
    extend ActiveSupport::Concern
    def account
      Account.find_by(code: self.code)
    end

    def account_name
      account.name
    end
  end
end
