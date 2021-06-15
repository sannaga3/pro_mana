module ApplicationHelper
  def button_text
    if action_name == "new"
      t('view.submit')
    elsif action_name == "edit"
      t('view.update')
    end
  end
end
