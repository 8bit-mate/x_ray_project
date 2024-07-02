TITLES = [
  {
    en: "Blue Suede Shoes",
    ru: "Синие замшевые туфли"
  },
  {
    en: "Blue Hotel",
    ru: "Грустный отель"
  },
  {
    en: "St. Louis Blues",
    ru: "St. Louis Blues"
  },
  {
    en: "Dark Eyes",
    ru: "Очи чёрные"
  },
  {
    en: "Serdce",
    ru: "Сердце"
  }
].freeze

def self.transform_string(input_string)
  characters = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  transformed_string = input_string.chars

  num_insertions = rand(1..5)
  num_insertions.times do
    position = rand(0..transformed_string.length)
    random_char = characters.sample
    transformed_string.insert(position, random_char)
  end

  transformed_string.join
end

def self.new_track
  track = Track.new(
    number: %w[A1 A2 A3 A4].sample,
    song: Song.all.sample
  )

  random_num = rand(1..10)
  filename = "#{random_num}.mp3"
  track.web_audio.attach(io: File.open(Pathname(__dir__).join("../storage/fake_data/#{filename}")), filename:)

  track
end

def self.new_band
  name = Faker::Music.band
  Artist.create(
    stage_name_en: name,
    stage_name_ru: name,
    description_en: Faker::Hipster.sentence
  )
end

user = User.new
user.email = "admin@admin.su"
user.password = "admin@admin.su"
user.password_confirmation = "admin@admin.su"
user.role = "admin"
user.save!

Preference.new(
  language: "en",
  user:
).save!

Category.find_or_create_by!(
  name_en: "Uncategorized",
  name_ru: "Несортированное",
  short_description_en: "Uncategorized",
  short_description_ru: "Несортированное",
  description_en: "",
  description_ru: "",
  visible: false
)

SongGroup.find_or_create_by!(
  title_en: "Unknown Title",
  title_ru: "Неизвестное название"
)

Artist.find_or_create_by!(
  stage_name_en: "Unknown Artist",
  stage_name_ru: "Неизвестный исполнитель"
)

25.times do |_i|
  name = Faker::Name.name
  Artist.create(
    stage_name_en: name,
    stage_name_ru: name,
    description_en: Faker::Hipster.sentence,
    bands: [new_band, new_band],
    aliases: [Artist.all.sample]
  )
end

TITLES.each do |title|
  SongGroup.create(
    title_en: title[:en],
    title_ru: title[:ru]
  )
end

20.times do |_i|
  song_group = SongGroup.all.sample

  art = [Artist.all.sample, Artist.all.sample]

  Song.new(
    year_of_release: Faker::Number.within(range: 1930..1970),
    song_group:,
    title_en: transform_string(song_group.title_en),
    title_ru: transform_string(song_group.title_ru),
    artists: art,
    main_artist: art.first
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

30.times do |i|
  record = Record.new(
    number: i,
    category: Category.find_or_create_by!(
      name_en: "X-Ray Records",
      name_ru: "Пластинки на костях",
      visible: true
    ),
    label: Label.find_or_create_by!(
      name_en: "Golden Dog Records",
      name_ru: "Золотая собака",
      visible: true
    ),
    format_tags: [FormatTag.all.sample, FormatTag.all.sample, FormatTag.all.sample],
    format_size: [7, 8, 9, 10].sample,
    tracks: [new_track, new_track]
  )

  random_num = rand(1..22)
  filename = "#{random_num}.jpg"
  record.web_images.attach(io: File.open(Pathname(__dir__).join("../storage/fake_data/#{filename}")),
                           filename:)
  sleep(1)

  record.save
end
