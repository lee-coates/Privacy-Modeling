module ApplicationHelper
  def section_nav_tag nav_step
    content_tag_class = nav_step == @step || past_step?(nav_step) ? 'active' : nil rescue 'active'
    condition = past_step?(nav_step) rescue false
    if condition
      link_to I18n.t(nav_step), wizard_path(nav_step, dashboard: step_params_for(nav_step)), class: [content_tag_class, :section].join(' ')
    elsif current_page?(dashboard_path) && nav_step != :results
      link_to I18n.t(nav_step), generate_dashboard_path(nav_step, dashboard: step_params_for(nav_step)), class: [content_tag_class, :section].join(' ')
    else
      content_tag :section, I18n.t(nav_step), class: content_tag_class
    end
  end

  def step_params_for step
    params_keys = {
      select_categories: [category_ids: []],
      select_piis: [category_ids: [], pii_ids: []],
      select_use_items: [category_ids: [], pii_ids: [], use_item_ids: []]
    }
    params.require(:dashboard).permit(params_keys[step]).to_h rescue {}
  end

  def is_item_active(collection_name, id)
    @generate_dashboard_params[collection_name].include?(id.to_s) rescue false
  end
end


