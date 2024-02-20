// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FormController from "./form_controller"
import AutosaveController from "./autosave_controller"
import CheckboxesController from "./checkboxes_controller"
import EmojiPickerController from "./emoji_picker_controller"
application.register("form", FormController)
application.register("autosave", AutosaveController)
application.register("checkboxes", CheckboxesController)
application.register("emoji-picker", EmojiPickerController)
