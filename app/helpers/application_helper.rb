# frozen_string_literal: true

module ApplicationHelper  
  def current_company 
    if current_user.present?
      @current_company ||= current_user.company
    end
  end
end
