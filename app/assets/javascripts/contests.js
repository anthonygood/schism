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
	
	function zoom($el){
		
		$el
		.css({'border-width': '75px'})
		.animate({'border-width': '0'}, 1000)
		.animate({'border-width': '25', duration: 100})
		.animate({'border-width': '10', duration: 200});
	}	
	
	

	

	var $medallions = $(".medallion"),
		$left 		= $medallions.filter(".left"), 
		$right 		= $medallions.filter(".right"),
		$q			= $('#question');
	
	// make the medallions quiver
	//quiver($left, "left");
	//quiver($right, "right");
	
	// fade in headings
	$($("h1")[0]).css("opacity", "0").animate({opacity: "1"}, 6000);
	
	
	//spin the medallions
	$left.addClass('rotate-right');
	$right.addClass('rotate-left');
	
	//spin and zoom the medallions
	$medallions.css({'border-width': '50px'});
	
	zoom($medallions);
	
	//hide the #question
	$q.css('top', '-1000px');
	
	function pullDownQuestion(){
		$q.css('top', '0px');
	};
	
	window.setTimeout(pullDownQuestion, 2000);
	
	
	$left.on("click", function(){
		$left.toggleClass('rotate-right');
	});
	$right.on("click", function(){
		$right.toggleClass('rotate-right');
	});
	
	
	
	//animations for voting!
	$('.btn.contest').on('click', function(e){
		//prevent form submission
		e.preventDefault();
		//disable form submission on subsequent clicks
		$('.btn').attr('disabled','disabled')
		//stop further click events
			.off('click');
		//variable housekeeping
		var position 		= "." + $(this).attr('data'),
			$thisMedallion 	= $('.medallion'+position),
			$otherMedallion = $($medallions.not(position)),
			button 			= this,
			$otherButton	= $('.btn').not($(this)),
			winner			= this.value.split(" ")[0];
		
		console.log("THE WINNER IS...", winner);
		//hide the other button
		$otherButton.fadeOut();
		//change this button's class
		$(button).addClass('chosen');
		
		//animate the discarded medallion
		rejected();

		
		function rejected(){
	
			$otherMedallion
				.toggleClass('rotate-right')
				.animate({'border-width': '85'}, 1000, function(){
					$otherMedallion.animate({'opacity': 0}, 250);
					selected();
					finishAnimations();
				});
		}	
		
		function finishAnimations(){
			//after zooming and spinning,
			//inject the winner's name where the losing medallion was
			$(button)
				.hide()
				.parent()
				.prepend(
				"<h2 class='blue victor'>"
				+ winner 
				+ "</h2>"
				)
				.children()
				.animate({'font-size': '48px'}, 120)
				.animate({'font-size': '36px'}, 100)
				.animate({'font-size': '45px'}, 110)
				.animate({'font-size': '42px'}, 130, function(){
					submitVote()
				});
			
		
		}
		function submitVote(){

			$(button).parent().parent().submit();

		}
		
		function selected(){
			$thisMedallion		
				.animate({'border-width': '20', 'easing': 'ease-in'}, 120)
				.animate({'border-width': '5', 'easing': 'ease-in'}, 100)
				.animate({'border-width': '10', 'easing': 'ease-in'}, 100)
				.animate({'border-width': '0', 'easing': 'ease-in'}, 110)
				.animate({'border-width': '5', 'easing': 'ease-in'}, 130)
				.animate({'border-width': '0', 'easing': 'ease-in'}, 300, function(){
					$(this).addClass('chosen');
			});
		
		}
	});

});