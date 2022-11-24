import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl";

const api = "pk.eyJ1IjoiZmZyY2giLCJhIjoiY2xhMmljeHZ4MGV4cTNvbXpyZWxqMmhyZiJ9.D1iDmKhCgZX4bX5usmbDkQ";


export default class extends Controller {

  static values = {
    url: String
  }

  connect() {
    console.log("Hello from Stidddmdulus!");
    this.fetchInfoRoom();
  }

  showMap(data) {
    console.log("Hello from Mapbox!");
    mapboxgl.accessToken = api;
    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v9",
      center: data,
      zoom: 12
    });
    const nav = new mapboxgl.NavigationControl();
    map.addControl(nav, 'top-left');
    map.scrollZoom.disable();
    new mapboxgl.Marker()
      .setLngLat(data)
      .addTo(map);
  }

  fetchAddress(address) {
    fetch("https://api-adresse.data.gouv.fr/search/?q=" + address)
      .then(response => response.json())
      .then(data => this.showMap(data.features[0].geometry.coordinates));
  }

  fetchInfoRoom() {
    fetch(this.urlValue)
      .then(response => response.json())
      .then(data => this.fetchAddress((data.address.number + " " + data.address.road + " " + data.address.city + " " + data.address.zip_code).replaceAll(" ", "+")));
  }
}
