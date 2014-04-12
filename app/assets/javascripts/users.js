// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {

  // Date picker element for user birthdate
  $( "#dp3" ).datepicker({
    endDate: new Date(),
    startView: "decade"
  });

  // Tooltips
  $( "#edit" ).tooltip();

  $("#userTable").tablesorter()
	//.tablesorterPager({container: $("#pager")});
   

});
