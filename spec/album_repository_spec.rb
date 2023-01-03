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
    expect(repo.find(1)).to eq [{"id"=>"1", "title"=>"Greatest Hits 1", "release_year"=>"1980", "artist_id"=>"1"}]
  end

  it "creates an album entry" do
    repo = AlbumRepository.new
    repo.create('Greatest Hits 3', '1992', '3')
    expect(repo.find(3)).to eq [{"id"=>"3", "title"=>"Greatest Hits 3", "release_year"=>"1992", "artist_id"=>"3"}]
  end

  it "updates an album entry" do
    repo = AlbumRepository.new
    repo.update('release_year', '1992', '2')
    expect(repo.find(2)).to eq [{"id"=>"2", "title"=>"Greatest Hits 2", "release_year"=>"1992", "artist_id"=>"2"}]
  end

  it "deletes an album entry" do
    repo = AlbumRepository.new
    repo.delete('2')
    albums = repo.all
    expect(albums.length).to eq 1
    expect(repo.find(1)).to eq [{"id"=>"1", "title"=>"Greatest Hits 1", "release_year"=>"1980", "artist_id"=>"1"}]
  end
end