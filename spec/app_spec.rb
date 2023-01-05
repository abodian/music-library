require_relative "../app"


describe "Application class for music_library" do
  context "prompts the user as to whether they want to list artists or albums from music library database" do
    it "takes user input of 1 and lists all albums" do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the music library manager!")
      expect(io).to receive(:puts).with("\nWhat would you like to do?\n 1 - List all albums\n 2 - List all artists")
      expect(io).to receive(:puts).with("\nEnter your choice: ")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Here is the list of albums:")
      # expect(io).to receive(:puts).with("* 1 - Greatest Hits 1")
      # expect(io).to receive(:puts).with("* 2 - Greatest Hits 2")

      app = Application.new('music_library_test', io, 'album_repository', 'artist_repository')
      app.run
    end
  end
end