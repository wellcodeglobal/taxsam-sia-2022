# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    include ApplicationHelper

    def current_company
      @current_company ||= current_user.company
    end
  end
end
