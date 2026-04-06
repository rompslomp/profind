class Tag < ApplicationRecord
  has_many :service_tags, dependent: :destroy
  has_many :services, through: :service_tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
