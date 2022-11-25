// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "typed.js"

// Entry point for the build script in your package.json

// Création du lien entre le bouton contact et son contenu
const modalContainer = document. querySelector(".modal-container");// selectionne le premier élément avec pour classe .modal-container
const modalTriggers = document. querySelectorAll(".modal-trigger"); // selectionne tous les éléments .modal-trigger

modalTriggers.forEach(trigger => trigger.addEventListener("click", toggleModal));
// pour chaque evenement trigger,

function toggleModal() {
  modalContainer.classList.toggle("active")

}
