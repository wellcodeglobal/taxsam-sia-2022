class Admin::JournalsController < AdminController
  def index
    @total_journals = Journal
      .where(company: current_company, date: date_range)
      .count

    @journals = Journal
      .where(company: current_company, date: date_range)
      .page(params[:page])
      .per(10)
  end 
  
  private
  def date_range
    if params[:start_date].present? && params[:end_date].present?
      return (params[:start_date].to_date..params[:end_date].to_date)
    end
    return (Date.today.beginning_of_year..Date.today.end_of_month)
  end
end
