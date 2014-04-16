$( document ).ready(function() {

	/* Used To Modify form to allow updating of profile information.
		Replaces table cells with input fields to allow user to update information */
	$('#edit-food').click(function(){
		var desc = $('#Food_Desc').html();
		var cal = $('#Food_Cal').html();
		var date = $('#Food_Date').html();
		var time = $('#Food_Time').html();
		$('#edit-food').before("<button id='Food_Cancel' type='button' class='btn btn-default'>Cancel</button><input id='Food_Sub' name='commit' type='submit' class='btn btn-default' value='Submit' />");
		$('#edit-food').hide();
		$('#del-food').hide();
		$('#Food_Desc').replaceWith("<td class='table-input' id='Food_Desc'><input class='form-control' type='text' name='name' value='"+desc+"'/></td>");
		$('#Food_Cal').replaceWith("<td class='table-input' id='Food_Cal'><input class='form-control' type='text' name='calories' value='"+cal+"'/></td>");
		$('#Food_Date').replaceWith("<td class='table-input' id='Food_Date'><div class='input-group date' id='gen_cal'><input class='form-control' type='text' name='day' readonly='readonly'/><span class='input-group-addon'><i class='glyphicon glyphicon-calendar'></i></span></div></td>");
		$('#Food_Time').replaceWith("<td class='table-input' id='Food_Time'><input class='form-control' type='text' name='time' value='"+time+"'/></td>");
		$('#gen_cal').datetimepicker({pickTime: false });
    	$('#gen_cal').data("DateTimePicker").setDate(date);

    	/* Used to cancel update operations and return the form to original values 
    		Does not modify information in the database */
		$('#Food_Cancel').click(function(){
			$('#edit-food').show();
			$('#del-food').show();
			$('#Food_Desc').replaceWith("<td id='Food_Desc'>"+desc+"</td>");
			$('#Food_Cal').replaceWith("<td id='Food_Cal'>"+cal+"</td>");
			$('#Food_Date').replaceWith("<td id='Food_Date'>"+date+"</td>");
			$('#Food_Time').replaceWith("<td id='Food_Time'>"+time+"</td>");
			$('#Food_Cancel').remove();
			$('#Food_Sub').remove();
		});
	});

	// Tooltips
	$('#edit-food').tooltip();
	$('#del-food').tooltip();
});
