# namespaceを使ってタスク名の修飾
namespace :ranks do
  namespace :chapter2 do
    # バッチ処理の概要を記載
    desc 'chapter2 ゲーム内のユーザーランキング情報を更新する'
    # バッチ処理本体 {タスクA}: :{タスクAの前に実行するタスクB}
    # :environmentでconfig/environment.rbを読み込み、実行環境ごとの設定を反映
    task update: :environment do
      # 現在のランキング情報をリセット
      Rank.delete_all

      # ユーザーごとにスコアの合計を計算する
      # sum(&:score)は sum { |user_score| user_score.score }と同じ
      user_total_scores = User.all.map do |user|
        { user_id: user.id, total_score: user.user_scores.sum(&:score) }
      end

      # ユーザーごとのスコア合計の降順に並べ替え、そこからランキング情報を再作成する
      # group_byで同じtotal_scoreのハッシュをグルーピング
      # {8=>[{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}], 3=>[{:user_id=>3, :total_score=>3}]}
      # scoreに-1を掛けた値を基準に昇順で並び替え
      # sort_byが実行された時点では、group_byで作成された二次元の配列になる
      # [[9, [{:user_id=>5, :total_score=>9}]], [8, [{:user_id=>1, :total_score=>8}, {:user_id=>2, :total_score=>8}]], [3, [{:user_id=>3, :total_score=>3}]], [1, [{:user_id=>4, :total_score=>1}]]]

      sorted_total_score_groups = user_total_scores
                              .group_by { |score| score[:total_score] }
                              .sort_by { |score, _| score * -1 }
                              .to_h
                              .values

      sorted_total_score_groups.each.with_index(1) do |scores, index|
        scores.each do |total_score|
          Rank.create(user_id: total_score[:user_id], rank: index, score: total_score[:total_score])
        end
      end
    end
  end
end
