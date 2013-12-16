require "spec_helper"

describe "default values for missing settings" do
  it "can be configured to use a default when setting is missing" do
    settings = Settings.new do
      default :colour, :to => "red"
    end

    expect(settings.colour).to eql "red"
  end

  it "can be overwritten -- the last set one wins" do
    settings = Settings.new do
      default :colour, :to => "red"
      default :colour, :to => "gold"
    end

    expect(settings.colour).to eql "gold"
  end
end