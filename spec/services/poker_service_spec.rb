require 'rails_helper'

RSpec.describe PokerService, type: :service do
  include PokerService

  describe "#judge_results" do
    let(:error){ PokerSyntaxError.check_syntax_errors(cards) }
    let(:result){ PokerHand.judge(cards)[:name] }

    context "with hand, no error" do
      let(:cards){ "H6 C8 C1 D10 S1" }
      it "returns a result" do
        expect(error||result).to eq result
      end
    end

    context "with error, no hand" do
      context "when the number of cards is other than 5" do
        let(:cards){ "H6 C8 C1 D10" }
        it "returns an error" do
          expect(error||result).to eq error
        end
      end
    end
  end

  describe "#compare_results" do
    let(:results){ PokerService.compare_results(cards_set)[:results] }
    let(:errors){ PokerService.compare_results(cards_set)[:errors] }

    context "when only valid cards are entered" do
      let(:cards_set){
        [
          "S10 S11 S9 S7 S8",
          "C2 C3 C4 C5 C6",
          "D3 S3 H12 H3 C12"
        ]
      }
      it "returns correct results" do
        expect(results.map{|result| result[:hand]}).to eq %w[ストレートフラッシュ ストレートフラッシュ フルハウス]
      end
      it "returns correct results" do
        expect(results.map{|result| result[:best]}).to eq [true, true, false]
      end
      it "dose not display array of errors" do
        expect(errors).to eq nil
      end
    end

    context "when valid/invalid cards are entered" do
      let(:cards_set){
        [
          "D10 S10 C9 S8 H8",
          "C2 H6 D6 S6 C6",
          "F3 S4 C9 D8 H5",
          "D3 D3 H12 H3 C12"
        ]
      }
      it "returns correct hands" do
        expect(results.map{|result| result[:hand]}).to eq %w[ツーペア フォーカード]
      end
      it "returns correct bests" do
        expect(results.map{|result| result[:best]}).to eq [false, true]
      end
      it "returns correct errors" do
        expect(errors.map{|error| error[:msg]}).to eq [["1番目のカード指定文字が不正です。(F3)"], ["カードが重複しています。"]]
      end
    end

    describe "the invalid input" do
      let(:error_msg) { PokerService.cards_set_error_msg(cards_set)[:errors][0][:msg] }

      context "when a duplicate pair of cards is entered" do
        let(:cards_set){
          [
            "C2 C3 C4 C5 C6",
            "C2 C3 C4 C5 C6"
          ]
        }
        it "returns error message" do
          expect(error_msg).to eq "カードが入力されていないか、重複したカード組が入力されています。"
        end
      end

      context "when nothing is entered in array" do
        let(:cards_set){ [] }
        it "returns error message" do
          expect(error_msg).to eq "カードが入力されていないか、重複したカード組が入力されています。"
        end
      end
    end
  end
end