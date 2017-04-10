require 'rails_helper'

RSpec.describe ::Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it { should validate_length_of(:title).is_at_most(127) }
  it { should validate_length_of(:body).is_at_most(100_000) }
end