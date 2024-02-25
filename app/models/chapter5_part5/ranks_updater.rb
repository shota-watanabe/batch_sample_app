module Chapter5Part5
  class RanksUpdater
    def update_all
      # 現在のランキング情報をリセット
      Rank.transaction do
        Rank.delete_all
        # ユーザーごとのスコア合計を降順に並べ替え、そこからランキング情報を再作成する
        Development::UsedMemoryReport.instance.write('after Rank.delete_all')
        create_ranks
      end
    end

    def create_ranks
      # batch_sizeで指定した件数ずつテーブルからデータを読み込む
      User.includes(:user_scores).find_in_batches(batch_size: 100) do |users|
        Rank.import users
                      .select { |user| user.total_score.nonzero? }
                      .map { |user| { user_id: user.id, score: user.total_score }  }
      end
    end
  end
end
