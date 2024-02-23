class Session < ApplicationRecord
  belongs_to :user

  validates :user_agent, presence: true
  validates :ip_address, presence: true
end
