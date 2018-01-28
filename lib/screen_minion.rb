$stdout.sync = true

require "yaml"

require "screen_minion/version"
require "screen_minion/configuration"
require "screen_minion/listener"
require "screen_minion/uploader"

module ScreenMinion
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end
    alias config configuration

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  class Main
    def initialize
      targets.map do |target|
        Listener.new(target['path'], target['only'], target['bucket_path'])
      end
      sleep
    end

    private

    def targets
      ScreenMinion.config.targets
    end
  end
end
