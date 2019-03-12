import "bootstrap";
import "../components/datepicker";

const eventsEdit = document.querySelector('.events.edit');
const eventsNew = document.querySelector('.events.new');
if (eventsEdit || eventsNew) {
  const recurringTimes = document.querySelector('.event_recurring_times');
  const eventHours = document.querySelector('.event_hours');
  const eventDays = document.querySelector('.event_days');
  const eventWeeks = document.querySelector('.event_weeks');
  const eventMonths = document.querySelector('.event_months');
  const checkRecurringBox = document.getElementById('event_recurring');
  const eventNotifyBefore = document.getElementsByClassName("event_notify_before?")[0];
  const eventMinutes = document.querySelector('.event_minutes');
  const eventNotifyDone = document.getElementsByClassName("event_notify_done?")[0];
  const eventNotifyMissed = document.getElementsByClassName("event_notify_missed?")[0];
  const checkNotificationsBox = document.getElementById('event_notifications');
  checkRecurringBox.addEventListener('change', (event) => {
    recurringTimes.classList.toggle("hidden");
    eventHours.classList.toggle("hidden");
    eventDays.classList.toggle("hidden");
    eventWeeks.classList.toggle("hidden");
    eventMonths.classList.toggle("hidden");
  })
  checkNotificationsBox.addEventListener('change', (event) => {
    eventNotifyBefore.classList.toggle("hidden");
    eventMinutes.classList.toggle("hidden");
    eventNotifyDone.classList.toggle("hidden");
    eventNotifyMissed.classList.toggle("hidden");
  })
}

// filter for notifications
// select pages to run
const profileNotifications = document.querySelector('.notifications.index');
const allNotifications = document.querySelector('.notifications.full_index');
if (profileNotifications || allNotifications) {
  // grab container
  const notificationsAllFilters = document.querySelector('.notifications-all-filters');
  // grab button
  const showMore = document.querySelector('#show-more');
  // on click togle the class that opens or close
  showMore.addEventListener('click', (event) => {
    notificationsAllFilters.classList.toggle("closed");
  })
}
// filter for events
// select pages to run
const profileEvents = document.querySelector('.events.index')
const allEvents = document.querySelector('.events.full_index')
if (profileEvents || allEvents) {
  // grab container
  const eventsAllFilters = document.querySelector('.events-all-filters');
  // grab button
  const showMore = document.querySelector('#show-more');
  // on click togle the class that opens or close
  showMore.addEventListener('click', (event) => {
    eventsAllFilters.classList.toggle("closed");
  })
}
