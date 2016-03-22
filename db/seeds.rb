# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Category.delete_all
Word.delete_all
WordAnswer.delete_all

User.create!(name:  "Dren Gravidez",
             email: "gravides.dren@gmail.com",
             password:              "asdasd",
             password_confirmation: "asdasd",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "a#{n+1}@framgia.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

5.times do |t|
  5.times do
    @category = Faker::Lorem.word
    break if Category.where(name: @category).blank?
  end
  Category.create!(name: @category)
end

cat = Category.all
cat.each do |c|
  20.times do |n|
    2000.times do
      @word = Faker::Lorem.word
      break if Word.where(content: @word).blank?
    end
    Word.create!(category_id: c.id,
      content: @word)
  end
end

cat.each do |c|
  c.words.each do |cw|
    2000.times do
      @word = Faker::Lorem.word
      break if WordAnswer.where(content: @word, word_id: cw.id).blank?
    end
    WordAnswer.create!(word_id: cw.id,
      content: @word,
      correct: true)
  end
end

cat.each do |c|
  c.words.each do |cw|
    3.times do |d|
     2000.times do
        @word = Faker::Lorem.word
        break if WordAnswer.where(content: @word, word_id: cw.id, correct: false).blank?
      end
      WordAnswer.create!(word_id: cw.id,
        content: @word,
        correct: false)
    end
  end
end



# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
