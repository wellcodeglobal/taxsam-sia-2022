# frozen_string_literal: true

class AuthenticationUsersController < ApplicationController
  layout "authentication_users"
  include Api::Authorizable
  before_action :validate_token, only: [:register_sia, :login_sia]

  def register_sia    
  end

  def login_sia
  end

  private
  def sample_err_methods
    raise "This is sample_err_methods"
  end
end
