# == Schema Information
#
# Table name: stores
#
#  id                    :bigint           not null, primary key
#  type                  :string
#  name                  :string
#  secured_configuration :text             default("{}")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_stores_on_type  (type)
#
require 'rails_helper'

RSpec.describe Store, type: :model do
  subject {
    described_class.new(
      name: 'Local Store',
      type: 'Store::LocalStore'
    )
  }

  let(:download_path) {
    Rails.root.join("tmp", "test", "downloads")
  }

  before do
    FileUtils.mkdir_p(download_path) unless File.exists? download_path
  end

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

  it "can download an asset" do
    s = Store.new(type: 'Store::S3Store', name: 'Test Store')
    a = Asset.new
    a.store = s
    a.file_path = 'file.txt'

    file_path = s.download(a, to: download_path, as: "file.txt" )

    expect(File.exists?(file_path)).to be true
  end
end
