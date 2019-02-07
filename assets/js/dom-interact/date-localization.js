// %B %d, %Y %H:%M:%S %z
import { DateTime } from "luxon";

document.addEventListener('DOMContentLoaded', () => {
  const dateElements = document.querySelectorAll(".js-date-string.js-localized");
  const timeElements = document.querySelectorAll(".js-time-string.js-localized");

  dateElements.forEach((element) => {
    const timeSeconds = parseInt(element.innerHTML.trim());
    if(isNaN(timeSeconds)) return;

    const dateTime = DateTime.fromSeconds(timeSeconds);

    element.dataset.originalTimeSeconds = timeSeconds;
    element.innerHTML = dateTime.toLocaleString({
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
      timeZoneName: 'short'
    });
  });

  timeElements.forEach((element) => {
    const timeSeconds = parseInt(element.innerHTML.trim());
    if(isNaN(timeSeconds)) return;

    const dateTime = DateTime.fromFormat(timeSeconds, 'HH:mm');
    element.dataset.originalTimeSeconds = timeSeconds;

    element.innerHTML = dateTime.toLocaleString(DateTime.TIME_SIMPLE); //=> '11:32 AM'
  })
});
