# frozen_string_literal: true

module ApplicationHelper  
  def current_company 
    @current_company ||= current_user.company
  end
end
