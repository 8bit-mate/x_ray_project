def self.new_track
  track = Track.new(
    number: %w[A1 A2 A3 A4].sample,
    song: Song.all.sample
  )

  random_num = rand(1..5)
  filename = "#{random_num}.mp3"
  track.web_audio.attach(io: File.open(Pathname(__dir__).join("../storage/fake_data/#{filename}")), filename:)

  track
end

Category.find_or_create_by!(
  name_en: "Uncategorized",
  name_ru: "Несортированное",
  short_description_en: "Uncategorized",
  short_description_ru: "Несортированное",
  description_en: "",
  description_ru: "",
  visible: false
)

SongTitle.find_or_create_by!(
  title_en: "Unknown Title",
  title_ru: "Неизвестное название"
)

Artist.find_or_create_by!(
  first_name_en: "Unknown Artist",
  first_name_ru: "Неизвестный исполнитель"
)

user = User.new
user.email = "admin@admin.su"
user.password = "admin@admin.su"
user.password_confirmation = "admin@admin.su"
user.role = "admin"
user.save!

25.times do |_i|
  Artist.create(
    first_name_en: Faker::Name.first_name,
    last_name_en: Faker::Name.last_name,
    description_en: Faker::Hipster.sentence
  )
end

25.times do |_i|
  SongTitle.create(
    title_en: Faker::Music::RockBand.song
  )
end

25.times do |_i|
  Song.new(
    year_of_release: Faker::Number.within(range: 1930..1970),
    song_title: SongTitle.all.sample,
    artists: [Artist.all.sample, Artist.all.sample]
  ).update_full_title
end

20.times do |_i|
  FormatTag.create(
    visible: true,
    name_en: Faker::Hipster.word,
    short_description_en: Faker::Hipster.sentence,
    description_en: Faker::Hipster.sentence
  )
end

15.times do |i|
  record = Record.new(
    number: i,
    category: Category.find_or_create_by!(
      name_en: "X-Ray Records",
      name_ru: "Пластинки на костях",
      visible: true
    ),
    format_tags: [FormatTag.all.sample, FormatTag.all.sample, FormatTag.all.sample],
    tracks: [new_track, new_track]
  )

  random_num = rand(1..22)
  filename = "#{random_num}.jpg"
  record.web_images.attach(io: File.open(Pathname(__dir__).join("../storage/fake_data/#{filename}")),
                           filename:)

  record.save
end
