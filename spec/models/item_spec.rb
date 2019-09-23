require 'rails_helper'

describe Item do
  describe '#create' do
    context 'can save' do # 保存できる時

      # brand_idが空の時、保存ができる
      it "is valid without brand_id" do
        expect(create(:item, brand_id: "")).to be_valid
      end

      # nameが1文字の時、保存ができる
      it "is valid = 1word" do
        expect(create(:item, name: "a")).to be_valid
        # binding.pry
      end

      # nameが40文字の時、保存ができる
      it "is valid = 40words" do
        word = "a" * 40
        expect(create(:item, name: word)).to be_valid
      end

      # priceが300円の時、保存できる
      it "is valid price = 300yen" do
        expect(create(:item, price: 300)).to be_valid
      end

      # priceが9999999円の時、保存できる
      it "is valid price = 9999999yen" do
        expect(create(:item, price: 9999999)).to be_valid
      end

      # explanationが1000文字の時、保存できる
      it "is valid explanation = 1000words" do
        word = "a" * 1000
        expect(create(:item, explanation: word)).to be_valid
      end

    end

    context 'can not save' do # 保存できない時

      # nameが空の時、保存できない
      it "is invalid without name" do
        item = build(:item, name:"")
        item.valid?
        expect(item.errors[:name]).to include("を入力してください", "は1文字以上で入力してください")
      end

      # nameが41文字以上の時、保存できない
      it "is invalid name over 41words" do
        word = "a" * 41
        item = build(:item, name: word)
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end

      # priceが空の時、保存できない
      it "is invalid without price" do
        item = build(:item, price: "")
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end

      # priceが299円以下の時、保存できない
      it "is invalid price over 299yen" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("は300以上の値にしてください")
      end

      # priceが10000000円以上の時、保存できない
      it "is invalid price over 10000000yen" do
        item = build(:item, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include("は9999999以下の値にしてください")
      end

      # explanationが空の時、保存できない
      it "is invalid without explanation" do
        item = build(:item, explanation: "")
        item.valid?
        expect(item.errors[:explanation]).to include("を入力してください")
      end

      # explanation1001文字以上の時、保存できない
      it "is invalid explanation over 1001words" do
        word = "a" * 1001
        item = build(:item, explanation: word)
        item.valid?
        expect(item.errors[:explanation]).to include("は1000文字以内で入力してください")
      end

      # stateが空の時、保存できない
      it "is invalid without state" do
        item = build(:item, state: "")
        item.valid?
        expect(item.errors[:state]).to include("を入力してください")
      end

      # postageが空の時、保存できない
      it "is invalid without postage" do
        item = build(:item, postage: "")
        item.valid?
        expect(item.errors[:postage]).to include("を入力してください")
      end

      # shipping_methodが空の時、保存できない
      it "is invalid without shipping_method" do
        item = build(:item, shipping_method: "")
        item.valid?
        expect(item.errors[:shipping_method]).to include("を入力してください")
      end

      # prefecture_idが空の時、保存できない
      it "is invalid without prefecture_id" do
        item = build(:item, prefecture_id: "")
        item.valid?
        expect(item.errors[:prefecture_id]).to include("を入力してください")
      end

      # business_statusが空の時、保存できない
      it "is invalid without business_status" do
        item = build(:item, business_status: "")
        item.valid?
        expect(item.errors[:business_status]).to include("を入力してください")
      end

      # category_idが空の時、保存できない
      it "is invalid without category_id" do
        item = build(:item, category_id: "")
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end

    end
  end
end