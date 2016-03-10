$(document).ready(function(){
	// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
	$('select').material_select();
	$('.collapsible').collapsible({
      	accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });
});