class Admin::JournalsController < AdminController
  def index
    @journals = Journal.all.page(params[:page]).per(10)
  end  
end
