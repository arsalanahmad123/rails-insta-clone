import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {

  connect() {
    this.element.addEventListener("click", this.fadeOutFlash.bind(this))
  }
  disconnect() {
    this.element.removeEventListener("click", this.fadeOutFlash.bind(this))
  }

  fadeOutFlash() {
    this.element.classList.add("hidden")
  }
}
