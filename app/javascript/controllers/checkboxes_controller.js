import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['child']

  connect() {
  }

  deselectAllAndSubmit(e) {
    e.preventDefault()

    this.childTargets.forEach(checkbox => {
      checkbox.checked = false
    })

    this.childTargets[0].form.requestSubmit()
  }
}
