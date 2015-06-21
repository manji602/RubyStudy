class Entry < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }

  validates :blog_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 3000 }
end
