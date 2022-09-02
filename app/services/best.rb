module Best
  def search_best(score_array, results)
    score_array.each_with_index do |_, i|
      best = results[i]["best"]
      tf = best == score_array.max ? true : false
      results[i]["best"] = tf
    end
    results
  end
  module_function :search_best
end