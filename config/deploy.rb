# config valid only for current version of Capistrano

# DIVE20_2_AWSデプロイ編 で編集  
# 最初にファイルが作られた時点では下記3行には
# コメントがなかったが、テキストに従い、
# 全てコメント化し、最下行にテキストの内容をコピーする
# lock '3.6.0'

# set :application, 'my_app_name'
# set :repo_url, 'git@example.com:me/my_repo.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


# DIVE20_2_AWSデプロイ編 で編集  
# 下記を書き加える
lock '3.6.0'

# デプロイするアプリケーション名
set :application, 'achieve'

# cloneするgitのレポジトリ（xxxxxxxx：ユーザ名、yyyyyyyy：アプリケーション名）
set :repo_url, 'https://github.com/samemiya/achieve'

# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, ENV['BRANCH'] || 'master'

# deploy先のディレクトリ。
set :deploy_to, '/var/www/achieve'

# シンボリックリンクをはるフォルダ・ファイル
set :linked_files, %w{.env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# Rubyのバージョン
set :rbenv_ruby, '2.3.0'
set :rbenv_type, :system

#出力するログのレベル。
set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end

# http://nograve.hatenadiary.jp/entry/2015/10/07/161247
# ここを参考にして下記をセットしてみる
set :default_env, {
	rbenv_root: "/usr/local/rbenv",
	path: "~/.rbenv/shims:~/.rbenv/bin:$PATH",
	AWS_REGION: ENV['AWS_REGION'],
	AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
        AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :sidekiq_queue, :carrierwave