require 'objspace'

namespace :ranks do
  namespace :chapter3 do
    desc 'chapter3 ゲーム内のユーザーランキング情報を更新する'
    task update: :environment do
      Development::UsedMemoryReport.instance.write('start batch')

      # 10のパラメーターは出力結果1行目のラベルごとの文字幅を指定
      Benchmark.bm 10 do |r|
        # ラベルをつける(どの処理の実行時間であるか)
        r.report 'RanksUpdater' do
          RanksUpdater.new.update_all
        end
      end

      Development::UsedMemoryReport.instance.write('end batch')
      Development::UsedMemoryReport.instance.puts_all
    end
  end
end
