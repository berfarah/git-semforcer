describe GitSemverCop do
  subject { GitSemverCop }
  before do
    @gemspec = GitSemverCop::Gemspec
    @package = GitSemverCop::PackageJson
  end

  describe ".update_version_files" do
    it "should update only existing files" do
      # Our project here only has a gemspec
      expect(@gemspec.exist?).to be true
      expect(@package.exist?).to be false

      expect_any_instance_of(@gemspec).to receive(:update)
      expect_any_instance_of(@package).not_to receive(:update)

      subject.update_version_files
    end
  end
end
