module Dashboards
  class BasePresenter
    def initialize start_date, end_date
      @params_start_date = start_date
      @params_end_date = end_date
    end
    
    def date_range
      @date_range ||= start_date..end_date
    end

    def start_date
      @start_date ||= begin
        unless @params_start_date.present?
          return @start_date = DateTime.now.beginning_of_year
        end
        @start_date = Date.strptime(@params_start_date, '%d/%m/%Y')
      end
    end

    def end_date
      @end_date ||= begin
        unless @params_end_date.present?
          return @end_date = DateTime.now.end_of_month.end_of_day
        end
        @end_date = Date.strptime(@params_end_date, '%d/%m/%Y')
      end
    end

    def categories
      return @categories if @categories.present?

      @category_range_date = []

      if date_range.count > 31
        date_range.to_a.group_by {|date| date.beginning_of_month}.keys.each do |beginning_date|
          @category_range_date << (beginning_date..beginning_date.end_of_month).to_a
        end

        return @categories = @category_range_date.map(&:first).map do |date|
          I18n.t("date.month_names")[date.to_date.month].first(3)
        end.uniq
      end

      if date_range.count > 7
        date_range.each_slice(3) do |w_days|
          w_days.compact!
          @category_range_date << (w_days.first.to_date..w_days.last.to_date).to_a
        end

        return @categories = @category_range_date.map(&:first).map do |date|
          date.to_date.strftime("%d/%m/%Y")
        end.uniq
      end

      @category_range_date = date_range.to_a.map do |date|
        date.to_date.strftime("%d/%m/%Y")
      end.uniq

      @categories = @category_range_date
    end

    def category_range_date
      categories if @category_range_date.blank?
      @category_range_date
    end
  end
end