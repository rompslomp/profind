class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { basic: 0, provider: 1, admin: 2 }
  enum :provider_status, { not_requested: 0, pending: 1, approved: 2, rejected: 3 }

  has_many :services, dependent: :destroy
  has_many :quotes, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name email role provider_status created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def provider_upgrade_pending?
    provider_status == "pending"
  end

  def approved_provider?
    provider? && approved?
  end
end
