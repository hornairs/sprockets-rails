module Rails
  module Paths
    class Path
      def existent_directories
        paths.select { |d| File.directory?(d) }
      end
    end
  end
end
