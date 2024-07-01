import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="video"
export default class extends Controller {

  static targets = ["closeFlash"]

  connect() {
    this.closeFlashTarget.addEventListener("click", () => {
      this.element.remove();
    })
  }

}
