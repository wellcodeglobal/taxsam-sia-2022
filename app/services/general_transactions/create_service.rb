module GeneralTransactions
  class CreateService < GeneralTransactions::BaseService
    def action
      new_transaction = GeneralTransaction.new(general_transaction_params)
      new_transaction.company_id = @company_id      

      general_transaction_lines_params.each do |general_transaction_line|
        next if general_transaction_line["code"].blank?
        transaction_line = new_transaction
          .general_transaction_lines
          .new(general_transaction_line)
        
        transaction_line.company_id = @company_id
      end

      new_transaction.save!
    end
  end
end