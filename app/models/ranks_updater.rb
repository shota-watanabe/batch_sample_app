class RanksUpdater
  def update_all
    # 現在のランキング情報をリセット
    Rank.transaction do
      Rank.delete_all
      # ユーザーごとのスコア合計を降順に並べ替え、そこからランキング情報を再作成する
      create_ranks
    end
  end

  def create_ranks
    RankOrderMaker.new.each_ranked_user do |user, rank|
      Rank.create(user_id: user.id, rank: rank, score: user.total_score)
    end
  end
end