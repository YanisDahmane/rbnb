import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "navitem", "g", "price_max", "size_min", "category", "deck" ];

  static allRoomApi;

  connect() {
    // Récupération de toutes les rooms de l'api
    fetch("/api")
      .then(response => response.json()
      // On stocke les rooms dans une variable
      .then(data => {this.allRoomdata = data}));
  }

  find(event){
    // Création d'une requête pour récupérer les rooms correspondantes aux recherches
    fetch("/api?g=" + this.getRequest())
      .then(response => response.json()
      .then(data => {
        // Suppression des rooms affichées
        this.deckTarget.innerHTML = "";
        // On boucle sur les rooms récupérées
        for (const [key, value] of Object.entries(data)) {
          // On affiche les rooms
          this.deckTarget.innerHTML += value["html"];
        }
        // Si aucune rooms n'est trouvée
        if (this.deckTarget.innerHTML == ""){
          // On affiche un message
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

  // On crée la requête avec les query correspondantes
  getRequest(){
    let result = "";
    if(this.gTarget.value != ""){
      // Recherche globale
      result += "&g=" + this.gTarget.value.replace(" ", ",");
    }
    if(this.price_maxTarget.value != ""){
      // Recherche par prix max
      result += "&price_max=" + this.price_maxTarget.value;
    }
    if(this.size_minTarget.value != ""){
      // Recherche par taille min
      result += "&size_min=" + this.size_minTarget.value;
    }
    if(this.categoryTarget.value != "All categories"){
      // Recherche par catégorie
      result += "&category=" + this.categoryTarget.value;
    }
    return result;
  }
}
