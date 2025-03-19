require_relative 'character'

class Enemy < Character
  attr_reader :projectiles

  def initialize()
    super(1100, 100, 40, 'red')

    @facing_direction = :left
    @shoot_interval = 60
    @last_shot = 0

    @projectiles = []
  end

  def update(floor_y:)
    move

    @vertical_speed += @gravity
    @sprite.y += @vertical_speed

    if @sprite.y + @sprite.height >= floor_y
      @sprite.y = floor_y - @sprite.height
      @vertical_speed = 0
      @can_jump = true
    else
      @can_jump = false
    end

    if Window.frames % @shoot_interval == 0  # Dispara a intervalos regulares
      @projectiles << shoot
    end

    @projectiles.each(&:update)
    @projectiles.reject!(&:removed?)
  end

  def move
    if @facing_direction == :left
      @sprite.x -= @speed
      # Si llega al borde izquierdo, cambia de dirección
      @facing_direction = :right if @sprite.x <= 0
    else
      @sprite.x += @speed
      # Si llega al borde derecho, cambia de dirección
      @facing_direction = :left if @sprite.x >= Window.width - @sprite.width
    end
  end
end