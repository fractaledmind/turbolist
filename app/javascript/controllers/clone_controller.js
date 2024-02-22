import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clone"
export default class extends Controller {
  static targets = [ "template" ]

  connect() {
  }

  execute(event) {
    const clone = this.templateTarget.content.cloneNode(true)
    const value = event.target.value

    clone.querySelectorAll('[data-placeholder]').forEach((element) => {
      element.textContent = value
      element.removeAttribute('data-placeholder')
    })
    clone.querySelectorAll('[data-attribute-placeholder]').forEach((element) => {
      let attributeNames = element.dataset.attributePlaceholder
      attributeNames.split(" ").forEach(attributeName => {
        let attribute = element.getAttribute(attributeName)

        let newValue
        if (attribute.includes("PLACEHOLDER")) {
          newValue = attribute.replace("PLACEHOLDER", value)
        } else {
          newValue = value
        }

        element.setAttribute(attributeName, newValue)
      })
      element.removeAttribute('data-attribute-placeholder')
    })
    clone.querySelector("label").dataset.cloned = true

    this.element.querySelectorAll('[data-cloned]').forEach(el => el.remove())

    if (value.length > 0) {
      this.templateTarget.parentElement.appendChild(clone)
    }
  }
}
