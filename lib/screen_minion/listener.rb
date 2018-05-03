require 'listen'
require 'terminal-notifier'

module ScreenMinion
  class Listener
    def initialize(path, only_regex, bucket_path)
      @path = File.expand_path(path)
      @only_regex = /#{only_regex}/
      @bucket_path = bucket_path
      listener.start
    end

    private

    def listener
      @listener ||= Listen.to(@path, only: @only_regex) do |modified, added, _removed|
        if !(modified.empty? && added.empty?)
          response = uploader.upload_file(@bucket_path, (modified.empty? ? added[0] : modified[0]))
          url = URI.escape(response["url"])
          puts "Uploaded file: #{@path}"
          puts "#{url}\n"
          `echo #{url} | /usr/bin/pbcopy`
          TerminalNotifier.notify("Successful Upload: #{url}")
        end
      end
    end

    def uploader
      ScreenMinion::Uploader.new
    end
  end
end
