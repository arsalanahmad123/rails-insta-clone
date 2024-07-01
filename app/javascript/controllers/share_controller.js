import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {

  result = document.getElementById("shareData")
  url = this.element.getAttribute("data-share-url-value")
  connect() {
    this.element.addEventListener("click", this.showShare.bind(this))
    window.addEventListener("click", this.hideShare.bind(this));
  }

  showShare(e) {
    e.stopPropagation();
    this.result.classList.toggle("hidden")
    navigator.clipboard.writeText(this.url);
    const copyMessage = document.createElement('div');
    copyMessage.className = 'bg-slate-100 text-indigo-500 text-center py-2 px-4 mb-5 animate-jump';
    copyMessage.textContent = 'Copied to clipboard.... Now share it';
    this.result.prepend(copyMessage);
    setTimeout(() => {
      copyMessage.remove();
    }, 2000);
  }

  hideShare(event) {
    if (!event.target.closest("#shareData")) {
      this.result.classList.add("hidden")
    }
  }


}
