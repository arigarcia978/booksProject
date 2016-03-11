$(document).ready(function(){
	$(".button-collapse").sideNav();
})

function notifiedByToast() {
	var notice = $('#notice').html();
	Materialize.toast(notice, 4000);
}