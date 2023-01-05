require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

# album_repository = AlbumRepository.new

# album_repository.all.each do |artist|
#   p artist.title
# end

# single_album = album_repository.find(3)

# puts single_album.id
# puts single_album.title
# puts single_album.release_year

# puts "#{single_album.id} - #{single_album.title} - #{single_album.release_year}"

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!"
    @io.puts "\nWhat would you like to do?\n 1 - List all albums\n 2 - List all artists"
    @io.puts "\nEnter your choice: "
    user_choice = @io.gets.chomp

    if user_choice == '1'
      @io.puts "Here is the list of albums:"
      album_repository = AlbumRepository.new
      counter = 1
      album_repository.all.each do |album|
        puts "* #{counter} - #{album.title}"
        counter += 1
      end
    else
      @io.puts "Here is the list of artists:"
      artist_repository = ArtistRepository.new
      artist_names = []
      
      counter = 1
      artist_repository.all.each do |artist|
        artist_names << artist.name
      end
      artist_names.uniq.each do |name|
        puts "* #{counter} - #{name}"
        counter += 1
      end
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
