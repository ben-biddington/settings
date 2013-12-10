require "spec_helper"

describe BasicDiskSettings do
  let(:settings) {BasicDiskSettings.new}

  before do
    settings.clear
  end

  it "can store single setting" do
    settings.set :name => "value"

    expect(settings.get(:name)).to eql "value"
  end

  it "can store multiple settings at once" do
    settings.set :a => "value a", :b => "value b"

    expect(settings.get(:a)).to eql "value a"
    expect(settings.get(:b)).to eql "value b"
  end

  it "overwrites duplicates" do
    settings.set :a => "value a"
    settings.set :a => "another value for a"

    expect(settings.get(:a)).to eql "another value for a"
  end
  
  it "overwrites duplicates even when setting the same setting" do
    settings.set :a => "value a", :a => "another value for a"

    expect(settings.get(:a)).to eql "another value for a"
  end

  it "records all settings when you call set multiple times" do
    settings.set :a => "value a"
    settings.set :b => "value b"

    expect(settings.get(:a)).to_not be_nil
    expect(settings.get(:b)).to_not be_nil
  end
end