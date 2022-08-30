class Admin::ReportsController < AdminController
  def index
    @total_reports = Report
      .where(company: current_company)
      .count
      
    @reports = Report
      .where(company: current_company)
      .page(params[:page])
      .per(10)
  end

  def show    
    @start_date = params[:start_date]&.to_date || Date.today.beginning_of_year
    @end_date = params[:end_date]&.to_date || Date.today
    @report_facede = Admin::Reports::IndexFacade.new(params, current_company)
  end

  def destroy
    @report = Report.find_by_id(params[:id])
    if @report.present? && @report.destroy
      return redirect_to admin_reports_path, notice: "Laporan Berhasil di hapus."
    end

    redirect_to admin_reports_path, alert: "Laporan tidak ditemukan."
  end
end
