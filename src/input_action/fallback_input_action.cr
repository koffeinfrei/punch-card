require "../input_action"

class InputAction
  class FallbackInputAction < InputAction
    def matches?
      true
    end

    def run
      puts "The input '#{input}' was not understood. Please check for typos and consult the help output"
    end
  end
end
