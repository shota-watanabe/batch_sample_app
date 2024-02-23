module Development
  class UsedMemoryReport
    # Singletonモジュール
    include Singleton

    def initialize
      @reports = []
    end

    def write(label)
      # ObjectSpace.memsize_of_all
        # 実行時点の消費メモリ量をバイト単位で取得することができる
        # 0.001を2回かけメガバイト単位で表示
      @reports << "used memory: #{label} #{ObjectSpace.memsize_of_all * 0.001 * 0.001} MB"
    end

    def puts_all
      @reports.each { |report| puts report }
    end
  end
end
