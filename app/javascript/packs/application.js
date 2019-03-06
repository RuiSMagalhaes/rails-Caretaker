import "bootstrap";

const eventsEdit = document.querySelector('.events.edit');
const eventsNew = document.querySelector('.events.new');
if (eventsEdit || eventsNew) {
  const recurringTimes = document.querySelector('.event_recurring_times');
  const eventHours = document.querySelector('.event_hours');
  const eventDays = document.querySelector('.event_days');
  const eventWeeks = document.querySelector('.event_weeks');
  const eventMonths = document.querySelector('.event_months');
  const checkBox = document.getElementById('event_recurring');
  checkBox.addEventListener('change', (event) => {
    recurringTimes.classList.toggle("hidden");
    eventHours.classList.toggle("hidden");
    eventDays.classList.toggle("hidden");
    eventWeeks.classList.toggle("hidden");
    eventMonths.classList.toggle("hidden");
  })
}
