# Credits to: http://en.wikipedia.org/wiki/Maze_generation_algorithm
# I use Depth-first search recursive backtracking algorithm
# You can find the information in the wiki link

module AMazeIng
  class Maze

    # This is very important.
    # With this calculated dimension 
    # the character will be exactly at the pixel you want it to be 
    def check_dimension
      until $dimension/$cols % STEP_RATE == 0
        $dimension -= 1
      end
    end
    
    def generate_maze

      # set initial specifications for the maze
      $dimension = DIMENSION
      check_dimension
      $cell_size = $dimension/$cols
      $speed_per_tick = $cell_size/STEP_RATE
      $player_size = 0.5 * $cell_size

      $cells = Array.new
      @stack = Array.new
      
      # I use one dimensional array to store all the cell... 
      # yeah, should not do that... feel regret now
      $rows.times do |row_index|
        $cols.times do |col_index|
          cell = Cell.new(col_index, row_index)
          $cells.push(cell)
        end
      end

      # Ok, here is where the heavy work begin
      # Let set visited for the top left cell, where we start
      $cells[0].visited = true
      @current_cell = $cells[0]
      # @current_cell.is_current = true
      @stack.push(@current_cell)

      # This is the same as "While there are unvisited cells"
      # at least, same result, see the wiki page for more
      while @stack.length > 0 do 
        next_cell = @current_cell.get_random_neighbor($cells)
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

      # Remove more random walls to make more available way
      remove_extra_walls 
    end

    def remove_walls(current_cell, next_cell)
      if next_cell != nil

        # yeah I'd like to call it magic_number
        # it show me the relative position of two cell
        magic_number =  next_cell.cell_index_x - current_cell.cell_index_x
        
        if magic_number == 1 # next cell is on the right
          current_cell.walls[1] = next_cell.walls[3] = false

        elsif magic_number == -1 # next cell is on the left
          current_cell.walls[3] = next_cell.walls[1] = false

        elsif magic_number == 0 # next cell is either on top or bottom
          magic_number = next_cell.cell_index_y - current_cell.cell_index_y

          if magic_number == 1 #next cell is bottom
            current_cell.walls[2] = next_cell.walls[0] = false

          elsif magic_number ==-1#next cell is on top
            current_cell.walls[0] = next_cell.walls[2] = false
          end
        end
      end
    end

    # For now, it almost doesn't remove horizontal walls
    def remove_extra_walls
      a_count_number = $cells.length/2/5
      while a_count_number > 0 do
        cell_index = rand(0..$cells.length/2)
        remove_walls($cells[cell_index], $cells[cell_index+1])
        a_count_number -= 1
      end
    end
  end
end