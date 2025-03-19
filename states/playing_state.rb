# states/playing_state.rb
require 'ruby2d'
require_relative 'base_state'
require_relative '../entities/player'
require_relative '../entities/Enemy'

class PlayingState < BaseState
  def enter
    @player = Player.new
    @enemy = Enemy.new
    @text = Text.new("Playing... Press ESC to return", y: 10)
    @moving_left = false  # Nuevas variables de estado
    @moving_right = false

    @floor = Rectangle.new( # Añadir piso
      x: 0, y: Window.height - 100,
      width: Window.width, height: 100,
      color: '#2c3e50'
    )

    @projectiles = []

    @debug_texts = []  # Array para almacenar textos de debug
    @debug_mode = true
  end

  def handle_input(event, type)
    case event.key
    when 'escape'
      StateMachine.change_state(MainMenuState.new)
    when 'a'
      @moving_left = type == :held
      @player.facing_direction = :left
    when 'd'
      @moving_right = type == :held
      @player.facing_direction = :right
    when 'space' # Salto
      @player.jump if type == :down && @player.can_jump?
    when 's'
      @player.run if type == :held
      @player.walk if type == :up
    when '.' # Nueva entrada para disparar
      if type == :down
        # Crea un nuevo proyectil y añádelo al array
        @projectiles << @player.shoot
      end
    end
    
  end

  def exit
    @player.destroy
    @enemy.destroy
    @text&.remove
  end

  def update
    @player.update(
      moving_left: @moving_left,
      moving_right: @moving_right,
      floor_y: @floor.y
    )

    @enemy.update(floor_y: @floor.y)

    @projectiles.each(&:update)

    @projectiles.reject!(&:removed?)

    update_debug_info
  end

  def update_debug_info
    # Limpiar textos anteriores
    @debug_texts.each(&:remove)
    @debug_texts.clear

    # Crear nuevos textos
    @debug_texts << Text.new("FPS: #{Window.fps}", x: Window.width - 150, y: 10, size: 15, color: "lime")
    @debug_texts << Text.new("Player: (#{@player.sprite.x.round(2)}, #{@player.sprite.y.round(2)})", x: Window.width - 150, y: 30, size: 15, color: "lime")
    @debug_texts << Text.new("Projectiles: #{@projectiles.size}", x: Window.width - 150, y: 50, size: 15, color: "lime")
    @debug_texts << Text.new("Can Jump: #{@player.can_jump?}", x: Window.width - 150, y: 70, size: 15, color: "lime")
  end
end