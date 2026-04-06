class Service < ApplicationRecord
  belongs_to :user
  has_many :service_tags, dependent: :destroy
  has_many :tags, through: :service_tags
  has_many :quotes, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :description, presence: true

  scope :by_approved_providers, -> {
    joins(:user).where(users: { role: User.roles[:provider], provider_status: User.provider_statuses[:approved] })
  }

  scope :search_by_tag, ->(tag_id) { joins(:service_tags).where(service_tags: { tag_id: tag_id }) }

  scope :search_by_text, ->(query) {
    where("title ILIKE :q OR description ILIKE :q", q: "%#{sanitize_sql_like(query)}%")
  }
end
