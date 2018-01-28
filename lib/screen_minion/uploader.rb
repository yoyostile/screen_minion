require 'shellwords'
require 'terminal-notifier'
require 'json'

module ScreenMinion
  class Uploader
    def upload_file(bucket_path, file)
      output = `#{mc} cp --quiet --json #{Shellwords.escape(file)} #{host}/#{bucket_path}`
      output = JSON.parse(output.split("\n")[0])
      TerminalNotifier.notify("Something went wrong!") and return if output['status'] != 'success'
      share_output = `#{mc} share download #{Shellwords.escape(output['target'])} --quiet --json `
      JSON.parse(share_output)
    end

    def mc
      ScreenMinion.config.mc
    end

    def host
      ScreenMinion.config.host
    end
  end
end
