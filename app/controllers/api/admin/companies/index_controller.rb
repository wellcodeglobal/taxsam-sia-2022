# frozen_string_literal: true

module Api
  module Admin
    module Companies
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

        def companies
          return @companies if @companies.present?

          @companies = Company
            .order(created_at: :desc)

          if sort.present?
            @companies = @companies
              .reorder("#{sort[:field]}": sort[:sort])
          end

          if query.present? && query.dig(:search).present?
            @companies = @companies
              .search(query[:search])
          end

          @companies
        end

        def paginated_companies
          @paginated_companies ||= companies
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
            pages: paginated_companies.total_pages,
            perpage: page[:perpage],
            total: companies.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_companies.each_with_index do |company, index|
            i = index + start_index
            @data[i] = {
              index: i,
              id: company.id,
              name: company.name,
              slug: company.slug,
              email: company.users&.first&.email,              
              edit_partial_path: edit_admin_company_path(id: company.id, slug: company.slug),
              delete_path: admin_company_path(id: company.id, slug: company.slug)              
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
