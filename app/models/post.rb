class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :comments

  # Expose the author's name through an `author_name` method.
  delegate :name, to: :author, prefix: :author, allow_nil: true

  validates :title, presence: true, length: { maximum: 127 }
  validates :body, presence: true, length: { maximum: 100_000 }
  validates :author, presence: true

  def content
    # In a real production system it would probably be better to render Markdown _before_ saving, or otherwise cache the rendered markdown.
    self.class.markdown_renderer.render(body)
  end

  def self.markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      ::Redcarpet::Render::XHTML.new(
        :escape_html => true,
        :hard_wrap => true,
        :link_attributes => { :style => "color: #5D94E2;" }
      ),
      :no_intra_emphasis => true,
      :autolink => true,
      :tables => true,
      :disable_indented_code_blocks => true,
      :fenced_code_blocks => true,
      :strikethrough => true
    )
  end
end
