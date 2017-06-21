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
            AMazeIng::GameWindow.new(@full_screen,1).show
        end
      end

      command :multiplayer do |c|
        c.syntax = 'a_maze_ing multiplayer [options]'
        c.description = 'Multiplayer mode, two player race to the gate, player 2 use W/S/A/D key to move up/down/left/right'
        c.action do 
            AMazeIng::GameWindow.new(@full_screen,2).show
        end
      end
      alias_command :'m', :multiplayer


      command :annoying_friend do |c|
        c.syntax = 'a_maze_ing anfri [options]'
        c.description = 'Annoying friend mode, player 1 try to get to the gate while the player 2(annoying friend) try to catch him'
        c.action do 
            AMazeIng::GameWindow.new(@full_screen,3).show
        end
      end
      alias_command :'af', :annoying_friend, :'anfri', :'multiplayer2', :'multiplayer_2'

      run!
    end

  end
end