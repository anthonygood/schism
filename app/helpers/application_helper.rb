module ApplicationHelper

  def controller?(*controller)
    controller.include? params[:controller]
  end
  
  def action?(*actions)
    actions.include? params[:action]
  end
  
  def appellation
    ["Quipper Colleague","Quiz Stalwart","Education Apostle","Distributor of Wisdom","Courier of Knowledge","Knowledge Expert","Thinker of Big Ideas","Quipper Footsoldier", "Learner", "Professor of Truth and Light", "Quasher of Ignorance"].sample(1)[0]
  end
  
  def pretty_time(time)
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
