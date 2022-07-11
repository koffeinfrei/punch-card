class InputAction
  class ShowProjectsInputAction < InputAction
    def matches?
      input == "projects"
    end

    def run
      puts "Available projects:"
      puts Store.new.select_projects.map { |project| "  - #{project}" }.join("\n")
    end

    def self.description
      {
        "Show the available projects",
        "projects",
      }
    end
  end
end
