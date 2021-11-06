require "./input_action/start_input_action"
require "./input_action/stop_input_action"
require "./input_action/span_input_action"
require "./input_action/show_day_input_action"
require "./input_action/show_month_input_action"

class InputActionParser
  getter input

  def initialize(@input : String)
  end

  def parse
    if InputAction::StartInputAction.new(input).matches?
      InputAction::StartInputAction.new(input)
    elsif InputAction::StopInputAction.new(input).matches?
      InputAction::StopInputAction.new(input)
    elsif InputAction::SpanInputAction.new(input).matches?
      InputAction::SpanInputAction.new(input)
    elsif InputAction::ShowDayInputAction.new(input).matches?
      InputAction::ShowDayInputAction.new(input)
    elsif InputAction::ShowMonthInputAction.new(input).matches?
      InputAction::ShowMonthInputAction.new(input)
    end
  end
end
