import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="car-park"
export default class extends Controller {

  formSubmitEnd(e) {
   if (e.detail.success) {
     this.hideModal()
   }
  }

  hideModal() {
      this.element.remove()
  }
}
