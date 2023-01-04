single_album = album_repository.find(1)
single_album.each do |album|
  p album['title']
end