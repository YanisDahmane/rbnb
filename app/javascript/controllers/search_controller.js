import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "navitem", "g", "price_max", "size_min", "category", "deck" ];

  static allRoomApi;

  connect() {
    console.log("ok");
    fetch("http://localhost:3000/api")
      .then(response => response.json()
      .then(data => {this.allRoomdata = data}));
  }

  find(event){
    fetch("http://localhost:3000/api?g=" + this.getRequest())
      .then(response => response.json()
      .then(data => {
        this.deckTarget.innerHTML = "";
        for (const [key, value] of Object.entries(data)) {
          this.deckTarget.innerHTML += value["html"];
        }
        if (this.deckTarget.innerHTML == ""){

          const html = `<div class="booking-card">
          <img class="card-img-top" src="https://cdn.dribbble.com/users/734476/screenshots/4020070/media/30772f1672c8d5f5475cf1066044fb8b.png" alt="not found">
          <div class="booking-card-content">
            <h5 class="card-title">No result 😢</h5>
            <p class="card-text">You should broaden your search. 😅</p>
          </div>
          </div>`
          this.deckTarget.innerHTML = html;
        }
       }));
  }

  getRequest(){
    let result = "";
    if(this.gTarget.value != ""){
      result += "&g=" + this.gTarget.value;
    }
    if(this.price_maxTarget.value != ""){
      result += "&price_max=" + this.price_maxTarget.value;
    }
    if(this.size_minTarget.value != ""){
      result += "&size_min=" + this.size_minTarget.value;
    }
    if(this.categoryTarget.value != "All categories"){
      result += "&category=" + this.categoryTarget.value;
    }
    return result;
  }

  showRooms(param) {
    this.deckTarget.innerHTML = "";
    for (const [key, value] of Object.entries(this.allRoomdata)) {
      if(param == "Tout" || value["category"] == param){
        this.deckTarget.innerHTML += value["html"];
      }
    }
  }
}
