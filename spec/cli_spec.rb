require 'spec_helper'

module Playup
  describe CLI do
    before do
      @cli = CLI.new
    end

    describe '#source_paths' do
      it "contains the gem's playgrounds" do
        project_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
        @cli.source_paths.should include(File.expand_path('playgrounds', project_dir))
      end

      it "contains the user's playgrounds" do
        user_dir = Dir.home
        @cli.source_paths.should include(File.expand_path('.playup/playgrounds', user_dir))
      end
    end

    describe '#find_playground' do
      context 'playground exists' do
        it 'returns the full path' do
          @cli.should_receive(:find_in_source_paths).with('solid').and_return('/playground/solid')

          @cli.find_playground('solid').should == '/playground/solid'
        end
      end

      context 'playground is unknown' do
        it 'returns nil' do
          @cli.should_receive(:find_in_source_paths).with('ghost').and_raise(RuntimeError)

          @cli.find_playground('ghost').should == nil
        end
      end
    end

    describe '#load_config' do
      context 'config does not exist' do
        it 'does nothing' do
          File.should_receive(:exist?).with('/playground/sinatra/config.rb').and_return(false)

          @cli.load_config '/playground/sinatra'
        end
      end

      it 'loads the file and extends the contained module' do
        config_file = '/playground/sinatra/config.rb'
        File.should_receive(:exist?).with(config_file).and_return(true)
        @cli.should_receive(:load).with(config_file)

        # TODO: extend Config
        @cli.load_config '/playground/sinatra'
      end
    end

    describe '#setup' do
      context 'playground type is unknown' do
        it 'dies without screaming' do
          @cli.should_receive(:find_playground).and_return(nil)
          @cli.should_receive(:say_status).with(:error, 'can not find playground ghost', :red)

          @cli.setup 'ghost', 'app'
        end
      end

      it 'sets up a playground' do
        @cli.should_receive(:find_playground).and_return('/playground/sinatra')
        @cli.should_receive(:directory).with('/playground/sinatra/template', File.expand_path('app'))

        @cli.setup 'sinatra', 'app'
      end
    end

  end
end
