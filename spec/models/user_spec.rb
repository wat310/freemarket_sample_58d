  
require 'rails_helper'

describe User do
  describe '#create' do
    it "factory_botのdataは登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "nicknameが空では登録不可" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailが空では登録不可" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください", "は不正な値です")
    end
    it "emailが重複すると登録不可" do
      user = create(:user, email: "aaa@gmail.com")
      another_user = build(:user, email: "aaa@gmail.com")
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    it "emailが@を含まないと登録不可" do
      user = build(:user, email: "aaaaa")
      user.valid?
      expect(user.errors[:email][0]).to include("は不正な値です")
    end
    it "emailの@の前に文字がないと登録不可" do
      user = build(:user, email: "@aaa")
      user.valid?
      expect(user.errors[:email][0]).to include("は不正な値です")
    end
    it "emailの@の後に文字がないと登録不可" do
      user = build(:user, email: "aaaa@")
      user.valid?
      expect(user.errors[:email][0]).to include("は不正な値です")
    end
    it "emailに英数字と記号以外の文字が含まれると登録不可" do
      user = build(:user, email: "aaあa@aaa")
      user.valid?
      expect(user.errors[:email][0]).to include("は不正な値です")
    end
    it "passwordが空だと登録不可" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は7文字以上で入力してください")
    end
    it "passwordはあってもpassword_confirmationが空だと登録不可" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end
    it "passwordが6文字未満だと登録不可" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("は6文字以上で入力してください")
    end
    it "first_name_kanjiが空だと登録不可" do
      user = build(:user, first_name_kanji: nil)
      user.valid?
      expect(user.errors[:first_name_kanji]).to include("を入力してください")
    end
    it "family_name_kanjiが空だと登録不可" do
      user = build(:user, family_name_kanji: nil)
      user.valid?
      expect(user.errors[:family_name_kanji]).to include("を入力してください")
    end
    it "first_name_kanaが空だと登録不可" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end
    # it "first_name_kanaにカナ以外が含まれると登録不可" do
    #   user = build(:user, first_name_kana: "カナa")
    #   user.valid?
    #   expect(user.errors[:first_name_kana][0]).to include("is invalid")
    # end
    it "family_name_kanaが空だと登録不可" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end
    # it "family_name_kanaにカナ以外が含まれると登録不可" do
    #   user = build(:user, family_name_kana: "カナa")
    #   user.valid?
    #   expect(user.errors[:family_name_kana][0]).to include("is invalid")
    # end
  end
end