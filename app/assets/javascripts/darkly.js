// Darkly
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require darkly/loader
//= require darkly/bootswatch
//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require masonry/box-maker
//= require masonry/jquery.loremimages.min
= require google_dfp

$(document).ready(function() {
	$('.alert, .notice').fadeOut(3000);


	$('#masonry-container').masonry({
	  itemSelector: '.box',
	  gutterWidth: 0,
	  isAnimated: !Modernizr.csstransitions,
	    // isFitWidth: true,
	  // set columnWidth a fraction of the container width
	  columnWidth: function( containerWidth ) {
	    return containerWidth / 3;

	  }
	});

	$('.click').on('click', function(){

	var user = $("#user_id").html();
	var leaf = $("#leaf_id").html();

	$.ajax({
	  url: "/clicks",
	  method: "POST",
	  type: "jsonP",
	  data: { 'click': {'name': user, 'leaf_id': leaf} }
	  // data: {'click': '{"user_id": '+user_id+', "leaf_id":'+leaf_id+' }'}
	}).done(function() {
	  console.log("clicked");
	});

});

});