require 'artist_repository'

def reset_artists_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_artists_table
  end

  it "gets all artists and returns database columns" do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq 2
    expect(artists[0].id).to eq '1'
    expect(artists[0].name).to eq 'Pixies'
    expect(artists[0].genre).to eq 'Rock'
    expect(artists[1].id).to eq '2'
    expect(artists[1].name).to eq 'ABBA'
    expect(artists[1].genre).to eq 'Pop'
  end
 
  it "gets a single artist" do
    repo = ArtistRepository.new
    artist = repo.find(1)
    expect(artist.name).to eq ("Pixies")
    expect(artist.genre).to eq ("Rock")
  end

  it "creates an artist entry" do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = 'Nirvana'
    artist.genre = 'Rock'

    repo.create(artist)

    artists = repo.all
    last_artist = artists.last

    expect(last_artist.name).to eq "Nirvana"
    expect(last_artist.genre).to eq "Rock"
  end

  it "updates an artist entry" do
    repo = ArtistRepository.new

    artist = repo.find(2)
    artist.genre = 'Jazz'

    repo.update(artist)

    updated_artist = repo.find(2)

    expect(updated_artist.id).to eq "2"
    expect(updated_artist.name).to eq "ABBA"
    expect(updated_artist.genre).to eq "Jazz"
  end

  it "deletes an artist entry" do
    repo = ArtistRepository.new
    repo.delete('2')
    artists = repo.all
    expect(artists.length).to eq 1
    artist = repo.find(1)
    expect(artist.name).to eq ("Pixies")
    expect(artist.genre).to eq ("Rock")
  end
end