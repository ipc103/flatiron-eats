
$(function() {
  var dateToday = new Date();
  $( "#datepicker" ).datetimepicker({
    // format: 'MM-DD-YYYY HH:MM',
    minDate: dateToday,
    sideBySide: true
    // dateFormat: "yyyy-mm-dd"
  });
});