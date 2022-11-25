import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl";

const api = "pk.eyJ1IjoiZmZyY2giLCJhIjoiY2xhMmljeHZ4MGV4cTNvbXpyZWxqMmhyZiJ9.D1iDmKhCgZX4bX5usmbDkQ";


export default class extends Controller {

  static allRoomApi;

  connect() {
    console.log("Hello from Stimddddudlus!");
    fetch("http://localhost:3000/api")
    .then(response => response.json()
    .then(data => {this.allRoomdata = data; this.showMap()}));
  }

  showMap() {
    console.log("Hello from Mapbox!");
    mapboxgl.accessToken = api;
    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v9",
      center: [2.213749, 46.227638],
      zoom: 5
    });
    const nav = new mapboxgl.NavigationControl();
    map.addControl(nav, 'top-left');
    map.scrollZoom.disable();
    fetch("http://localhost:3000/api")
      .then(response => response.json()
      .then(data => {this.showAllPoint(map)}));
  }

  showAllPoint(map) {
    for (const [key, value] of Object.entries(this.allRoomdata)) {
      new mapboxgl.Marker().setLngLat([value["address"]["coo_gps_long"], value["address"]["coo_gps_lat"]]).setPopup(new mapboxgl.Popup().setHTML(value["html"])).addTo(map);
    }
  }
}
