class User < ApplicationRecord
  has_many :user_scores
  has_one :rank

  def total_score
    # ||= で計算結果のキャッシュを保持。メソッドが2回目以降呼び出されたときの速度向上
    @total_score ||= user_scores.sum(&:score)
  end
end
