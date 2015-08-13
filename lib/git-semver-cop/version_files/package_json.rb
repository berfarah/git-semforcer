require_relative "version_file"

module GitSemverCop
  # Class for updating package.json
  class PackageJson < VersionFile
    self.path = "package.json"

    private

      def update_version
        contents.sub!(/("version"\s*:\s*)(".+?")/,
                      '\1"' + current_version + '"')
      end
  end
end
