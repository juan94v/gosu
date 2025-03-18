require_relative 'projectile' 

class Player
  attr_reader :sprite
  attr_writer :facing_direction

  def initialize
    @sprite = Square.new(x: 100, y: 100, size: 40, color: 'blue')
    @speed = 5
    @gravity = 0.5
    @vertical_speed = 0
    @can_jump = false
    @facing_direction = :right
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

  def jump
    @vertical_speed = -15 # Fuerza del salto
    @can_jump = false
  end

  def run
    @speed = 10
  end

  def walk
    @speed = 5
  end
  
  def can_jump? = @can_jump

  def shoot
    x = @sprite.x + @sprite.width / 2
    y = @sprite.y + @sprite.height / 2

    Projectile.new(x, y, @facing_direction)
  end
end