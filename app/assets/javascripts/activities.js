$( document ).ready(function() {

	/* Used To Modify form to allow updating of Activity information.
		Replaces table cells with input fields to allow user to update information */
	$('#edit-activity').click(function(){
		var desc = $('#Act_Desc').html();
		var loc = $('#Act_Loc').html();
		var date = $('#Act_Date').html();
		var time = $('#Act_Time').html();
		var dur = $('#Act_Dur').html();
		$('#edit-activity').before("<button id='Act_Cancel' type='button' class='btn btn-default'>Cancel</button><input id='Act_Sub' name='commit' type='submit' class='btn btn-default' value='Submit' />");
		$('#edit-activity').hide();
		$('#del-activity').hide();
		$('#Act_Desc').replaceWith("<td class='table-input' id='Act_Desc'><input class='form-control' type='text' name='name' value='"+desc+"'/></td>");
		$('#Act_Loc').replaceWith("<td class='table-input' id='Act_Loc'><input class='form-control' type='text' name='location' value='"+loc+"'/></td>");
		$('#Act_Date').replaceWith("<td class='table-input' id='Act_Date'><div class='input-group date' id='gen_cal'><input class='form-control' type='text' name='day' readonly='readonly'/><span class='input-group-addon'><i class='glyphicon glyphicon-calendar'></i></span></div></td>");
		$('#Act_Time').replaceWith("<td class='table-input' id='Act_Time'><input class='form-control' type='text' name='time' value='"+time+"'/></td>");
		$('#Act_Dur').replaceWith("<td class='table-input' id='Act_Dur'><input class='form-control' type='text' name='length' value='"+dur+"'/></td>");
		$('#gen_cal').datetimepicker({pickTime: false });
    	$('#gen_cal').data("DateTimePicker").setDate(date);

    	/* Used to cancel update operations and return the form to original values 
    		Does not modify information in the database */
		$('#Act_Cancel').click(function(){
			$('#edit-activity').show();
			$('#del-activity').show();
			$('#Act_Desc').replaceWith("<td id='Act_Desc'>"+desc+"</td>");
			$('#Act_Loc').replaceWith("<td id='Act_Loc'>"+loc+"</td>");
			$('#Act_Date').replaceWith("<td id='Act_Date'>"+date+"</td>");
			$('#Act_Time').replaceWith("<td id='Act_Time'>"+time+"</td>");
			$('#Act_Dur').replaceWith("<td id='Act_Dur'>"+dur+"</td>");
			$('#Act_Cancel').remove();
			$('#Act_Sub').remove();
		});
	});

	// Tooltips
	$('#edit-activity').tooltip();
	$('#del-activity').tooltip();
});
