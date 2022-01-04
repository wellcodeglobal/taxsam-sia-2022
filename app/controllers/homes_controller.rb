# frozen_string_literal: true

class HomesController < ApplicationController
  layout 'homes'
  def index; end

  def err_page
    call_err_methodss
  end

  private
  def call_err_methodss
    raise "This is new an error"
  end
end
