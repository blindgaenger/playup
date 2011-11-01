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

    describe '#playground?' do
      it 'returns true if the playground exists' do
        @cli.should_receive(:find_in_source_paths).with('solid').and_return(nil)

        @cli.playground?('solid').should == true
      end

      it 'returns false if the playground does not exist' do
        @cli.should_receive(:find_in_source_paths).with('ghost').and_raise(RuntimeError)

        @cli.playground?('ghost').should == false
      end
    end

    describe '#setup' do
      context 'playground type is unknown' do
        it 'dies without screaming' do
          @cli.should_receive(:playground?).and_return(false)
          @cli.should_receive(:say_status).with(:error, 'can not find playground ghost', :red)

          @cli.setup 'ghost', 'app'
        end
      end

      it 'sets up a playground' do
        @cli.should_receive(:playground?).and_return(true)
        @cli.should_receive(:directory).with('sinatra/template', File.expand_path('app'))

        @cli.setup 'sinatra', 'app'
      end
    end

  end
end
