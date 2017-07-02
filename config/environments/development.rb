Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.

  # DIVE13_デバック：エラーページで編集
  # 開発環境でエラーが表示されることを確認するには「false」に変更する
  # false <= true
  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # DIVE11_メール送信　で編集
  # cloud9を使っている場合、localhostではなく、
  # 自分のcloud9アプリのURLにする必要がある
  # config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.default_url_options = { host: 'https://dive-into-code-amemy.c9users.io/' }
  # 開発環境でメール送信の際、letter_opener_webを使用するように設定
  config.action_mailer.delivery_method = :letter_opener_web

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # DIVE11_メール送信　で編集
  # 下のコマンドを入れたら、サインアップ－認証を経由して
  # ユーザー登録しないとログインできないようになった
  # config.action_mailer.default_url_options = { host: 'warm-lowlands-91711' }
  config.action_mailer.default_url_options = { host: 'https://dive-into-code-amemy.c9users.io/' }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings =
  {
   user_name: 'ame',
   password: 'asDF',
   domain: "ntc.co.jp",
   address: "smtp.sendgrid.net",
   port: 587,
   authentication: :plain,
   enable_starttls_auto: true
  }

  # DIVE13_デバック：エラーページ　で編集
  # エラーを解析するためのツール
  BetterErrors::Middleware.allow_ip! "0.0.0.0/0"  

end
