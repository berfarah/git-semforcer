describe GitSemverCop::Gemspec do
  subject { described_class.new }

  describe ".path" do
    it "finds the gemspec file in the directory" do
      expect(described_class.path).to eq("git-semver-cop.gemspec")
    end
  end

  describe ".exist?" do
    it "checks if the path exists" do
      expect(described_class).to receive(:path).and_call_original
      expect(described_class.exist?).to be true
    end
  end

  describe "#update" do
    before do
      require "tempfile"
      @tmp = Tempfile.new("example.gemspec")
      @tmp.write('spec.version = "1.1.0"')
      @tmp.close
    end
    after { @tmp.unlink }

    it "updates the version in the file and adds it to git" do
      allow(subject).to receive(:path).and_return(@tmp.path)
      expect_any_instance_of(Kernel).to receive(:system).and_return(true)
      expect(SemVer).to receive(:find).and_return("v1.1.1")

      subject.update

      expect(File.read(@tmp.path)).to eq('spec.version = "1.1.1"')
    end
  end
end
