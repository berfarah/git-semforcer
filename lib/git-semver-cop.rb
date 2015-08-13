require "git-semver-cop/semver"
Dir[File.expand_path("../git-semver-cop/version_files/*", __FILE__)
   ].each(&method(:require))

# Public method for updating all of our version files
module GitSemverCop
  def self.update_version_files
    GitSemverCop.constants.each do |klass_sym|
      klass = GitSemverCop.const_get(klass_sym)
      next unless klass < GitSemverCop::VersionFile
      klass.exist? && klass.new.update
    end
  end
end
