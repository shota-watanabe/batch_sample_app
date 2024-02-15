class CreateUserScores < ActiveRecord::Migration[6.0]
  def change
    create_table :user_scores, comment: 'ユーザーがゲーム内で獲得した点数' do |t|
      # 外部キー設定
      # on_delete(削除時がトリガー) :cascade(参照元が削除されたとき、参照しているテーブルを削除)
      # on_delete(更新時がトリガー) :cascade(参照元が更新されたとき、参照しているテーブルを更新)
      t.references :user, null: false, foreign_key: { on_delete: :cascade, on_update: :cascade }, comment: 'ユーザー'
      t.integer :score, null: false, default: 0, comment: 'ユーザーが獲得した点数'
      # スコアを更新した日付であることをわかりやすい名前でカラム作成
      t.datetime :received_at, null: false, index: true, comment: '点数を獲得した日時'

      t.timestamps null: false
    end
  end
end
