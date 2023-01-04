require_relative 'lib/database_connection'
require_relative 'lib/album_repository'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new

album_repository.all.each do |artist|
  p artist.title
end

single_album = album_repository.find(3)

puts single_album.id
puts single_album.title
puts single_album.release_year
