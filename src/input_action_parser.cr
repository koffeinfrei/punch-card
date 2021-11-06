require "./input_action"
require "./input_action/*"

class InputActionParser
  getter input

  def initialize(@input : String)
  end

  def parse
    InputAction.available_actions.each do |action|
      action_instance = action.new(input)
      if action_instance.matches?
        return action_instance
      end
    end

    InputAction::FallbackInputAction.new(input)
  end
end
