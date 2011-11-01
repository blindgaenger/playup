module Playup
  class CLI < Thor
    include Thor::Actions

    no_tasks do
      def source_paths
        super
        @source_paths << File.expand_path("../../playgrounds", File.dirname(__FILE__))
        @source_paths << File.expand_path(".playup/playgrounds", Dir.home)
      end

      def find_playground(type)
        find_in_source_paths(type.to_s)
      rescue
        nil
      end

      def load_config(dir)
        config_file = File.join(dir, 'config.rb')
        return unless File.exist?(config_file)

        load config_file
        extend Config
      end

      def name
        @name
      end
    end

    desc 'setup TYPE NAME', 'setup a playground'
    def setup(type, name)
      unless source_dir = find_playground(type)
        say_status :error, "can not find playground #{type}", :red
        return
      end

      @name = name
      load_config(source_dir)

      template_dir = File.join(source_dir, 'template')
      target_dir = File.expand_path(name)
      directory template_dir, target_dir
    end

  end
end
