abstract class InputAction
  getter input
  getter project

  def initialize(@input : String, @project : String | Nil = nil)
  end

  def self.available_actions
    {{@type.subclasses}}
  end

  abstract def matches?
  abstract def run
end
