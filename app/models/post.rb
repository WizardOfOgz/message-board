class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :comments

  # Expose the author's name through an `author_name` method.
  delegate :name, to: :author, prefix: :author, allow_nil: true

  validates :title, presence: true, length: { maximum: 127 }
  validates :body, presence: true, length: { maximum: 100_000 }
  validates :author, presence: true
end
