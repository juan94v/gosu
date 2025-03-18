# states/playing_state.rb
require 'ruby2d'
require_relative 'base_state'
require_relative '../entities/player'

class PlayingState < BaseState
  def enter
    @player = Player.new
    @text = Text.new("Playing... Press ESC to return", y: 10)
    @moving_left = false  # Nuevas variables de estado
    @moving_right = false

    @floor = Rectangle.new( # Añadir piso
      x: 0, y: Window.height - 100,
      width: Window.width, height: 100,
      color: '#2c3e50'
    )

    @projectiles = []
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
    @text&.remove
  end

  def update
    @player.update(
      moving_left: @moving_left,
      moving_right: @moving_right,
      floor_y: @floor.y
    )

    @projectiles.each(&:update)

    @projectiles.reject!(&:removed?)
  end
end