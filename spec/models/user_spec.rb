require "rails_helper"

describe ::User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:description).is_at_most(4_096) }
end
