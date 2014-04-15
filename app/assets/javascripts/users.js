// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {

  //
  $('#timepicker').timepicker();

  // Date picker element for user birthdate
  $( "#bday-picker" ).datepicker({
    endDate: new Date(),
    startView: "decade"
  });

  $('#timepicker').timepicker();

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

  // Disable status post until change
  $( "#status" ).keyup(function() {
    if ($( this ).val() == "") {
      $( "#post-status" ).attr("disabled", "disabled");
    } else {
      $( "#post-status" ).removeAttr("disabled");
    }
  });

  // Tooltips
  $( "#edit" ).tooltip();
  $( "#new-act" ).tooltip();

  // Sorting of user index
  $("#userTable").tablesorter();

  // Edit user profile
  $('#edit-profile').click(function(){
    var fname = $('#user-name').html().split(" ")[0];
    var lname = $('#user-name').html().split(" ")[1];
    var gender = $('#user-gender').html();
    var bdate = $('#user-bdate').html();
    var height = $('#user-height').html().split(" ")[0];
    var weight = $('#user-weight').html().split(" ")[0];
    $('#edit-profile').before("<button id='Act_Cancel' type='button' class='btn btn-default'>Cancel</button><input id='Act_Sub' name='commit' type='submit' class='btn btn-default' value='Submit' />");
    $('#edit-profile').hide();
    $('#user-name').replaceWith("<td class='table-input' id='user-name'><input class='form-control' type='text' name='fname' value='"+fname+"'/><input class='form-control' type='text' name='lname' value='"+lname+"'/></td>");
    $('#user-gender').replaceWith('<td class="table-input" id="user-gender"><div class="btn-group" data-toggle="buttons"><label class="btn btn-primary"><input type="radio" name="gender" id="male" value="Male"> Male</label><label class="btn btn-primary"><input type="radio" name="gender" id="female" value="Female"> Female</label></div></td>');
    $('#user-bdate').replaceWith("<td class='table-input' id='user-bdate'><input class='form-control datepicker' type='text' name='birthdate' readonly='readonly' value='"+bdate+"'/></td>");
    $('#user-height').replaceWith("<td class='table-input' id='user-height'><input class='form-control' type='text' name='height' value='"+height+"'/></td>");
    $('#user-weight').replaceWith("<td class='table-input' id='user-weight'><input class='form-control' type='text' name='weight' value='"+weight+"'/></td>");

    $('#Act_Cancel').click(function(){
      $('#edit-profile').show();
      $('#user-name').replaceWith("<td id='user-name'>"+fname+" "+lname+"</td>");
      $('#user-gender').replaceWith("<td id='user-gender'>"+gender+"</td>");
      $('#user-bdate').replaceWith("<td id='user-bdate'>"+bdate+"</td>");
      $('#user-height').replaceWith("<td id='user-height'>"+height+"</td>");
      $('#user-weight').replaceWith("<td id='user-weight'>"+weight+"</td>");
      $('#Act_Cancel').remove();
      $('#Act_Sub').remove();
    });

    // Init calendar activity creation modals
    $( ".datepicker" ).datepicker({
      todayHighlight: true
    });
  });


});
