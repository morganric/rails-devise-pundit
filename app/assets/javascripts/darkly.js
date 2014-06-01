// Darkly
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require darkly/loader
//= require darkly/bootswatch

$(document).ready(function() {
	$('.alert, .notice').fadeOut(3000);
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