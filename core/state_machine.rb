class StateMachine
  @@current_state = nil

  def self.change_state(new_state)
    @@current_state.exit if @@current_state
    @@current_state = new_state
    @@current_state.enter
  end

  def self.current_state
    @@current_state
  end
end