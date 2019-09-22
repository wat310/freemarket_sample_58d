FactoryBot.define do
  factory :item do
    name            {"シャツ"}
    price           {5000}
    explanation     {"非売品"}
    size            {1}
    state           {1}
    postage         {1}
    shipping_method {1}
    shipping_date   {1}
    business_status {0}
    prefecture_id   {1}
    user
    category
    brand
  end
end
