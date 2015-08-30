$(document).ready(function() {
	$('div.inline').mouseleave(function() {
		$(this).animate({backgroundColor: '#b0c4de'}, 'slow');			
	});
	$('div.inline').mouseenter(function() {
		$(this).css("background-color","black");		
	});
});

function changeNrSquares() {
	$num = window.prompt("How many squares?","10");	
	if (isNaN($num)) {
		window.alert('That is not a valid input. Only numbers are allowed.')
	} else {
		$("#squares").remove();
		$("body").append("<div id='squares'></div>");
		
		createSquares($num, $num);
		$('div.inline').mouseleave(function() {
			$(this).animate({backgroundColor: '#b0c4de'}, 'slow');			
		});
		$('div.inline').mouseenter(function() {
			$(this).css("background-color","black");		
		});
	}
}

function createSquares($numHor, $numVert) {
	$numHor = parseInt($numHor) + 1;
	console.log($numHor);
	console.log($numVert);
	for (i=0; i< $numHor * $numVert; i++) {
		$("#squares").append("<div class='inline'></div>");		
		console.log(i);
	}	
	for (i=0; i<= $numVert; i++) {
		$("div:nth-child("+i * $numHor+")").removeClass("inline");
		$("div:nth-child("+i * $numHor+")").addClass("divider");		
		
	}
	
	var $length = 800 / $numVert;
	$(".inline").height($length);
	$(".inline").width($length);
}