require "./input_action"

class InputActionParser
  def self.parse(input, project)
    InputAction.available_actions.each do |action|
      action_instance = action.new(input, project)
      if action_instance.matches?
        return action_instance
      end
    end

    InputAction::FallbackInputAction.new(input)
  end
end
