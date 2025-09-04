import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="create-ride"
export default class extends Controller {
  static targets = ["map", "origin", "destination", "form"];

  initialize() {
    mapboxgl.accessToken =
      "pk.eyJ1Ijoia2F5bGVnIiwiYSI6ImNtNHd0aHJ0cjBrbWYybHB0M2x1dnRsZGQifQ.eRx7BfFOoAe9Hk5_bXdqFA";
  }

  mapTargetConnected() {
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v9",
      zoom: 11,
      center: [-80.1, 26.5],
    });
    this.map.setPadding({ top: 200, bottom: 44, left: 20, right: 20 });

    const originGeocoder = new MapboxGeocoder({
      mapboxgl,
      accessToken: mapboxgl.accessToken,
      proximity: "ip",
      enableGeolocation: true,
      flyTo: true,
      placeholder: "Pick up Address",
      marker: {
        color: "green",
        draggable: false,
      },
    });
    originGeocoder.mapboxgl = mapboxgl;
    originGeocoder.on("result", (event) => {
      this.origin = event.result;
      this.fitToRide();
      this.map.addControl(this.destinationGeocoder, "top");
    });
    this.map.addControl(originGeocoder, "top");

    this.destinationGeocoder = new MapboxGeocoder({
      mapboxgl,
      accessToken: mapboxgl.accessToken,
      proximity: "ip",
      enableGeolocation: true,
      flyTo: false,
      placeholder: "Drop off Address",
      marker: {
        color: "red",
        draggable: false,
      },
    });
    this.destinationGeocoder.mapboxgl = mapboxgl;
    this.destinationGeocoder.on("result", (event) => {
      this.destination = event.result;
      this.fitToRide();
      this.createRide();
    });
  }

  mapTargetDisconnected() {
    this.map.remove();
  }

  fitToRide() {
    if (!this.origin || !this.destination) {
      return;
    }

    this.map.fitBounds([
      this.origin.geometry.coordinates,
      this.destination.geometry.coordinates,
    ]);
  }

  createRide() {
    fetch(window.location + "/rides", {
      method: "post",
      body: {
        authenticity_token:
          this.formTarget.elements["authenticity_token"].value,
        ride: {
          origin_address: this.origin.place_name,
          origin_coordinate: JSON.stringify(this.origin.geometry),
          destination_address: this.destination.place_name,
          destination_coordinate: JSON.stringify(this.destination.geometry),
        },
      },
    });
  }
}
