# frozen_string_literal: true

class HomesController < ApplicationController
  layout 'homes'
  def index; end

  def err_page
    call_err_method
  end

  private
  def call_err_method
    raise "This is an error"
  end
end
