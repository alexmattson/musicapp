
50.times do
  Band.create(name: Faker::Name.name)
end

150.times do
  Album.create(band_id: (rand(50) + 1),
                title: Faker::Pokemon.name,
                recording_type: Album::RECORDING_TYPE.sample,
                year: (rand(116) + 1900))
end

500.times do
  Track.create(name: Faker::StarWars.quote,
               album_id: (rand(150) + 1),
               ord: (rand(10) + 1),
               track_type: Track::TRACK_TYPE.sample,
               lyrics: Faker::Hipster.paragraph)
end

50.times do
  User.create(email: Faker::Internet.email, password: "password", password2: "password")
end

User.create(email: "test@email.com", password: "password", password2: "password")

5000.times do
  Note.create(note: Faker::Hipster.sentence,
              user_id: (rand(50) + 1),
              track_id: (rand(500) + 1))
end
