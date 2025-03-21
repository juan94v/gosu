# states/main_menu_state.rb
require 'ruby2d'
require_relative 'base_state'

class MainMenuState < BaseState
  def enter
    @title = Text.new("METAL SLUG-LIKE", size: 48, y: 100)
    @options = [
      Text.new("1. Play", y: 200),
      Text.new("2. Exit", y: 250)
    ]
  end

  def handle_input(event, type)  # Add 'type' parameter
    return unless type == :down  # Only process key presses, not holds

    case event.key
    when '1'
      StateMachine.change_state(PlayingState.new)
    when '2'
      Window.close
    end
  end

  def exit
    @title&.remove
    @options&.each(&:remove)
  end

  def update; end
end