class Task < ApplicationRecord
  include ArrayColumns

  belongs_to :user
  belongs_to :list, optional: true
  accepts_nested_attributes_for :list
  belongs_to :assignee, optional: true, class_name: "User"

  has_rich_text :description

  attribute :labels, type: Array, default: []
  array_columns :labels

  validates :title, presence: true

  def completed? = completed_at.present?

  def completed=(_value)
    if completed_at.present?
      self.completed_at = nil
    else
      self.completed_at = Time.current
    end
  end
end
