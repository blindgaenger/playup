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

      def die(message)
        say_status :error, message, :red
        exit(-1)
      end
    end

    desc 'setup TYPE', 'setup a playground'
    def setup(type)
      die "can not find playground #{type}" unless playground?(type)

      type
    end

  end
end
