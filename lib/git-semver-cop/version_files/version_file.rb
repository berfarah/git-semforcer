require "semver"

module GitSemverCop
  class VersionFile
    class << self
      attr_accessor :path

      def exist?
        path && File.exist?(path)
      end
    end

    def update
      update_version
      write_update
      add_to_git
    end

    def path
      self.class.path
    end

    private

      def contents
        @contents ||= File.read(path)
      end

      def current_version
        SemVer.find.to_s[1..-1]
      end

      def write_update
        puts "Changing #{path} version"
        File.write(path, contents)
      end

      def add_to_git
        system "git add #{path}"
      end
  end
end
