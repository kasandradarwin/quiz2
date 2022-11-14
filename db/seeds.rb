# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


Idea.destroy_all
Review.destroy_all
User.destroy_all

PASSWORD = "123456"


10.times do
    p "create users"
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}@#{last_name}.com",
    password: PASSWORD,
    )
end

users = User.all

50.times do 
    created_at = Faker::Date.backward(days: 365 * 2)

        i = Idea.create(
        title: Faker::Company.bs,
        description: Faker::Lorem.paragraph(sentence_count: 6, supplemental: true),
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
    ) 
    
    if i.valid?
        rand(1..5).times do
            Review.create(body: Faker::Movies::BackToTheFuture.quote, idea: i)
        end
    end   
end


ideas = Idea.all
reviews = Review.all
p reviews