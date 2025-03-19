require_relative 'character'

class Player < Character
  attr_reader :sprite

  def initialize
    super(100, 100, 40, 'blue')
  end

  def update(moving_left:, moving_right:, floor_y:)
      # Movimiento horizontal
      @sprite.x -= @speed if moving_left
      @sprite.x += @speed if moving_right

      # Gravedad
      @vertical_speed += @gravity
      @sprite.y += @vertical_speed
  
      # Colisión con el piso
      if @sprite.y + @sprite.height >= floor_y
        @sprite.y = floor_y - @sprite.height
        @vertical_speed = 0
        @can_jump = true
      else
        @can_jump = false
      end
  end

  def destroy
    @sprite.remove
  end

  def run
    @speed = 10
  end

  def walk
    @speed = 5
  end
end