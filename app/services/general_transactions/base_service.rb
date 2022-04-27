# frozen_string_literal: true

module GeneralTransactions
  class BaseService < ::BaseService
    def initialize(params, company_id)
      @params = params
      @company_id = company_id
    end

    protected

    def general_transaction_params
      @general_transaction_params ||= @params
        .require(:general_transaction)
        .permit(
          
        )
    end
  end
end