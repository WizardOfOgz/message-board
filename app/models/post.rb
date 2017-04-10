class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { maximum: 127 }
  validates :body, presence: true, length: { maximum: 100_000 }
  validates :user, presence: true
end
