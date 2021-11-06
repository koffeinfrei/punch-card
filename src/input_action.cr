abstract class InputAction
  getter input

  def initialize(@input : String)
  end

  abstract def matches?
  abstract def run
end
