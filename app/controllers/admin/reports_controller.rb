class Admin::ReportsController < AdminController
  def index
    @reports = Report.all.page(params[:page]).per(10)
  end
end
