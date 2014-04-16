$( document ).ready(function() {

	/* Used To Modify form to allow updating of profile information.
		Replaces table cells with input fields to allow user to update information */
	$('#edit-exercise').click(function(){
		var desc = $('#Exercise_Desc').html();
		var cal = $('#Exercise_Cal').html();
		var date = $('#Exercise_Date').html();
		var time = $('#Exercise_Time').html();
		$('#edit-exercise').before("<button id='Exercise_Cancel' type='button' class='btn btn-default'>Cancel</button><input id='Exercise_Sub' name='commit' type='submit' class='btn btn-default' value='Submit' />");
		$('#edit-exercise').hide();
		$('#del-exercise').hide();
		$('#Exercise_Desc').replaceWith("<td class='table-input' id='Exercise_Desc'><input class='form-control' type='text' name='name' value='"+desc+"'/></td>");
		$('#Exercise_Cal').replaceWith("<td class='table-input' id='Exercise_Cal'><input class='form-control' type='text' name='calories' value='"+cal+"'/></td>");
		$('#Exercise_Date').replaceWith("<td class='table-input' id='Exercise_Date'><div class='input-group date' id='gen_cal'><input class='form-control' type='text' name='day' readonly='readonly'/><span class='input-group-addon'><i class='glyphicon glyphicon-calendar'></i></span></div></td>");
		$('#Exercise_Time').replaceWith("<td class='table-input' id='Exercise_Time'><input class='form-control' type='text' name='time' value='"+time+"'/></td>");
		$('#gen_cal').datetimepicker({pickTime: false });
    	$('#gen_cal').data("DateTimePicker").setDate(date);

    	/* Used to cancel update operations and return the form to original values 
    		Does not modify information in the database */
		$('#Exercise_Cancel').click(function(){
			$('#edit-exercise').show();
			$('#del-exercise').show();
			$('#Exercise_Desc').replaceWith("<td id='Exercise_Desc'>"+desc+"</td>");
			$('#Exercise_Cal').replaceWith("<td id='Exercise_Cal'>"+cal+"</td>");
			$('#Exercise_Date').replaceWith("<td id='Exercise_Date'>"+date+"</td>");
			$('#Exercise_Time').replaceWith("<td id='Exercise_Time'>"+time+"</td>");
			$('#Exercise_Cancel').remove();
			$('#Exercise_Sub').remove();
		});
	});

	// Tooltips
	$('#edit-exercise').tooltip();
	$('#del-exercise').tooltip();
});
