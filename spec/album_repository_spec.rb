require 'album_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  it "gets all albums and returns database columns" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums[0].id).to eq '1'
    expect(albums[0].title).to eq 'Greatest Hits 1'
    expect(albums[0].release_year).to eq '1980'
    expect(albums[0].artist_id).to eq '1'
    expect(albums[1].id).to eq '2'
    expect(albums[1].title).to eq 'Greatest Hits 2'
    expect(albums[1].release_year).to eq '1999'
    expect(albums[1].artist_id).to eq '2'
  end
 
  it "gets a single album" do
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.title).to eq ("Greatest Hits 1")
    expect(album.release_year).to eq ("1980")
  end

  it "creates an album entry" do
    repo = AlbumRepository.new
    album = Album.new
    album.title = 'Greatest Hits 3'
    album.release_year = '1992'
    album.artist_id = '3'

    repo.create(album)

    albums = repo.all
    last_album = albums.last

    expect(last_album.title).to eq "Greatest Hits 3"
    expect(last_album.release_year).to eq "1992"
  end

  it "updates an album entry" do
    repo = AlbumRepository.new

    album = repo.find(2)
    album.release_year = '1992'

    repo.update(album)

    updated_album = repo.find(2)

    expect(updated_album.id).to eq "2"
    expect(updated_album.title).to eq "Greatest Hits 2"
    expect(updated_album.release_year).to eq "1992"
    expect(updated_album.artist_id).to eq "2"
  end

  it "deletes an album entry" do
    repo = AlbumRepository.new
    repo.delete('2')
    albums = repo.all
    expect(albums.length).to eq 1
    album = repo.find(1)
    expect(album.title).to eq ("Greatest Hits 1")
    expect(album.release_year).to eq ("1980")
  end
end