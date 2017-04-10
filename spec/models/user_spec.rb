require "rails_helper"

describe ::User do
  it { should validate_length_of(:description).is_at_most(4_096) }
end
