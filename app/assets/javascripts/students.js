$(".students.lessons").ready( function() {
	$.fn.bootstrapSwitch.defaults.size = 'large';
	var checkbox = $("[name='my-checkbox']");
	checkbox.bootstrapSwitch( {onText: 'Ready', offText: 'Not Ready', onColor: 'success', offColor: 'danger'});
});