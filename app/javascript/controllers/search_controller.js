import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "input" ]

  connect() {
  }

  execute(event) {
    const value = event.target.value.toLowerCase()
    this.inputTargets.forEach((input) => {
      const searchValue = input.dataset.searchTextValue.toLowerCase()
      if (searchValue.includes(value)) {
        input.parentElement.style.display = null
      } else if (input.checked) {
        input.parentElement.style.display = null
      } else {
        input.parentElement.style.display = "none"
      }
    })
  }
}
