require 'rails_helper'
# どのクラスのテストであるか
RSpec.describe User, type: :model do
  # どのメソッドのテストであるか（テスト対象）
  # #でインスタンスメソッドであることを示す
  # クラスメソッドの場合は.記号を付与
  describe '#total_score' do
    # create(:user)という処理をletに渡す
    # (宣言時点では作成されず、参照された時点で作成される)
    let(:user1) { create(:user) }

    context 'user_scoresテーブルにデータがある場合' do
      before do
        create(:user_score, user: user1, score: 4)
        create(:user_score, user: user1, score: 5)
        create(:user_score, user: user1, score: 6)
      end

      it 'スコアの合計を取得できること' do
        expect(user1.total_score).to eq 15
      end
    end

    context 'user_scoresテーブルにデータがない場合' do
      it 'スコアの合計は0である' do
        expect(user1.total_score).to eq 0
      end
    end
  end
end
