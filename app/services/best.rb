module Best
  def search_best(score_array, results)
    score_array.each_with_index do |_, i|
      results[i]["best"] == score_array.max ? results[i]["best"] = true : results[i]["best"] = false
    end
    results
  end
  module_function :search_best
end