abstract class InputAction
  getter input

  def initialize(@input : String)
  end

  def self.available_actions
    {{@type.subclasses}}
  end

  abstract def matches?
  abstract def run
end
