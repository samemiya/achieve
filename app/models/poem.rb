# DIVE14_API基礎編２で編集
# gails g コマンドでモデルを作成した最初の状態
# class Poem < ActiveRecord::Base
# end

# 次のように修正
class Poem < ActiveResource::Base #ActiveRecord::Baseから変更する
  # HEROKU にupしたアプリ
  self.site = "https://supermarche-vin-79191.herokuapp.com"

  # テスト用 cloud9のアプリ
  # こっちをAPI先として使用しようとすると
  # viewのところでエラーになってしまう
  # self.site = "https://ide.c9.io/amemy/dive-into-code/"
end
