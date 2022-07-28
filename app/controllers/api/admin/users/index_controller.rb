# frozen_string_literal: true

module Api
  module Admin
    module Users
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

        def users
          return @users if @users.present?

          @users = User
            .where(company: current_company)
            .order(created_at: :desc)

          if sort.present?
            @users = @users
              .reorder("#{sort[:field]}": sort[:sort])
          end

          if query.present? && query.dig(:search).present?
            @users = @users
              .search(query[:search])
          end

          @users
        end

        def paginated_users
          @paginated_users ||= users
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
            pages: paginated_users.total_pages,
            perpage: page[:perpage],
            total: users.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_users.each_with_index do |user, index|
            i = index + start_index
            @data[i] = {
              index: i,
              id: user.id,              
              email: user.email,
              company_name: user.company.name,
              role_name: user.roles.pluck(:name).to_sentence,
              show_path: admin_user_path(id: user.id),
              edit_partial_path: edit_admin_user_path(id: user.id),
              delete_path: admin_user_path(id: user.id)              
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
