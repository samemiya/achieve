class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      # DIVE19_2_通知機能 で編集 
      # nil が入らないように default: false を追加
      t.boolean :read, default: false
      t.references :user, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
