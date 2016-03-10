$(document).ready(function(){
	$(".dropdown-button").dropdown();
})

function notifiedByToast() {
	var notice = $('#notice').html();
	Materialize.toast(notice, 4000);
}