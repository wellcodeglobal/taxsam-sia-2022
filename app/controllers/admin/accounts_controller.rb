class Admin::AccountsController < AdminController
  before_action :account, only: [:edit, :update, :destroy]

  def index
    @new_account = Account.new
    @total_account = Account.where(company: current_company).count
    @accounts = Account
      .where(company: current_company)
      .order(code: :asc)
      .page(params[:page])
      .per(10) 
  end

  def create
    new_account = Account.new(account_params)
    new_account.company = current_company 

    if new_account.save      
      return redirect_to admin_accounts_path, notice: "Account created"
    end

    redirect_to admin_accounts_path, alert: new_account.errors.full_messages.join(", ")
  end

  def update    
    if account.update(account_params)      
      return redirect_to admin_accounts_path, notice: "Account updated"
    end
    
    redirect_to admin_accounts_path, alert: account.errors.full_messages.join(", ")    
  end

  def destroy
    if @account.destroy
      flash[:success] = "Account deleted"
      redirect_to admin_accounts_path
    else
      flash[:error] = "Account not deleted"
      redirect_to admin_accounts_path
    end
  end

  private
  def account
    @account = Account.find(params[:id])
  end
  
  def account_params
    params.require(:account).permit(:code, :name, :balance_type, 
      :account_type, :subclassification, :subclassification_en
    )
  end
end
