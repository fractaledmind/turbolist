// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import "trix"
import "@rails/actiontext"

const element = document.querySelector("trix-editor")
element.addEventListener("keydown", event => {
  if (event.key == "Enter" && event.metaKey) {
    event.preventDefault()
    element.inputElement.form.requestSubmit()
  }
})
