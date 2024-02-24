class List < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  has_rich_text :description

  validates :title, presence: true
end
