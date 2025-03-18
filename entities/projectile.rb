class Projectile
  attr_reader :sprite, :removed

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction

    @sprite = Circle.new(x: @x, y: @y, radius: 3, color: 'red')
    @speed = 20
    @removed = false
  end

  def update
    if @direction == :right
      @x += @speed
    else
      @x -= @speed
    end

    @sprite.x = @x

    destroy if @x > Window.width || @x < 0
  end

  def destroy
    return if @removed
    @sprite.remove
    @removed = true
  end

  def removed? = @removed
end