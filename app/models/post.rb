class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 127 }
  validates :body, presence: true, length: { maximum: 100_000 }
  validates :user, presence: true
end
