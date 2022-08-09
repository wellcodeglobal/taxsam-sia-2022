class Admin::GeneralTransactionsController < AdminController
  before_action :general_transaction, only: [:show, :update, :destroy]

  def index
    @total_general_transactions = GeneralTransaction.where(company: current_company).count
    @general_transactions = GeneralTransaction.where(company: current_company)
      .order(date: :desc)
      .page(params[:page])
      .per(10)
    
  end

  def create
    service = ::GeneralTransactions::CreateService.new(
      params, current_company.id
    )

    unless service.run
      return redirect_to new_admin_general_transaction_path, 
        alert: "Transaksi gagal di simpan, #{service.error_messages.to_sentence}"
    end

    redirect_to admin_general_transactions_path, 
      notice: 'Transaksi berhasil di simpan'
  end

  def new
    @transaction = GeneralTransaction.new    
    @accounts = current_company.accounts
  end

  def show
  end

  def destroy
    closed_journals = ClosedJournal.where("date >= ?", general_transaction.date)
    if closed_journals
      return redirect_to admin_general_transactions_path, 
        alert: "Transaksi sudah di tutup di Tutup Buku dan tidak dapat hapus atau di edit."
    end

    if general_transaction.destroy
      return redirect_to admin_general_transactions_path, 
        notice: "General Transaction deleted"
    end
      
    redirect_to admin_general_transactions_path, 
      alert: general_transaction.errors.full_messages.join(", ")
  end

  private
  def general_transaction
    @general_transaction = GeneralTransaction.find(params[:id])
  end
end
