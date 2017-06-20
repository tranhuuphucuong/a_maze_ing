require 'rubygems'
require 'commander'

module AMazeIng
  class CLI
    include Commander::Methods    
    
    def run
      @full_screen = false

      # program :name, AMazeIng::Configuration::PROGRAM_NAME 
      program :name, "AMazeIng"
      program :version, AMazeIng::VERSION
      # program :description, AMazeIng::Configuration::DESCRIPTION 
      program :description, "Maze solving game... don't be addicted" 

      default_command :classic

      global_option('-f', '--fullscreen', 'Render window at full screen') {
        @full_screen = true
      }

      command :classic do |c|
        c.syntax = 'a_maze_ing classic [options]'
        c.description = 'Classic mode, difficulty increase with level'
        c.action do 
          AMazeIng::GameWindow.new(@full_screen).show
        end
      end
      # command :bar do |c|
      #   c.syntax = 'foobar bar [options]'
      #   c.description = 'Display bar with optional prefix and suffix'
      #   c.option '-p', '--prefix STRING', String, 'Adds a prefix to bar'
      #   c.option '-s', '--suffix STRING', String, 'Adds a suffix to bar'
      #   c.action do |args, options|
      #     options.default :prefix => '(', :suffix => ')'
      #     say "#{options.prefix}bar#{options.suffix}"
      #   end
      # end

      run!
    end

  end
end