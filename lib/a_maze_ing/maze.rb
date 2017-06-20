module AMazeIng
  class Maze

    def initialze
      
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

  end
end