module AMazeIng
  class Player
    attr_accessor :cell_index_x, :cell_index_y, :target_x, :target_y, :is_moving, :path
    def initialize(cell_index_x, cell_index_y, color)
      @color = color
      @cell_index_x = cell_index_x
      @cell_index_y = cell_index_y
      @is_moving = false
      @path = nil
      set_target
      @x = @target_x
      @y = @target_y
    end

    def set_target
      @target_x = (@cell_index_x * $cell_size) + $cell_size/2 - $player_size/2
      @target_y = (@cell_index_y * $cell_size) + $cell_size/2 - $player_size/2
    end

    def check_for_path(ignored_path)
      path = nil
      $cells[@cell_index_x + @cell_index_y * $cols].walls.each_with_index do |wall, i|
        if !wall and i != ignored_path
          if path == nil
            path = i
          else
            path = nil
            break
          end
        end
      end
      return path
    end

    def set_status(path)
      @path = path
      if @path == 0 
        @cell_index_y -= 1
      elsif @path == 1 
        @cell_index_x += 1
      elsif @path == 2 
        @cell_index_y += 1 
      else
        @cell_index_x -= 1
      end
      set_target
    end

    def move
      if @is_moving
        if @x == @target_x && @y == @target_y
          
          # check for available path, 
          # and ignore the the opposite directions of the LAST path 
          # cuz you don't wanna go back where you just left
          @path = check_for_path(@path == 0 ? 2:
                                 @path == 1 ? 3:
                                 @path == 2 ? 0: 1)
          if @path != nil
            # set new player's cell index depend on "current @path"
            set_status(@path)
            set_target
          else
            
            # no "available" path found, player stop moving
            @is_moving = false
          end
        else

          # target's position is different than curent position, 
          # move to the target
          if @x < @target_x
            @x += $speed_per_tick
          elsif @x > @target_x
            @x -= $speed_per_tick
          end

          if @y < @target_y
            @y += $speed_per_tick
          elsif @y > @target_y
            @y -= $speed_per_tick
          end

        end
      end
    end

    def draw
      draw_quad @x,                @y,                @color,
                @x + $player_size, @y,                @color,
                @x + $player_size, @y + $player_size, @color,
                @x,                @y + $player_size, @color
    end
  end
end