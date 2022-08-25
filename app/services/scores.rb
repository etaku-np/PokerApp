module Scores
  def search_best(score_array, results)

    (0..score_array.length - 1).each do |i|
      results[i]["best"] == score_array.max ? results[i]["best"] = true : results[i]["best"] = false
    end

    results

  end

  module_function :search_best

end