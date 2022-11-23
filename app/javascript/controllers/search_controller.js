import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "navitem", "deck"];

  static allRoomApi;

  connect() {
    console.log("ok");
    fetch("http://localhost:3000/api")
      .then(response => response.json()
      .then(data => {this.allRoomdata = data}));
  }

  find(event){
    this.deckTarget.innerHTML = "";
    for (const [key, value] of Object.entries(this.allRoomdata)) {
      const fullinfo = value["info"]["name"] + value["info"]["description"] + value["category"] + value["address"]["city"] + value["address"]["country"];
      if(fullinfo.toLowerCase().includes(event.target.value.toLowerCase())){
        this.deckTarget.innerHTML += value["html"];
      }
    }
  }

  newSearch(event){
    this.navitemTargets.forEach((item) => {
      item.classList.remove('active');
    });
    event.target.parentElement.classList.add('active');
    this.showRooms(event.target.innerHTML);
  };

  showRooms(param) {
    this.deckTarget.innerHTML = "";
    for (const [key, value] of Object.entries(this.allRoomdata)) {
      if(param == "Tout" || value["category"] == param){
        this.deckTarget.innerHTML += value["html"];
      }
    }
  }
}
