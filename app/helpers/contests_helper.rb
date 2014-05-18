module ContestsHelper

  def next_range
    # uses @x, @y
	# to "11-20"
	
	spread = (@y - @x) + 1
	"#{@y + 1}-#{@y + spread}"
	
	
  end
  
  def prev_range
    spread = (@y - @x) + 1
	
	# stop less than zero values
	if @x - spread < 1
	  min = 1
	else
	  min = @x - spread
	end
	
	"#{min}-#{@x-1}"
  end
end
