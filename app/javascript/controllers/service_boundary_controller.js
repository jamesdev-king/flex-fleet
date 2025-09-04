import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="service-boundary"
export default class extends Controller {
  static targets = ["container", "formField"];
  static values = {
    editable: { type: Boolean, default: true },
    polygon: { type: Object, default: null },
  };

  initialize() {
    mapboxgl.accessToken =
      "pk.eyJ1Ijoia2F5bGVnIiwiYSI6ImNtNHd0aHJ0cjBrbWYybHB0M2x1dnRsZGQifQ.eRx7BfFOoAe9Hk5_bXdqFA";
  }

  containerTargetConnected() {
    this.map = new mapboxgl.Map({
      container: this.containerTarget,
      style: "mapbox://styles/mapbox/streets-v9",
      zoom: 11,
      center: [-80.1, 26.5],
    });

    if (this.editableValue) {
      this.draw = new MapboxDraw({
        displayControlsDefault: false,
        // Select which mapbox-gl-draw control buttons to add to the map.
        controls: {
          polygon: true,
          trash: true,
        },
        // Set mapbox-gl-draw to draw by default.
        // The user does not have to click the polygon control button first.
        defaultMode: this.polygonValue ? "simple_select" : "draw_polygon",
      });
      if (this.polygonValue) {
        this.map.on("load", () => {
          this.fitToBoundary();
          this.draw.add(this.polygonValue);
        });
      }
      this.map.addControl(this.draw);
      this.map.on("draw.create", () => this.updateFormField());
      this.map.on("draw.delete", () => this.updateFormField());
      this.map.on("draw.update", () => this.updateFormField());
    } else if (this.polygonValue) {
      this.map.on("load", () => {
        this.fitToBoundary();
        this.map.addSource("boundary", {
          type: "geojson",
          data: this.polygonValue,
        });

        this.map.addLayer({
          id: "boundary",
          type: "fill",
          source: "boundary", // reference the data source
          layout: {},
          paint: {
            "fill-color": "#0080ff", // blue color fill
            "fill-opacity": 0.5,
          },
        });
        this.map.addLayer({
          id: "outline",
          type: "line",
          source: "boundary",
          layout: {},
          paint: {
            "line-color": "#000",
            "line-width": 3,
          },
        });
      });
    }
  }

  containerTargetDisconnected() {
    this.map.remove();
  }

  updateFormField() {
    const feature = this.draw.getAll().features[0];
    if (!feature) {
      this.formFieldTarget.value = "";
      return;
    }
    this.formFieldTarget.value = JSON.stringify(feature);
  }

  fitToBoundary() {
    if (this.polygonValue) {
      const coordinates = this.polygonValue.coordinates[0];

      const bounds = coordinates.reduce(
        function (bounds, coord) {
          return bounds.extend(coord);
        },
        new mapboxgl.LngLatBounds(coordinates[0], coordinates[0]),
      );

      this.map.fitBounds(bounds, {
        padding: 20,
      });
    }
  }
}
