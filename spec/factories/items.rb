FactoryBot.define do
  factory :item do
    name                    { 'テスト商品' }
    description             { 'これはテスト用の商品です' }
    category_id             { 2 } # 「---」でないもの
    condition_id            { 2 }
    shipping_fee_status_id  { 2 }
    prefecture_id           { 2 }
    scheduled_delivery_id   { 2 }
    price                   { 1000 }

    association :user # ← ユーザーとのつながり（要user factory）

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test-image.png')),
        filename: 'test-image.png',
        content_type: 'image/png'
      )
    end
  end
end
