# rake db:seedの時に一緒に読み込むための記述
require './db/seeds/category.rb'
require './db/seeds/brand.rb'

# このuserのseedファイルは本番環境テスト用、最終的には消します!!
require './db/seeds/user.rb'