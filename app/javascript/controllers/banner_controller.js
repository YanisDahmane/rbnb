import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';


// Connects to data-controller="banner"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["dentists ^1000", "doctors ^1000", "nurses ^1000", "psychologists ^1000", "chiropractors ^1000"],
      typeSpeed: 60,
      loop: true
    })
  }
}
