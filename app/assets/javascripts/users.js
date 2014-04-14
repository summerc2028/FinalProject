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
  $( ".notmonth .cal-add-button" ).addClass("no-add-button");
  $( ".notmonth .cal-add-button" ).removeClass("cal-add-button");
  $( ".notmonth .cal-view-button" ).addClass("no-view-button");
  $( ".notmonth .cal-view-button" ).removeClass("cal-view-button");
  // Set the add buttons to trigger the modal
  $( ".cal-add-button" ).attr({
    "data-toggle": "modal",
    "data-target": "#new-activity-modal"
  });
  // Automatically generate appropriate date
  $( ".cal-add-button" ).click(function() {
    var date = $( this ).parent().parent().parent().parent().prev().text().trim().split(" ", 1)[0];
    var year = $( "#cal-meta" ).attr("year");
    var month = $( "#cal-meta").attr("month");
    $( ".datepicker" ).val(month + "/" + date + "/" + year);
  });
  // Link to day view page
  $( ".cal-view-button" ).click(function() {
    var date = $( this ).parent().parent().parent().parent().prev().text().trim().split(" ", 1)[0];
    var year = $( "#cal-meta" ).attr("year");
    var month = $( "#cal-meta").attr("month");
    url = window.location.origin;
    user = window.location.pathname.split("/")[2];
    window.location = url + "/users/" + user + "/day-view?date=" + year + "-" + month + "-" + date;
    console.log(url);
    console.log(user);

  });


  // Tooltips
  $( "#edit" ).tooltip();

  $("#userTable").tablesorter();
	//.tablesorterPager({container: $("#pager")});


});
