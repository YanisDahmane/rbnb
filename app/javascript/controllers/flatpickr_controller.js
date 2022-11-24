import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static values = {
    url: String
  }

  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime" ]

  connect() {
    this.fetchInfoRoom();
  }

  fetchInfoRoom() {
    fetch(this.urlValue)
      .then(response => response.json())
      .then(data => this.fetchUnavailableDates(data.booked));
  }

  fetchUnavailableDates(booked) {
    flatpickr(this.startTimeTarget, {
      enableTime: true,
      disable: booked,
      // Provide an id for the plugin to work
      plugins: [new rangePlugin({ input: "#end_time"})]})
    flatpickr(this.endTimeTarget, {})
  }
}
