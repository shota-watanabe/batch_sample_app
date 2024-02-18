FactoryBot.define do
  factory :user_score do
    # リレーション定義
    # create(:user_score)でuserデータも作成されるようになる
    association :user
    score { 1 }
    received_at { Time.current }
  end
end
