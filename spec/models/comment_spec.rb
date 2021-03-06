require 'rails_helper'

RSpec.describe ::Comment, type: :model do
  it { should validate_presence_of(:post) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(100_000) }

  # TODO: DRY up author name examples which are shared between Comment and Post.
  describe "#author_name" do
    it "returns the name of the author" do
      author = ::FactoryGirl.build(:user, first_name: "Joe", last_name: "Davis")
      post = ::FactoryGirl.build(:post, author: author)
      expect(post.author_name).to eq("Joe Davis")
    end

    it "returns nil when no author is present" do
      post = ::FactoryGirl.build(:post, author: nil)
      expect(post.author_name).to be_nil
    end
  end

  describe "#content" do
    it "returns the body with markdown processing" do
      post = ::FactoryGirl.build(:comment, body: "Hello, **world!**")
      expect(post.content).to eq("<p>Hello, <strong>world!</strong></p>\n")
    end
  end
end
