$( document ).ready(function() {

	$('#edit-activity').click(function(){
		var desc = $('#Act_Desc').html();
		var loc = $('#Act_Loc').html();
		var date = $('#Act_Date').html();
		var time = $('#Act_Time').html();
		var dur = $('#Act_Dur').html();
		$('#edit-activity').before("<button id='Act_Cancel' type='button' class='btn btn-default'>Cancel</button><input id='Act_Sub' name='commit' type='submit' class='btn btn-default' value='Submit' />");
		$('#edit-activity').hide();
		$('#Act_Desc').replaceWith("<td class='table-input' id='Act_Desc'><input class='form-control' type='text' name='name' value='"+desc+"'/></td>");
		$('#Act_Loc').replaceWith("<td class='table-input' id='Act_Loc'><input class='form-control' type='text' name='location' value='"+loc+"'/></td>");
		$('#Act_Date').replaceWith("<td class='table-input' id='Act_Date'><input class='form-control datepicker' type='text' name='day' readonly='readonly' value='"+date+"'/></td>");
		$('#Act_Time').replaceWith("<td class='table-input' id='Act_Time'><input class='form-control' type='text' name='time' value='"+time+"'/></td>");
		$('#Act_Dur').replaceWith("<td class='table-input' id='Act_Dur'><input class='form-control' type='text' name='length' value='"+dur+"'/></td>");

		$('#Act_Cancel').click(function(){
			$('#edit-activity').show();
			$('#Act_Desc').replaceWith("<td id='Act_Desc'>"+desc+"</td>");
			$('#Act_Loc').replaceWith("<td id='Act_Loc'>"+loc+"</td>");
			$('#Act_Date').replaceWith("<td id='Act_Date'>"+date+"</td>");
			$('#Act_Time').replaceWith("<td id='Act_Time'>"+time+"</td>");
			$('#Act_Dur').replaceWith("<td id='Act_Dur'>"+dur+"</td>");
			$('#Act_Cancel').remove();
			$('#Act_Sub').remove();
		});

		// Init calendar activity creation modals
		$( ".datepicker" ).datepicker({
			todayHighlight: true
		});
	});
});
