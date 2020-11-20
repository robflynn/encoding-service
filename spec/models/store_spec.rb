require 'rails_helper'

RSpec.describe Store, type: :model do
  subject {
    described_class.new(
      name: 'Local Store',
      type: 'Store::LocalStore'
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a type" do
    subject.type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a valid type" do
    subject.type = 'Store::ThisStoreDoesNotExist'
    expect(subject).to_not be_valid
  end

  it "is not valid without valid configuration" do
    subject.configuration = 'improper configuration'
    expect(subject).to_not be_valid
  end
end
