require "rails_helper"

RSpec.describe ::User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:description).is_at_most(4_096) }

  describe "#name" do
    it "concats first and last name" do
      subject = described_class.new(first_name: "Jon", last_name: "Smith")
      expect(subject.name).to eq("Jon Smith")
    end

    it "returns proper value when first_name is nil" do
      subject = described_class.new(first_name: nil, last_name: "Smith")
      expect(subject.name).to eq("Smith")
    end

    it "returns proper value when last_name is nil" do
      subject = described_class.new(first_name: "Jon", last_name: nil)
      expect(subject.name).to eq("Jon")
    end
  end
end
