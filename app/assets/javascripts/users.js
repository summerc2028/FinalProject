$( document ).ready(function() {

  //Datepicker and Timepicker for exerceses
  $('#exercise-timepicker').datetimepicker({
    pickDate: false
  });
    $("#exercise-date").datetimepicker({
    pickTime: false
  });

  //Datepicker and Timepicker for foods
  $('#food-timepicker').datetimepicker({
    pickDate: false
  });
  $( "#food-date" ).datetimepicker({
    pickTime: false
  });

  // Date picker element for user birthdate
  $( "#bday-picker" ).datetimepicker({
    pickTime: false
  });
  //Ensures you can't pick a future date as a birthday
  $("#bday-picker-icon").click(function(e){
      $("#bday-picker").data("DateTimePicker").setMaxDate(new Date());
    });
  
  //Datepicker and Timepicker for activities
  $('#timepicker').datetimepicker({
    pickDate: false
  });
  $( "#activity-date" ).datetimepicker({
    pickTime: false
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
  $( "#new-exercise").tooltip();
  $( "#new-food" ).tooltip();

  // Sorting of user index
  $("#userTable").tablesorter();

  /* Used to edit the user profile. 
      Removes the generic text fields and replaces with input fields to allow updating information
      If saved information will be modified in the database */
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
    $('#user-bdate').replaceWith("<td class='table-input' id='user-bdate'><div class='input-group date' id='gen_cal'><input class='form-control' type='text' name='birthdate' readonly='readonly'/><span class='input-group-addon'><i class='glyphicon glyphicon-calendar'></i></span></div></td>");
    $('#user-height').replaceWith("<td class='table-input' id='user-height'><input class='form-control' type='text' name='height' value='"+height+"'/></td>");
    $('#user-weight').replaceWith("<td class='table-input' id='user-weight'><input class='form-control' type='text' name='weight' value='"+weight+"'/></td>");
    $('#gen_cal').datetimepicker({pickTime: false });
    $('#gen_cal').data("DateTimePicker").setDate(bdate);

      /* Used to cancel update operations and return the form to original values 
        Does not modify information in the database */
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
  });
});
