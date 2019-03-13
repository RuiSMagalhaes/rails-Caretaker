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
  const checkNotifyBefore = document.getElementById('event_notify_before');
  const eventMinutes = document.querySelector('.event_minutes');
  const eventNotifyDone = document.getElementsByClassName("event_notify_done?")[0];
  const checkNotifyDone = document.getElementById('event_notify_done');
  const eventNotifyMissed = document.getElementsByClassName("event_notify_missed?")[0];
  const checkNotifyMissed = document.getElementById('event_notify_missed');
  const checkNotificationsBox = document.getElementById('event_notifications');

  if(checkRecurringBox.checked){
    recurringTimes.classList.remove("hidden");
    eventHours.classList.remove("hidden");
    eventDays.classList.remove("hidden");
    eventWeeks.classList.remove("hidden");
    eventMonths.classList.remove("hidden");
  } else {
    recurringTimes.classList.add("hidden");
    eventHours.classList.add("hidden");
    eventDays.classList.add("hidden");
    eventWeeks.classList.add("hidden");
    eventMonths.classList.add("hidden");
  }

  checkRecurringBox.addEventListener('change', (event) => {
    if(checkRecurringBox.checked){
      recurringTimes.classList.remove("hidden");
      eventHours.classList.remove("hidden");
      eventDays.classList.remove("hidden");
      eventWeeks.classList.remove("hidden");
      eventMonths.classList.remove("hidden");
    } else {
      recurringTimes.classList.add("hidden");
      eventHours.classList.add("hidden");
      eventDays.classList.add("hidden");
      eventWeeks.classList.add("hidden");
      eventMonths.classList.add("hidden");
    }
  });

  if(checkNotifyBefore.checked || checkNotifyDone.checked || checkNotifyMissed.checked){
    checkNotificationsBox.checked = true;
    eventNotifyBefore.classList.remove("hidden");
    eventMinutes.classList.remove("hidden");
    eventNotifyDone.classList.remove("hidden");
    eventNotifyMissed.classList.remove("hidden");
  } else {
    eventNotifyBefore.classList.add("hidden");
    eventMinutes.classList.add("hidden");
    eventNotifyDone.classList.add("hidden");
    eventNotifyMissed.classList.add("hidden");
  }

  checkNotificationsBox.addEventListener('change', (event) => {
    if(checkNotificationsBox.checked){
      eventNotifyBefore.classList.remove("hidden");
      eventMinutes.classList.remove("hidden");
      eventNotifyDone.classList.remove("hidden");
      eventNotifyMissed.classList.remove("hidden");
    } else {
      eventNotifyBefore.classList.add("hidden");
      eventMinutes.classList.add("hidden");
      eventNotifyDone.classList.add("hidden");
      eventNotifyMissed.classList.add("hidden");
    }
  });
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

// js timer to check notifications do or missed
const index = document.querySelector('.index')
const full_index = document.querySelector('.full_index')
const show = document.querySelector('.show')
if (index || full_index || show) {
  setTimeout(function(){
     window.location.reload(1);
  }, 15000);
}
