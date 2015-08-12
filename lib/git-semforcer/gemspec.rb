require "semver"

module GitSemforcer
  # Class for updating Gemspec
  class Gemspec
    attr_reader :path

    def initialize
      @path = Dir["*.gemspec"].first
    end

    def update
      return unless exist?
      update_version
      write_update
      add_to_git
    end

    def exist?
      File.exist?(path)
    end

    private

      def contents
        @contents ||= File.read(path)
      end

      def update_version
        contents.sub!(/(\.version\s+=\s+).+$/,
                      '\1"' + SemVer.find.to_s[1..-1] + '"')
      end

      def write_update
        puts "Changing Gemspec version"
        File.write(path, contents)
      end

      def add_to_git
        system "git add #{path}"
      end
  end
end
