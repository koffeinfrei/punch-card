abstract class InputAction
  getter input
  getter project

  def initialize(@input : String, @project : String | Nil = nil)
  end

  def self.available_actions
    {{@type.subclasses}}
  end

  def self.description
  end

  abstract def matches?
  abstract def run
end

require "./input_action/*"
