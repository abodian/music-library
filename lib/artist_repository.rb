require_relative './artist'

class ArtistRepository
  def all
    sql = "SELECT id, name, genre FROM artists;"
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end
    return artists
  end

  def find(artist_id)
    sql = "SELECT id, name, genre FROM artists WHERE id = $1;"
    params = [artist_id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    return artist
  end

  def create(artist)
    sql = "INSERT INTO artists (name, genre) VALUES($1, $2);"
    sql_params = [artist.name, artist.genre]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(artist)
    sql = "UPDATE artists SET name = $1, genre = $2 WHERE id = $3;"
    sql_params = [artist.name, artist.genre, artist.id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(artist_id)
    sql = "DELETE FROM artists WHERE id = $1"
    sql_parameters = [artist_id]
    DatabaseConnection.exec_params(sql, sql_parameters)
  end
end

