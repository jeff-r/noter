require "pp"        # to avoid an error in fakefs
require "fakefs"
require "noter/note_file"

module Noter
  describe NoteFile do
    let(:file) { Noter::NoteFile.new("2014_09_21_18_20_22.txt") }

    before do
      FileUtils.mkdir_p NoteFile.dir
    end

    it "returns a formatted time from the filename" do
      expect(file.formatted_time).to eql("09-21 18:20")
    end

    describe "#content" do
      before do
        File.write(file.filename, "some content")
      end

      it "returns the content of the file" do
        expect(file.content).to eql("some content")
      end
    end

    describe "#first_line" do
      before do
        File.write(file.filename, "some content\nline 2")
      end

      it "returns the content of the file" do
        expect(file.first_line).to eql("some content")
      end
    end
  end
end
