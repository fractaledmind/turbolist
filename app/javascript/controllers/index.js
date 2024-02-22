// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AutosaveController from "./autosave_controller"
application.register("autosave", AutosaveController)

import CheckboxesController from "./checkboxes_controller"
application.register("checkboxes", CheckboxesController)

import EmojiPickerController from "./emoji_picker_controller"
application.register("emoji-picker", EmojiPickerController)

import FormController from "./form_controller"
application.register("form", FormController)

import TaskLabelsController from "./task_labels_controller"
application.register("task-labels", TaskLabelsController)
