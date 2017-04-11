class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: "User", foreign_key: :user_id

  # Expose the author's name through an `author_name` method.
  delegate :name, to: :author, prefix: :author, allow_nil: true

  validates :post, presence: true
  validates :author, presence: true
  validates :body, presence: true, length: { maximum: 100_000 }
end
