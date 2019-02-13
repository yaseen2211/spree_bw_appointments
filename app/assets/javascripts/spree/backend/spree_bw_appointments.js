// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'

//= require moment 
//= require fullcalendar
//= require daterangepicker
//= require fullcalendar/gcal

var date_range_picker;
date_range_picker = function() {
  $('.date-range-picker').each(function(){
    $(this).daterangepicker({
        timePicker: true,
        timePickerIncrement: 30,
        alwaysShowCalendars: true
    }, function(start, end, label) {
      $('.start_hidden').val(start.format('YYYY-MM-DD HH:mm'));
      $('.end_hidden').val(end.format('YYYY-MM-DD HH:mm'));
    });
  })
};

$(function(){
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next',
			center: 'title',
			right: ''
		},
		defaultView: 'agendaWeek',
		selectable: true,
		selectHelper: true,
		editable: true,
		eventLimit: true,
		events: '/admin/appointments.json',
		select: function(start, end){
			$.getScript('/admin/appointments/new', function(){
				$('#appointment_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
		        $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
		        $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
			})
		},

		eventDrop: function(event, delta, revertFunc) {
	        event_data = { 
	          appointment: {
	            id: event.id,
	            start: event.start.format(),
	            end: event.end.format()
	          }
	        };

	        console.log(event_data);
	        $.ajax({
	            url: event.update_url,
	            data: event_data,
	            type: 'PATCH'
	        });
      	},
      
		eventClick: function(event, jsEvent, view) {
			$.getScript(event.edit_url, function() {
			  $('#event_date_range').val(moment(event.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end).format("MM/DD/YYYY HH:mm"))
			  $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
			  $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
			});
		}

	});
})

