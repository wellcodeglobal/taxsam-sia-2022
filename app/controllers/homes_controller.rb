# frozen_string_literal: true

class HomesController < ApplicationController
  before_action :require_login
  
  layout 'homes'
  def index; end

  def err_page
    sample_err_methods
  end

  private
  def sample_err_methods
    raise "This is sample_err_methods"
  end
end
