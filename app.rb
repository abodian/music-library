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
    @io.puts "welcome to the music library manager!"
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