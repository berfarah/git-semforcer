require_relative "version_file"

module GitSemverCop
  # Class for updating Gemspec
  class Gemspec < VersionFile
    self.path = Dir["*.gemspec"].first

    private

      def update_version
        contents.sub!(/(\.version\s+=\s+).+$/,
                      '\1"' + current_version + '"')
      end
  end
end
