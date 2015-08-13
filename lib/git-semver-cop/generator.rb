require "thor"

module GitSemverCop
  # Our generator that creates the commit hook
  class Generator < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../../hooks", __FILE__)
    end

    def self.destination
      # For submodules which have a .git file that points to the module
      hooks_dir = "/hooks/pre-commit"

      if File.file?(".git")
        File.expand_path(submodule_git + hooks_dir, Dir.pwd)
      else
        File.expand_path(".git" + hooks_dir, Dir.pwd)
      end
    end

    def self.submodule_git
      File.read(".git").strip[/^(gitdir: )(.+)$/, 2]
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
