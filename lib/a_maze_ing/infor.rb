module AMazeIng
  class Infor
    attr_accessor :level
    def initialize 
      @level = 1
      @label = 'LEVEL'

      @label_image = Gosu::Image.from_text @label, 40
    end

    def center_x(width)
      return $dimension + SIDE_BAR/2 - width/2
    end

    def draw
      @level_image = Gosu::Image.from_text @level.to_s, 36
      @label_image.draw(center_x(@label_image.width), 80, 1)
      @level_image.draw(center_x(@level_image.width), 130, 1)
    end
  end
end