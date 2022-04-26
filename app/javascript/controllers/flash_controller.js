import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("flash stimulus")

    setTimeout(() => {
        this.dismiss()
    }, 5000)
  }

  dismiss() {
    this.element.remove()
  }
}
