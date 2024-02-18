class Task < ApplicationRecord
  has_rich_text :description

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
