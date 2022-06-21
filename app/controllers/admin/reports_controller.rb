class Admin::ReportsController < AdminController
  def index
    @reports = Report.all.page(params[:page]).per(10)
  end

  def show    
    @report_facede = Admin::Reports::IndexFacade.new(params)
  end

  def destroy
    @report = Report.find_by_id(params[:id])
    if @report.present? && @report.destroy
      return redirect_to admin_reports_path, notice: "Laporan Berhasil di hapus."
    end

    redirect_to admin_reports_path, alert: "Laporan tidak ditemukan."
  end
end
