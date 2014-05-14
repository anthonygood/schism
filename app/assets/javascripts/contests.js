$(document).ready( function(){
	// fade in heading
	$($("h1")[0]).css("opacity", "0").animate({opacity: "1"}, 3000);


	function quiver($el, direction){
		var a = {}, b = {};
		
		function randDuration(){
			var durations = [1000, 1250, 1500];
			return durations[ Math.floor(Math.random()*durations.length) ]
		}

		// doing it this way in order to use the string argument as an object property
		a[direction] = "3px", b[direction] = "-3px";
		$el
			.animate( a, randDuration(), "swing")
			.animate( b, randDuration(), "swing", function(){ 
				quiver($el, direction); } );
	}
	
	// make the medallions quiver
	//quiver($left, "left");
	//quiver($right, "right");
	
	var $left = $(".medallion").filter(".left"), $right = $(".medallion").filter(".right");
	
	//spin the medallions
	$left.addClass('rotate-right');
	$right.addClass('rotate-left');
	
	$left.on("click", function(){
		$left.toggleClass('rotate-right');
	});
	$right.on("click", function(){
		$right.toggleClass('rotate-right');
	});

});