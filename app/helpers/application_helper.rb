module ApplicationHelper

  def controller?(*controller)
    controller.include? params[:controller]
  end
  
  def action?(*actions)
    actions.include? params[:action]
  end
  
  def id?(id)
    params[:id].to_i == id
  end
  
  
  def portrait_link(team_member)
    link_to( image_tag(team_member.image_path), team_member_path(team_member.id) )
  end
  
  def pretty_time(time)
    time = time.localtime
    day = get_day(time)
    time = time.strftime("%l:%M%P")
	"#{day}, at #{time}"
  end
  
  def get_name(id)
    TeamMember.find(id).name
  end
  
  private
  def get_day(time)
    if time.to_date == Date.today
	  "Today"
	elsif time.to_date == Date.yesterday
	  "Yesterday"
	else
	  time.strftime("#{time.day.ordinalize} %b")
	end
  end
  
end
