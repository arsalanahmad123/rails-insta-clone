import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="postform"
export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:submit-end", this.submitEnd.bind(this))
  }

  submitEnd(event) {
    this.element.reset()
  }

}
