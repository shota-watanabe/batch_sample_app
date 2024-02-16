# namespaceを使ってタスク名の修飾
namespace :ranks do
  namespace :chapter2 do
    # バッチ処理の概要を記載
    desc 'chapter2 ゲーム内のユーザーランキング情報を更新する'
    # バッチ処理本体 {タスクA}: :{タスクAの前に実行するタスクB}
    # :environmentでconfig/environment.rbを読み込み、実行環境ごとの設定を反映
    task update: :environment do
    end
  end
end
