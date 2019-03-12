import "flatpickr/dist/flatpickr.css"

import flatpickr from 'flatpickr';

const startDateinput = document.getElementById('event_start_time');
const endDateinput = document.getElementById('event_end_time');

if (startDateinput && endDateinput) {
  flatpickr(startDateinput, {
  minDate: 'today',
  dateFormat: 'Y-m-d H:i',
  enableTime: true,
  time_24hr: true,
  onChange: function(_, selectedDate) {
    if (selectedDate === '') {
      return endDateinput.disabled = true;
    }
    endDateCalendar.set('minDate', selectedDate);
    endDateinput.disabled = false;
    }
  });
  const endDateCalendar =
  flatpickr(endDateinput, {
    dateFormat: 'Y-m-d H:i',
    enableTime: true,
    time_24hr: true,
  });
}
