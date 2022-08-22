# module Score
#
#   class Score
#
#     include Hands
#
#     def search_score(cards)
#
#       @carr = cards.split
#       #受け取ったカードを、スートとナンバーに分ける
#       @suit_array = cards.delete("^SHDC ").split
#       @num_array_s = cards.delete("^0-9 ").split
#       #ナンバーを文字列から数値に変換して、並び替え
#       @num_array_i = @num_array_s.map(&:to_i).sort
#
#     end
#
#     def calc
#       if Hands.judge == "ストレートフラッシュ"
#         8
#       elsif Hands.judge == "フラッシュ"
#         7
#       end
#     end
#   end
#
# endca