require_relative './album'

class AlbumRepository
  def all
    sql = "SELECT id, title, release_year, artist_id FROM albums;"
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      albums << album
    end
    return albums
  end

  def find(album_id)
    sql = "SELECT id, title, release_year, artist_id FROM albums WHERE id = #{album_id};"
    result_set = DatabaseConnection.exec_params(sql, [])
    return result_set.to_a
  end

  def create(album_title, release_year, artist_id)
    sql = "INSERT INTO albums (title, release_year, artist_id) VALUES('#{album_title}', '#{release_year}', '#{artist_id}');"
    DatabaseConnection.exec_params(sql, [])
  end

  def update(column_name, change_to, album_id)
    sql = "UPDATE albums SET #{column_name} = #{change_to} WHERE id = #{album_id}"
    DatabaseConnection.exec_params(sql, [])
  end

  def delete(album_id)
    sql = "DELETE FROM albums WHERE id = #{album_id}"
    DatabaseConnection.exec_params(sql, [])
  end
end