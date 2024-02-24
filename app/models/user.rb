class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
