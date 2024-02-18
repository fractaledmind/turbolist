import { Controller } from '@hotwired/stimulus'

// adapted from: https://github.com/stimulus-components/stimulus-rails-autosave
export default class extends Controller {
  static values = {
    delay: {
      type: Number,
      default: 150,
    },
  }

  initialize() {
    this.save = this.save.bind(this)
  }

  connect() {
    if (this.delayValue > 0) {
      this.save = this.#debounce(this.save, this.delayValue)
    }
  }

  save() {
    this.element.requestSubmit()
  }

  #debounce(callback, delay) {
    let timeout;

    return (...args) => {
      clearTimeout(timeout)

      timeout = setTimeout(() => {
        callback.apply(this, args)
      }, delay)
    }
  }
}
