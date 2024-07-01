import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileIcon", "mobileMenu"]
  connect() {
    this.mobileIconTarget.addEventListener("click", this.toggleNavigation.bind(this))
  }
  disconnect() {
    this.mobileIconTarget.removeEventListener("click", this.toggleNavigation.bind(this))
  }
  toggleNavigation() {
    // toggle with animation 
    this.mobileMenuTarget.classList.toggle("hidden")
  }
}
