class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }
end
