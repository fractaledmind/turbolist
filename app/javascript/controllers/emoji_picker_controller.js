import { Controller } from "@hotwired/stimulus"
import 'emoji-picker-element';

export default class extends Controller {
  static targets = [ "input", "popover" ]

  connect() {
    this.element[this.identifier] = this
    this.element.querySelector('emoji-picker').addEventListener('emoji-click', e => {
      if (this.hasInputTarget) {
        this.inputTarget.value = e.detail.unicode
      }
      this.popoverTarget.hidePopover()
    })
  }
}
