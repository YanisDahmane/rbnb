import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hideModal() {
    this.element.parentElement.removeAttribute("src") // it might be nice to also remove the modal SRC
    this.element.remove()
  }
}
