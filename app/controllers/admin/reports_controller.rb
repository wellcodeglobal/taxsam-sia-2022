class Admin::ReportsController < AdminController
  def index
    @reports = Report.all.page(params[:page]).per(10)
  end

  def show    
    @report_facede = Admin::Reports::IndexFacade.new(params)
  end
end
