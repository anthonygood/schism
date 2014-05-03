module ApplicationHelper

  def controller?(*controller)
    controller.include? params[:controller]
  end
  
  def action?(*actions)
    actions.include? params[:action]
  end
end
