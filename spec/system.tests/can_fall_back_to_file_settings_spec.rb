require "spec_helper"

describe "a settings fallback" do
  it "for example, you can fall back to a setting on disk" do
    settings = Settings.new do
      with_settings :chain => [EnvironmentSettings, BasicDiskSettings]
    end

    ENV.clear

    BasicDiskSettings.new do
      clear
      set :jazzs_bike_shorts => "tight"
    end

    expect(settings.jazzs_bike_shorts).to eql "tight"
  end

  it "by default you get environment settings only"
end

class BasicDiskSettings
  require "fileutils"; include FileUtils
  require "audible"; include Audible

  def initialize(&block)
    @file = ".rsettings"
    _ensure
    instance_eval &block if block_given?
  end

  def clear
    rm file
  end

  def set(opts ={})
    require "yaml"

    File.open @file, "w+" do |io|
      io.puts opts.to_yaml
    end 
  end

  def get(name)
    require "yaml"
    opts = YAML.load(IO.read(@file))
    opts[name]
  end

  private

  def _ensure
    touch file
  end

  def file; @file; end
end