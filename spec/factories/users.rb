FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    # email                 {"iikkk@gmail.com"}
    email                 {Faker::Internet.free_email}
    password              {"ii00000000"}
    password_confirmation {"ii00000000"}
    # password  Faker::Internet.password(8)
    # nickname Faker::Name.last_name
    # email Faker::Internet.free_email
    family_name_kanji     {"佐藤"}
    first_name_kanji      {"航"}
    # family_name_kanji     {Faker::Japanese::Name.last_name}
    # first_name_kanji      {Faker::Japanese::Name.first_name}
    family_name_kana      {"サトウ"}
    first_name_kana       {"ワタル"}
    birth_year            {1992}
    birth_month           {1}
    birth_day             {22}
    phone_number          {Faker::Number.number(digits: 11)}
    postal_code           {Faker::Number.number(digits: 7)}
    prefecture_id         {13}
    city                  {"世田谷区"}
    house_number          {"松原"}
  end
end