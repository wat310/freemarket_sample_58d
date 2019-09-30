# categoryの初期データ
# seedファイルにこのファイルを同時に読み込むように記述済み

#親カテゴリのみ
lady = Category.create(name: "レディース")
man = Category.create(name: "メンズ")
# book = Category.create(name: "本・音楽・ゲーム")
electro = Category.create(name: "家電・スマホ・カメラ")
hobby = Category.create(name: "おもちゃ・ホビー・グッズ")
other = Category.create(name: "その他")

#レディースの子カテゴリ
lady_tops = lady.children.create(name: "トップス")
lady_jacket = lady.children.create(name: "ジャケット/アウター")
# lady_shoes = lady.children.create(name: "靴")

#レディースの孫カテゴリ
lady_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "その他"}])
lady_jacket.children.create([{name: "テーラードジャケット"}, {name: "ノーカラージャケット"}, {name: "その他"}])
# lady_shoes.children.create([{name: "ハイヒール/パンプス"}, {name: "ブーツ"}, {name: "その他"}])

#メンズの子カテゴリ
man_tops = man.children.create(name: "トップス")
man_jacket = man.children.create(name: "ジャケット/アウター")
# man_shoes = man.children.create(name: "靴")

#メンズの孫カテゴリ
man_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "その他"}])
man_jacket.children.create([{name: "コート"}, {name: "ジャケット/上着"}, {name: "トップス(その他)"}])
# man_shoes.children.create([{name: "スニーカー"}, {name: "サンダル"}, {name: "その他"}])

#本の子カテゴリ
# book_book = book.children.create(name: "本")
# book_cd = book.children.create(name: "CD")
# book_game = book.children.create(name: "テレビゲーム")

#本の孫カテゴリ
# book_book.children.create([{name: "文学/小説"}, {name: "人文/社会"}, {name: "その他"}])
# book_cd.children.create([{name: "邦楽"}, {name: "洋楽"}, {name: "アニメ"}, {name: "その他"}])
# book_game.children.create([{name: "家庭用ゲーム本体"}, {name: "家庭用ゲームソフト"}, {name: "その他"}])

#機械の子カテゴリ
electro_phone = electro.children.create(name: "スマートフォン/携帯電話")
electro_accessory = electro.children.create(name: "スマホアクセサリー")
electro_pc = electro.children.create(name: "PC/タブレット")


#機械の孫カテゴリ
electro_phone.children.create([{name: "スマートフォン本体"}, {name: "バッテリー/充電器"}, {name: "携帯電話本体"}, {name: "その他"}])
electro_accessory.children.create([{name: "Android用ケース"}, {name: "iPhone用ケース"}, {name: "カバー"}, {name: "イヤホンジャック"}, {name: "ストラップ"}, {name: "フィルム"}, {name: "自撮り棒"}, {name: "その他"}])
electro_pc.children.create([{name: "タブレット"}, {name: "ノートPC"}, {name: "デスクトップ型PC"}, {name: "ディスプレイ"}, {name: "PC周辺機器"}, {name: "その他"}])

#おもちゃの子カテゴリ
hobby_hobby = electro.children.create(name: "おもちゃ")
hobby_comic = electro.children.create(name: "コミック/アニメグッズ")
hobby_other = electro.children.create(name: "その他")

#おもちゃの孫カテゴリ
hobby_hobby.children.create([{name: "キャラクターグッズ"}, {name: "ぬいぐるみ"}, {name: "小物/アクセサリー"}, {name: "その他"}])
hobby_comic.children.create([{name: "ストラップ"}, {name: "キーホルダー"}, {name: "バッジ"}, {name: "カード"}, {name: "クリアファイル"}, {name: "その他"}])
hobby_other.children.create([{name: "トランプ/UNO"}, {name: "ダーツ"}, {name: "麻雀"}, {name: "パズル/ジグソーパズル"}, {name: "囲碁/将棋"}, {name: "オセロ/チェス"}, {name: "その他"}])

#その他の子カテゴリ
other_food = other.children.create(name: "食品")
other_drink = other.children.create(name: "飲料/酒")

#その他の孫カテゴリ
other_food.children.create([{name: "菓子"}, {name: "米"}, {name: "その他"}])
other_drink.children.create([{name: "コーヒー"}, {name: "ソフトドリンク"}, {name: "その他"}])
