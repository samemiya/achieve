# DIVE19_2_通知機能 で編集 
# pusherのユーザー登録後、gemを追加し、
# 新規ファイル作成　変数として登録する
require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]
Pusher.cluster = 'ap1'
Pusher.logger = Rails.logger
Pusher.encrypted = true

