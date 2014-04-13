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
  // Remove the add button functionality from .notmonth
  $( ".notmonth .cal-add-button" ).addClass("no-button");
  $( ".notmonth .cal-add-button" ).removeClass("cal-add-button");
  // Set the add buttons to trigger the modal
  $( ".cal-add-button" ).attr({
    "data-toggle": "modal",
    "data-target": "#new-activity-modal"
  });
  // Automatically generate appropriate date
  $( ".cal-add-button" ).click(function() {
    var date = $( this ).prev().text().trim().split(" ", 1)[0];
    var year = $( "meta[name=cal]" ).attr("year");
    var month = $( "meta[name=cal]").attr("month");
    $( ".datepicker" ).val(month + "/" + date + "/" + year);
  });


  // Tooltips
  $( "#edit" ).tooltip();

  $("#userTable").tablesorter();
	//.tablesorterPager({container: $("#pager")});


});
