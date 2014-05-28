$(document).ready( function(){


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
	
	function bounceBorder($el){
		
		$el
		.css({'border-width': '75px'})
		.animate({'border-width': '0'}, 1000)
		.animate({'border-width': '25', duration: 100})
		.animate({'border-width': '10', duration: 200});
	}	
	
	function rejected($el, button){
	
		$el
		.toggleClass('rotate-right')
		.animate({'border-width': '85'}, 1000, function(){
			$el.animate({'opacity': 0}, 250);
			button.disabled = false;
			$(button).parent().parent().submit();
			button.disabled = true;
		});
	}
	
	function selected($medallion){
		$medallion
		
			.animate({'border-width': '20', 'easing': 'ease-in'}, 120)
			.animate({'border-width': '5', 'easing': 'ease-in'}, 80)
			.animate({'border-width': '10', 'easing': 'ease-in'}, 80)
			.animate({'border-width': '0', 'easing': 'ease-in'}, 100)
			.animate({'border-width': '5', 'easing': 'ease-in'}, 110)
			.animate({'border-width': '0', 'easing': 'ease-in'}, 150, function(){
				$(this).addClass('chosen');
			});
		
	}

	var $medallions = $(".medallion"),
		$left = $medallions.filter(".left"), 
		$right = $medallions.filter(".right");
	
	// make the medallions quiver
	//quiver($left, "left");
	//quiver($right, "right");
	
	// fade in headings
	$($("h1")[0]).css("opacity", "0").animate({opacity: "1"}, 6000);
	
	
	//spin the medallions
	$left.addClass('rotate-right');
	$right.addClass('rotate-left');
	
	//bounce the medallions' borders
	$medallions.css({'border-width': '50px'});
	bounceBorder($medallions);
	
	
	$left.on("click", function(){
		$left.toggleClass('rotate-right');
	});
	$right.on("click", function(){
		$right.toggleClass('rotate-right');
	});
	
	
	
	//animations for voting!
	$('.btn.contest').on('click', function(e){
		e.preventDefault();
		console.log("ping");
		
		$('.btn').attr('disabled','disabled');
		$('.btn').off('click');
		//left or right? get the data tag
		var position = "." + $(this).attr('data'),
			$thisMedallion = $('.medallion'+position),
			$otherMedallion = $($medallions.not(position));
			
		console.log("$thisMedallion: ", $thisMedallion);
		//hide the other button
		$('.btn').not($(this)).fadeOut();
		//change this button's class
		$(this).addClass('chosen');
		
		//animate the discarded medallion
		//pass it 'this' to submit form on complete
		rejected($otherMedallion, this);
		//animate the chosen medallion
		selected($thisMedallion);
	});

});