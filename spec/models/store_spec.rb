require 'rails_helper'

RSpec.describe Store, type: :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = 'Local Store'

    expect(subject).to be_valid
  end

  it "is not valid without a type"
  it "is not valid without a name"
  it "is not valid without valid configuration"
end
