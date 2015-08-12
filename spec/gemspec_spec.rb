describe GitSemforcer::Gemspec do
  subject { described_class.new }

  describe "#path" do
    it "finds the gemspec file in the directory" do
      expect(subject.path).to eq("git-semforcer.gemspec")
    end
  end

  describe "#update" do
    context "if there isn't a gemspec file" do
      it "does nothing" do
        expect(File).to receive(:exist?).and_return(false)
        expect(subject.update).to be nil
      end
    end

    context "if there is a gemspec file" do
      before do
        require "tempfile"
        @tmp = Tempfile.new("example.gemspec")
        @tmp.write('spec.version = "1.1.0"')
        @tmp.close
      end
      after { @tmp.unlink }

      it "updates the version in the file and adds it to git" do
        expect(Dir).to receive(:[]).and_return([@tmp.path])
        expect_any_instance_of(Kernel).to receive(:system).and_return(true)
        expect(SemVer).to receive(:find).and_return("v1.1.1")

        subject.update

        expect(File.read(@tmp.path)).to eq('spec.version = "1.1.1"')
      end
    end
  end
end
