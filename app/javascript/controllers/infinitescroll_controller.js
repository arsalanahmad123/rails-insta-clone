import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infinitescroll"
export default class extends Controller {
  static targets = ["entries", "pagination"]
  scroll() {
    let url = this.paginationTarget.querySelector("a[rel='next']").href
    var body = document.body,
      html = document.documentElement
    var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    if (window.pageYOffset >= height - window.innerHeight - 100) {
      console.log("Reached at bottom");
    }

  }

  loadMore(url) {
    Rails.ajax({
      type: 'GET',
      url: url,
      dataType: 'JSON',
      success: (data) => {
        console.log(data);
      }
    })
  }

}

