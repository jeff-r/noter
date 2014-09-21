require "noter"
require "timecop"
require "pp"        # to avoid an error in fakefs
require "fakefs"
require "pry"
require "pry-nav"

module Noter
  describe FileMaker do
    let(:maker) { FileMaker.new }

    describe "#new_filename" do
      it "generates a new filename" do
        Timecop.freeze(Time.local(2014,9,20,22,14,0,0)) do
          expect(maker.new_filename).to eql("#{maker.dir}/2014_09_20_22_14_00.txt")
        end
      end
    end

    describe "with a filename and content" do
      let(:maker) { FileMaker.new("some content", "file.txt") }

      describe "#save_to_file" do
        it "saves to a file" do
          expect(File).to receive(:write).with("file.txt", "some content")
          maker.save_file
        end
      end
    end

    describe "when the directory doesn't already exist" do
      let(:maker) { FileMaker.new("some content", "file.txt") }

      before do
        if Dir.exist?(maker.dir)
          FileUtils.rm_rf maker.dir
        end
      end

      it "creates the directory" do
        expect(Dir.exist?(maker.dir)).to be false
        maker.save_file
        expect(Dir.exist?(maker.dir)).to be true
      end
    end

    describe "#make_from_file" do
      before do
        unless Dir.exist?(maker.dir)
          FileUtils.mkdir maker.dir
        end
        File.write("foo.txt", "some content")
      end

      it "saves to a file" do
        maker.make_from_file("foo.txt")
        content = File.read(maker.new_filename)
        expect(content).to eql("some content")
      end
    end
  end
end
