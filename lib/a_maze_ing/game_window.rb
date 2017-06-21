#!/usr/bin/env ruby
# cGREENits to: http://en.wikipedia.org/wiki/Maze_generation_algorithm

require 'gosu'
include Gosu
require "observer"

module AMazeIng
  DIMENSION = 700
  SIDE_BAR = 180
  PLAYER_COLOR_PRIMARY = Color::GREEN
  PLAYER_COLOR_SECONDARY = Color::AQUA
  PLAYER_COLOR_ANGRY = Color::RED
  class GameWindow < Window
    $rows = $cols = 10
    def initialize(full_screen, game_mode)
      @game_mode = game_mode
      super DIMENSION + SIDE_BAR, DIMENSION, full_screen, 30
      self.caption = "Maze"
      
      #---------------------------------------------------------------------------------#
      # create code block (update, player_draw and new_player) for different game mode  #
      #---------------------------------------------------------------------------------#
      if @game_mode == 1
        @update_lambda = lambda {
          check_for_finish(@player)
          @player.move
        }
        @player_draw_lambda = lambda {
          @player.draw
        }
        @new_player_lambda = lambda {
          @player = Player.new(1, 0, PLAYER_COLOR_PRIMARY)
        }
      elsif @game_mode == 2
        @update_lambda = lambda {

          if check_for_finish(@player)
            @infor.player_1_point += 1
          end
          @player.move
          if check_for_finish(@player_2)
            @infor.player_2_point += 1
          end
          @player_2.move

        }
        @player_draw_lambda = lambda {
          @player.draw
          @player_2.draw
        }
        @new_player_lambda = lambda {
          @player = Player.new(1, 0, PLAYER_COLOR_PRIMARY)
          @player_2 = Player.new(0, 1, PLAYER_COLOR_SECONDARY)
        }
      elsif @game_mode == 3
        @update_lambda = lambda {

          if check_for_finish(@player)
            @infor.player_1_point += 1
          end
          @player.move
          if check_for_collision(@player, @player_2)
            @infor.player_2_point += 1
          end
          @player_2.move

        }
        @player_draw_lambda = lambda {
          @player.draw
          @player_2.draw
        }
        @new_player_lambda = lambda {
          @player = Player.new(1, 0, PLAYER_COLOR_PRIMARY)
          @player_2 = Player.new($cols-1, 0, PLAYER_COLOR_ANGRY)
        }
      end
      #-------------------------#
      # end create code block   #
      #-------------------------#

      new_round
      if @game_mode == 1
        @infor = Infor.new
      elsif @game_mode == 2
        @infor = Infor.new(PLAYER_COLOR_PRIMARY, PLAYER_COLOR_SECONDARY)
      elsif @game_mode == 3
        @infor = Infor.new(PLAYER_COLOR_PRIMARY, PLAYER_COLOR_ANGRY)
      end

    end

    def new_round
      $rows += 2
      $cols += 2
      @maze = Maze.new
      @maze.generate_maze
      @new_player_lambda.call      
    end

    def draw_target(cell)
      cell_index_x = cell.cell_index_x
      cell_index_y = cell.cell_index_y
      x = (cell_index_x * $cell_size) + $cell_size/2 - $player_size/2
      y = (cell_index_y * $cell_size) + $cell_size/2 - $player_size/2
      draw_quad x, y, Color::WHITE,
                x+$player_size, y, Color::WHITE,
                x+$player_size, y+$player_size, Color::WHITE,
                x, y+$player_size, Color::WHITE
    end

    def check_for_finish(player)
      if player.cell_index_x == $cells[-1].cell_index_x and player.cell_index_y == $cells[-1].cell_index_y
        new_round
        @infor.level += 1
        return true
      else 
        return false
      end
    end

    def check_for_collision(player_1, player_2)
      if player_2.cell_index_x == player_1.cell_index_x and player_2.cell_index_y == player_1.cell_index_y
        new_round
        @infor.level += 1
        return true
      else
        return false
      end
    end

    def update
      @update_lambda.call
      @infor.update
     end

    def draw
      $cells.each do |cell|
        if cell.visited 
          cell.draw($cell_size, Color::BLUE) 
        else
          cell.draw($cell_size, PLAYER_COLOR_PRIMARY)
        end
      end
      @player_draw_lambda.call
      @infor.draw
      draw_target($cells[-1])
    end

    # check weather the direction player want to go to available or not
    # if available, set new status for player
    def check_available_move(path, player)
      if !$cells[player.cell_index_x + player.cell_index_y * $cols].walls[path]

        player.set_status(path)
        player.is_moving = true
      end
    end

    def button_down(id)
      if id == Gosu::KB_LEFT
        check_available_move(3, @player)
      end

      if id == Gosu::KB_RIGHT
        check_available_move(1, @player)
      end

      if id == Gosu::KB_UP
        check_available_move(0, @player)
      end
      
      if id == Gosu::KB_DOWN
        check_available_move(2, @player)
      end

      # control keys for player 2
      if @game_mode == 2 or @game_mode == 3

        if id == Gosu::KB_A
          check_available_move(3, @player_2)
        end

        if id == Gosu::KB_D
          check_available_move(1, @player_2)
        end

        if id == Gosu::KB_W
          check_available_move(0, @player_2)
        end
        
        if id == Gosu::KB_S
          check_available_move(2, @player_2)
        end

      end

      if id == Gosu::KB_ESCAPE
        close
      else
        super
      end
    end
  end
end
