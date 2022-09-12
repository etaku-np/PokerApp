module BestService
  # 判定された複数の役に基づき、そのうち最も強い役を判定するモジュールです
  def judge_best(score_array, results)
    score_array.each_with_index do |_, i|
      score = results[i]["best"]
      true_or_false = (score == score_array.max)
      results[i]["best"] = true_or_false
    end
    results
  end
  module_function :judge_best
end