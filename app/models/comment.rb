class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :post, presence: true
  validates :user, presence: true
  validates :body, presence: true, length: { maximum: 100_000 }
end
