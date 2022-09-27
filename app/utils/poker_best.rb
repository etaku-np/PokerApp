# 判定された複数の役に基づき、そのうち最も強い役を判定
module PokerBest
  def judge_best(results)
    score_array = results.map{ |result| result[:best] }

    score_array.each_with_index do |_, i|
      results[i][:best] = (results[i][:best] == score_array.max)
    end

    results
  end
  module_function :judge_best
end