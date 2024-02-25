module Chapter5
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
      ranks = []
      RankOrderMaker.new.each_ranked_user do |user, rank|
        ranks << Rank.new(user_id: user.id, rank: rank, score: user.total_score)
      end

      Development::UsedMemoryReport.instance.write('after RankOrderMaker.new.each_ranked_user')

      Rank.import ranks

      Development::UsedMemoryReport.instance.write('after Rank.import')
    end
  end
end
