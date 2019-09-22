FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    # email                 {"iikkk@gmail.com"}
    email {Faker::Internet.free_email}
    password              {"ii00000000"}
    password_confirmation {"ii00000000"}
    # password  Faker::Internet.password(8)
    # nickname Faker::Name.last_name
    # email Faker::Internet.free_email
    # password password
    # password_confirmation password
  end
end