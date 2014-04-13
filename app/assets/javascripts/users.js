// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {

  // Date picker element for user birthdate
  $( "#bday-picker" ).datepicker({
    endDate: new Date(),
    startView: "decade"
  });

  // Init calendar activity creation modals
  $( "#activity-date" ).datepicker({
    todayHighlight: true
  });

  // Tooltips
  $( "#edit" ).tooltip();

  $("#userTable").tablesorter();
	//.tablesorterPager({container: $("#pager")});


});
