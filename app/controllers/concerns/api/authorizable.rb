module Api
  module Authorizable extend ActiveSupport::Concern
    def generated_token
      local_token = ENV['ACCOUNTING_TOKEN']
      key = "#{local_token}:#{@email}:#{@user_id}"
      generated_token = Base64.encode64(key)
    end
    
    def validate_token
      return redirect_to root_path unless params[:token].present?
      generated_token = Base64.decode64(params[:token])
      parsing_token = generated_token.split(":")

      local_token = ENV['ACCOUNTING_TOKEN']
      token = parsing_token[0]
      return return_unauthorize unless local_token == token

      @email = parsing_token[1]
      @user_id = parsing_token[2]
      return return_unauthorize unless @email.present? && @user_id.present?
    end

    def verify_authorization_token
      return return_unauthorize unless request.headers[:Authorization].present?
      authorization = request.headers[:Authorization]
      
      basic_auth = authorization.to_s.strip.split(' ').second
      return return_unauthorize unless basic_auth.present?

      local_token = ENV['ACCOUNTING_TOKEN']
      token = Base64.decode64(basic_auth)
      return return_unauthorize unless local_token == token

      @user_id = request.headers["User-ID"]
      @email = params[:email]
      return return_unauthorize unless @user_id.present? && @email.present?
    end

    def return_unauthorize
      return render json: {
        status: 'UNAUTHORIZED',
        code: 401,
        message: "token authorization failed to verify.",
      }, status: :unauthorized
    end
  end
end