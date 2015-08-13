describe GitSemverCop::Semver do
  subject { described_class.new }
  before do
    allow_any_instance_of(Kernel).to receive(:puts).and_return("")
    allow_any_instance_of(Kernel).to receive(:gets).and_return("")
  end

  describe "#enforce" do
    before do
      allow(Kernel).to receive(:`).and_return("")
    end

    context "when .semver doesn't exist" do
      it "invokes semver init" do
        expect(File).to receive(:exist?).and_return(false)
        expect(subject).to receive(:semver_init)
        subject.enforce
      end
    end

    context "when .semver has been updated and added" do
      it "does nothing" do
        expect_any_instance_of(Kernel).to receive(:`).and_return("M  .semver\0")
        expect(subject.enforce).to be nil
      end
    end

    context "when .semver has been modified but not added" do
      it "asks to add it" do
        expect_any_instance_of(Kernel).to receive(:`).and_return("M .semver\0")
        expect(subject).to receive(:ask_add_changes)
        subject.enforce
      end
    end

    context "when .semver exists but was not modified" do
      it "asks to increment it" do
        expect_any_instance_of(Kernel).to receive(:`).and_return("")
        expect(subject).to receive(:ask_increment)
        subject.enforce
      end
    end
  end

  describe "#ask_add_changes" do
    it "adds to git if given [y]" do
      expect_any_instance_of(Kernel).to receive(:gets).and_return("y")
      expect(subject).to receive(:add_to_git)
      subject.ask_add_changes
    end
  end

  describe "#ask_increment" do
    it "goes [none] by default" do
      expect_any_instance_of(Kernel).to receive(:gets).and_return("")
      expect_any_instance_of(Kernel).to receive(:exit)
      subject.ask_increment
    end

    it "passes a given patch to #semver_inc" do
      expect_any_instance_of(Kernel).to receive(:gets).and_return("patch")
      expect(subject).to receive(:semver_inc).with("patch")
      subject.ask_increment
    end
  end
end
