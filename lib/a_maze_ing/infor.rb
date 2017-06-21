module AMazeIng
  class Infor
    attr_accessor :level, :player_1_point, :player_2_point
    def initialize(*player_color)
      @player_color = player_color

      # This class will renders information of the game, like points and level

      #---------------------------------------------------------------------------------#
      # create code block (initial, update and draw) for different game mode            #
      #---------------------------------------------------------------------------------#
      if @player_color.length == 2
        @initial_lambda = lambda {
          @player_1_color = player_color[0]
          @player_2_color = player_color[1]
        
          @level = 1
          @level_image = Gosu::Image.from_text @level.to_s, 36
          
          @label = 'LEVEL'
          @label_image = Gosu::Image.from_text @label, 40
          
          @x = center_by_x(@label_image.width)
          @y_1 = 210
          @y_2 = 290
          
          @player_1_point = 0
          @player_2_point = 0

          @player_1_point_image = Gosu::Image.from_text @player_1_point.to_s, 36
          @player_2_point_image = Gosu::Image.from_text @player_2_point.to_s, 36
        }
        @update_lambda = lambda {
          @level_image = Gosu::Image.from_text @level.to_s, 36
          @player_1_point_image = Gosu::Image.from_text @player_1_point.to_s, 36
          @player_2_point_image = Gosu::Image.from_text @player_2_point.to_s, 36
        }
        @draw_lambda = lambda {
          @label_image.draw(center_by_x(@label_image.width), 80, 1)
          @level_image.draw(center_by_x(@level_image.width), 130, 1)

          draw_quad @x,    @y_1,    @player_1_color,
                    @x+30, @y_1,    @player_1_color,
                    @x+30, @y_1+30, @player_1_color,
                    @x,    @y_1+30, @player_1_color

          draw_quad @x,    @y_2,    @player_2_color,
                    @x+30, @y_2,    @player_2_color,
                    @x+30, @y_2+30, @player_2_color,
                    @x,    @y_2+30, @player_2_color
          
          @player_1_point_image.draw(@x + 60, @y_1, 1)
          @player_2_point_image.draw(@x + 60, @y_2, 1)
        }
      elsif @player_color.length == 0
        @initial_lambda = lambda {
          @level = 1
          @label = 'LEVEL'
          @label_image = Gosu::Image.from_text @label, 40
        }
        @update_lambda = lambda {
          @level_image = Gosu::Image.from_text @level.to_s, 36
        }
        @draw_lambda = lambda {
          @label_image.draw(center_by_x(@label_image.width), 80, 1)
          @level_image.draw(center_by_x(@level_image.width), 130, 1)
        }
      end
      #-------------------------#
      # end create code block   #
      #-------------------------#


      @initial_lambda.call
    end

    def center_by_x(width)
      return $dimension + SIDE_BAR/2 - width/2
    end

    def update
      @update_lambda.call
    end

    def draw
      @draw_lambda.call
    end
  end
end