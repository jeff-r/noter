require "pp"        # to avoid an error in fakefs
require "fakefs"
require "noter/viewer"

module Noter
  describe Viewer do
    let(:viewer) { Noter::Viewer.new }

    before do
      FileUtils.mkdir_p NoteFile.dir
      File.write("#{NoteFile.dir}/2014_09_21_18_20_22.txt", "file 1\nline 2")
      File.write("#{NoteFile.dir}/2014_09_21_19_20_22.txt", "file 2\nline 2")
    end

    describe "#existing_files" do
      it "returns the names of all the existing files" do
        expect(viewer.existing_files).to eql(%W{#{NoteFile.dir}/2014_09_21_18_20_22.txt  #{NoteFile.dir}/2014_09_21_19_20_22.txt})
      end
    end

    describe "#show_first_lines" do
      it "shows first lines" do
        expect(viewer).to receive(:puts).with("09-21 18:20: file 1")
        expect(viewer).to receive(:puts).with("09-21 19:20: file 2")
        viewer.show_first_lines
      end

      it "includes the filenames" do
        expect(viewer).to receive(:puts).with("09-21 18:20: #{NoteFile.dir}/2014_09_21_18_20_22.txt: file 1")
        expect(viewer).to receive(:puts).with("09-21 19:20: #{NoteFile.dir}/2014_09_21_19_20_22.txt: file 2")
        viewer.show_first_lines(with_filename: true)
      end
    end
  end
end

