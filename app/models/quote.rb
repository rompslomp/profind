class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :service

  enum :status, { pending: 0, responded: 1, closed: 2 }

  validates :message, presence: true
  validates :status, presence: true
end
