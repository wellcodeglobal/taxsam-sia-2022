module Admin::AccountsHelper
  def select_account_options
    @accounts = @current_company.accounts.map {|acc| ["#{acc.code} : #{acc.name}", acc.code]}
  end
end
