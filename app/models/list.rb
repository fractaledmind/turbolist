class List < ApplicationRecord
  has_rich_text :description
  has_one_attached :avatar

  validates :title, presence: true
end
