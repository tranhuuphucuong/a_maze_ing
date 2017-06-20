module AMazeIng
  class Infor
    attr_accessor :level, :player_1_point, :player_2_point
    def initialize 
      @level = 1
      @label = 'LEVEL'
      @label_image = Gosu::Image.from_text @label, 40
      @level_image = Gosu::Image.from_text @level.to_s, 36
      @x = center_x(@label_image.width)
      @y_1 = 210
      @y_2 = 290
      
      @player_1_point = 0
      @player_2_point = 0

      @player_1_point_image = Gosu::Image.from_text @player_1_point.to_s, 36
      @player_2_point_image = Gosu::Image.from_text @player_2_point.to_s, 36
    end

    def center_x(width)
      return $dimension + SIDE_BAR/2 - width/2
    end

    def update
      @level_image = Gosu::Image.from_text @level.to_s, 36
      @player_1_point_image = Gosu::Image.from_text @player_1_point.to_s, 36
      @player_2_point_image = Gosu::Image.from_text @player_2_point.to_s, 36

    end

    def draw

      @label_image.draw(center_x(@label_image.width), 80, 1)
      @level_image.draw(center_x(@level_image.width), 130, 1)

      draw_quad @x, @y_1, Color::RED,
                @x+30, @y_1, Color::RED,
                @x+30, @y_1+30, Color::RED,
                @x, @y_1+30, Color::RED

      draw_quad @x, @y_2, Color::YELLOW,
                @x+30, @y_2, Color::YELLOW,
                @x+30, @y_2+30, Color::YELLOW,
                @x, @y_2+30, Color::YELLOW
      
      @player_1_point_image.draw(@x + 60, @y_1, 1)
      @player_1_point_image.draw(@x + 60, @y_2, 1)


    end
  end
end