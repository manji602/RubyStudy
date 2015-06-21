class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  default_scope -> { order('created_at ASC') }

  validates :entry_id, presence: true
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 1000 }
end
