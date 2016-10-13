class DashboardsController < ApplicationController
  def show
    condition = {
      category_id: dashboard_params[:category_ids] || Category.pluck(:id),
      personal_information_item_id: dashboard_params[:pii_ids],
      use_item_id: dashboard_params[:use_item_ids]
    }

    @grouped_rules = Rule.where(condition).group_by(&:restriction)
  end

  def dashboard_params
    params.require(:dashboard).permit(category_ids: [], pii_ids: [], use_item_ids: [])
  end
end