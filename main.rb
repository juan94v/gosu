# main.rb
require 'ruby2d'
require_relative 'core/state_machine'
require_relative 'states/main_menu_state'
require_relative 'states/playing_state'  # Add this line

set title: "Metal Slug-like Game", width: 1280, height: 720

# Initialize state machine with main menu
StateMachine.change_state(MainMenuState.new)

# Global input handling
on :key_down do |event|
  StateMachine.current_state&.handle_input(event, :down)
end

on :key_held do |event|
  StateMachine.current_state&.handle_input(event, :held)
end

on :key_up do |event|
  StateMachine.current_state&.handle_input(event, :up)
end

# Game loop
update do
  StateMachine.current_state&.update
end

show