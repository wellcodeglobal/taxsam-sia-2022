# frozen_string_literal: true

module Api
  module Admin
    module GeneralTransactions
      class IndexController < Api::ApplicationController
        def show
          render json: result
        end

        private
        def result
          {
            meta: meta,
            data: data
          }
        end

        def general_transactions
          return @general_transactions if @general_transactions.present?

          @general_transactions = GeneralTransaction
            .where(company_id: current_company.id)
            .order(date: :desc)

          if sort.present?
            @general_transactions = @general_transactions
              .reorder("#{sort[:field]}": sort[:sort])
          end

          if query.present? && query.dig(:search).present?
            @general_transactions = @general_transactions
              .search(query[:search])
          end

          @general_transactions
        end

        def paginated_general_transactions
          @paginated_general_transactions ||= general_transactions
            .page(page[:page])
            .per(page[:perpage])
        end

        def sort
          params[:sort]
        end

        def query
          params[:query]
        end

        def page
          params.require(:pagination)
        end

        def meta
          {
            page: page[:page],
            pages: paginated_general_transactions.total_pages,
            perpage: page[:perpage],
            total: general_transactions.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_general_transactions.each_with_index do |general_transaction, index|
            i = index + start_index
            @data[i] = {
              index: i,
              id: general_transaction.id,
              date: general_transaction.date,
              number_evidence: general_transaction.number_evidence,              
              show_path: admin_general_transaction_path(id: general_transaction.id),
              delete_path: admin_general_transaction_path(id: general_transaction.id)
            }
          end

          @data
        end

        def start_index
          if page[:page].to_i <= 1
            return 1
          end

          ((page[:page].to_i - 1) * page[:perpage].to_i) + 1
        end
      end
    end
  end
end
