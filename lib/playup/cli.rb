module Playup
  class CLI < Thor
    include Thor::Actions

    no_tasks do
      def source_paths
        super
        @source_paths << File.expand_path("../../playgrounds", File.dirname(__FILE__))
        @source_paths << File.expand_path(".playup/playgrounds", Dir.home)
      end

      def playground?(type)
        find_in_source_paths(type.to_s)
        true
      rescue
        false
      end
    end

    desc 'setup TYPE NAME', 'setup a playground'
    def setup(type, name)
      unless playground?(type)
        say_status :error, "can not find playground #{type}", :red
        return
      end

      source_dir = File.join(type, 'template')
      target_dir = File.expand_path(name)
      directory source_dir, target_dir
    end

  end
end
