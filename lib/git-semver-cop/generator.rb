require "thor"

module GitSemverCop
  # Our generator that creates the commit hook
  class Generator < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../hooks", __FILE__)
    end

    def self.destination
      File.expand_path(".git/hooks/pre-commit", Dir.pwd)
    end

    desc "init", "Generates a pre-commit hook to ensure you update your .semver"
    def init
      copy_file "pre-commit", self.class.destination
      chmod self.class.destination, 0744
    end

    desc "destroy", "Get rid of pre-commit hook"
    def destroy
      remove_file self.class.destination
    end
  end
end
