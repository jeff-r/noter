require "pp"        # to avoid an error in fakefs
require "fakefs"
require "noter/viewer"

module Noter
  describe Viewer do
    let(:viewer) { Noter::Viewer.new }
    let(:file_1_name)     { "#{NoteFile.dir}/2014_09_21_18_20_22.txt" }
    let(:file_2_name)     { "#{NoteFile.dir}/2014_09_21_19_20_22.txt" }
    let(:file_1_contents) { "file 1\nline 2" }
    let(:file_2_contents) { "file 2\nline 2" }

    before do
      FileUtils.mkdir_p NoteFile.dir
      File.write(file_1_name, file_1_contents)
      File.write(file_2_name, file_2_contents)
      allow(viewer).to receive(:puts)
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

    describe "#show_file" do
      it "puts the file" do
        expect(viewer).to receive(:puts).with(file_1_contents)
        viewer.show_file(file_1_name)
      end
    end

    describe "#show_file_from_index" do
      it "puts the file" do
        expect(viewer).to receive(:puts).with(file_1_contents)
        viewer.show_file_from_index(0)
      end
    end

    describe "when paging is enabled" do
      let(:viewer) { Noter::Viewer.new({:paging => false}) }

      it "doesn't page" do
        expect(viewer).to_not receive(:page)
        viewer.show_file_from_index(0)
      end
    end

    describe "when paging is not enabled" do
      let(:viewer) { Noter::Viewer.new }

      it "doesn't page" do
        expect(viewer).to receive(:page)
        viewer.show_file_from_index(0)
      end
    end

    describe "#show_last_n_files" do
      describe "without colors" do
        let(:viewer) { Noter::Viewer.new(:colorize => false) }

        it "puts the last two files" do
          expect(viewer).to receive(:puts).with("\n\n#{file_1_name}")
          expect(viewer).to receive(:puts).with(file_1_contents)
          expect(viewer).to receive(:puts).with("\n\n#{file_2_name}")
          expect(viewer).to receive(:puts).with(file_2_contents)
          viewer.show_last_n_files(2)
        end
      end

      describe "wit colors" do
        it "adds color to the filename" do
          expect(viewer).to receive(:puts).with("\n\n#{file_1_name}".colorize(:red))
          expect(viewer).to receive(:puts).with("\n\n#{file_2_name}".colorize(:red))
          viewer.show_last_n_files(2)
        end
      end

      it "converts string args to int" do
        expect {
        viewer.show_last_n_files("2")
        }.to_not raise_error
      end
    end

    describe "#filename_from_index" do
      it "returns the filename associated with the index" do
        expect(viewer.filename_from_index(0)).to eql(file_1_name)
      end

      it "converts the index from string to int" do
        expect(viewer.filename_from_index("0")).to eql(file_1_name)
      end
    end
  end
end
