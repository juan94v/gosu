# states/base_state.rb
class BaseState
  def enter; end
  def update; end
  def exit; end
  def handle_input(event, type); end # Add this method
end