# category等の初期データの記述
#メンズ
men = Category.create(name: "メンズ")
men_tops = men.children.create(name: "トップス")
men_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}])