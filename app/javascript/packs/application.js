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
  document.addEventListener("DOMContentLoaded", (event) => {
    recurringTimes.classList.add("hidden");
    eventHours.classList.add("hidden");
    eventDays.classList.add("hidden");
    eventWeeks.classList.add("hidden");
    eventMonths.classList.add("hidden");
  })
  checkBox.addEventListener('change', (event) => {
    recurringTimes.classList.toggle("hidden");
    eventHours.classList.toggle("hidden");
    eventDays.classList.toggle("hidden");
    eventWeeks.classList.toggle("hidden");
    eventMonths.classList.toggle("hidden");
  })
}

const profileNotifications = document.querySelector('.notifications.index');
const allNotifications = document.querySelector('.notifications.full_index');
if (profileNotifications || allNotifications) {
  const notificationsAllFilters = document.querySelector('.notifications-all-filters');
  const showMore = document.querySelector('#show-more');
  showMore.addEventListener('click', (event) => {
    notificationsAllFilters.classList.toggle("closed");
  })
}
const profileEvents = document.querySelector('.events.index')
const allEvents = document.querySelector('.events.full_index')
if (profileEvents || allEvents) {
  const eventsAllFilters = document.querySelector('.events-all-filters');
  const showMore = document.querySelector('#show-more');
  showMore.addEventListener('click', (event) => {
    eventsAllFilters.classList.toggle("closed");
  })
}
