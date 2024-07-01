import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comments"
export default class extends Controller {
  static targets = ["commentDrawIcon"]
  commentArea = document.querySelector(".comments-section");
  connect() {
    this.commentDrawIconTarget.addEventListener("click", this.toggleCommentDrawIcon.bind(this))
    this.commentDrawIconTarget.innerHTML = this.commentArea.classList.contains("hidden") ? "Show" : "Hide";
  }

  toggleCommentDrawIcon() {
    this.commentArea.classList.toggle("hidden");
    this.commentDrawIconTarget.innerHTML = this.commentArea.classList.contains("hidden") ? "Show" : "Hide";
  }
}
