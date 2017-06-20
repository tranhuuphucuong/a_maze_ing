#!/usr/bin/env ruby
# credits to: http://en.wikipedia.org/wiki/Maze_generation_algorithm
require 'gosu'
include Gosu

module AMazeIng
  DIMENSION = 200
  SIDE_BAR = 180
  class GameWindow < Window
    # $dimension = DIMENSION
    $rows = $cols = 10
    # check_dimension

    # $cell_size = $dimension/$cols
    # $speed_per_tick = $cell_size/4
    # $player_size = 0.5 * $cell_size

    def initialize
      super DIMENSION + SIDE_BAR, DIMENSION, false, 1
      self.caption = "Maze"
      generate_maze
      @infor = Infor.new
    end

    def check_dimension
      until $dimension/$cols % 4 == 0
        $dimension -= 1
      end
    end
    
    def generate_maze
      $dimension = DIMENSION
      check_dimension
      $cell_size = $dimension/$cols
      $speed_per_tick = $cell_size/4
      $player_size = 0.5 * $cell_size

      $cells = Array.new
      @stack = Array.new
      @player = Player.new

      $rows.times do |row_index|
        $cols.times do |col_index|
          cell = Cell.new(col_index, row_index)
          $cells.push(cell)
        end
      end

      $cells[0].visited = true
      @current_cell = $cells[0]
      # @current_cell.is_current = true
      @stack.push(@current_cell)

      while @stack.length > 0 do 
        next_cell = @current_cell.check_neigh_bors($cells)
        if next_cell
          remove_walls(@current_cell, next_cell)
          next_cell.visited = true
          @stack.push(@current_cell)
          # @current_cell.is_current = true
          @current_cell = next_cell
        elsif @stack.length > 0
          # @stack[-1].is_current = false
          @current_cell = @stack.pop
        end
      end
    end

    def remove_walls(current_cell, next_cell)
      magic_number =  next_cell.cell_index_x - current_cell.cell_index_x
      if magic_number == 1
        # next cell is on the right
        current_cell.walls[1] = next_cell.walls[3] = false
      elsif magic_number == -1
        # next cell is on the left
        current_cell.walls[3] = next_cell.walls[1] = false
      elsif magic_number == 0
        # next cell is either on top or bottom
        magic_number = next_cell.cell_index_y - current_cell.cell_index_y
        if magic_number == 1
          #next cell is bottom
          current_cell.walls[2] = next_cell.walls[0] = false
        elsif magic_number ==-1
          #next cell is on top
          current_cell.walls[0] = next_cell.walls[2] = false
        end
      end
    end

    def draw_target(cell)
      cell_index_x = cell.cell_index_x
      cell_index_y = cell.cell_index_y
      x = (cell_index_x * $cell_size) + $cell_size/2 - $player_size/2
      y = (cell_index_y * $cell_size) + $cell_size/2 - $player_size/2
      draw_quad x, y, Color::GREEN,
                x+$player_size, y, Color::GREEN,
                x+$player_size, y+$player_size, Color::GREEN,
                x, y+$player_size, Color::GREEN
    end

    def check_for_finish
      puts 'checking for finish'
      if @player.cell_index_x == $cells[-1].cell_index_x && @player.cell_index_y == $cells[-1].cell_index_y
        $rows += 2
        $cols += 2
        generate_maze
        @infor.level += 1


      end
    end

    def update
      
    end

    def draw
      $cells.each do |cell|
        if cell.visited 
          cell.draw($cell_size, Color::BLUE) 
        else
          cell.draw($cell_size, Color::GREEN)
        end
      end
      @player.draw
      @player.move
      @infor.draw
      draw_target($cells[-1])
      check_for_finish
    end

    def button_down(id)
      if id == Gosu::KB_LEFT
        if !$cells[@player.cell_index_x + @player.cell_index_y * $cols].walls[3]
          
          @player.path = 3
          @player.cell_index_x -= 1
          @player.set_target
          @player.is_moving = true
        end
      end

      if id == Gosu::KB_RIGHT
        if !$cells[@player.cell_index_x + @player.cell_index_y * $cols].walls[1]
          
          @player.path = 1
          @player.cell_index_x += 1
          @player.set_target
          @player.is_moving = true
        end
      end

      if id == Gosu::KB_UP
        if !$cells[@player.cell_index_x + @player.cell_index_y * $cols].walls[0]
          
          @player.path = 0
          @player.cell_index_y -= 1
          @player.set_target
          @player.is_moving = true
        end
      end
      
      if id == Gosu::KB_DOWN
        if !$cells[@player.cell_index_x + @player.cell_index_y * $cols].walls[2]
          
          @player.path = 2
          @player.cell_index_y += 1
          @player.set_target
          @player.is_moving = true
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
