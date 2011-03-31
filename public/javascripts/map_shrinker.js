
function shrinkMap(){
  $('#map').animate({width: "-=320"},         { queue: false, duration:1200});
  $('#toggler').animate({'right': '-=230px'}, { queue: false, duration:1200});
  $('#toggler .symbol').html("&gt;");                                  
  $('#sidebar').animate({width: "+=320"},     { queue: false, duration:1200});
  $('#sidebar').animate({'right': '-=210px'}, { queue: false, duration:1200});
  $('#side_content table').delay(200).fadeIn(500);
  $('#toggler').removeClass('right_curve');
  $('#toggler').attr("title", "Hide latest listings");
	var center = map.center;
  setTimeout(function(){
  	google.maps.event.trigger(map, "resize");
  	map.setCenter(center, map.zoom);
		},800);
}

function expandMap() {
  $('#side_content table').fadeOut(500);
  $('#sidebar').animate({width: "-=320"},     { queue: false, duration:1000});
  $('#toggler').animate({'right': '+=230px'}, { queue: false, duration:1000});
  $('#map').animate({width: "+=320"},         { queue: false, duration:1000});
  $('#toggler .symbol').html("&lt;");
  $('#toggler').attr("title", "Show latest listings");
  setTimeout(function(){$('#toggler').addClass('right_curve');},1000);
	var center = map.center;
  setTimeout(function(){
  	google.maps.event.trigger(map, "resize");
  	map.setCenter(center, map.zoom);
		},800);
}


function zoomInOn(lat, lng){
	map.setCenter( new google.maps.LatLng(lat,lng), 15);
	map.setZoom(15);
}

$(document).ready(function(){
  
  $("#toggler").click(function(){
    if ($("#toggler").hasClass("right_curve")){
      shrinkMap();
    }
    else {
      expandMap();
    }
  });
});