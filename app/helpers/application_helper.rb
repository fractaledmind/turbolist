module ApplicationHelper
  def icon(name, classes: nil)
    tag.svg class: class_names("bi bi--#{name}", classes), fill: "currentColor", width: 16, height: 16, viewPath: "0 0 16 16" do
      tag.use nil, 'xlink:href': image_path("bootstrap-icons.svg##{name}"), role: :presentation
    end
  end
end
