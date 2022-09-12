require 'rails_helper'

RSpec.describe Best, type: :service do
  include Best

  describe "#search_best" do

    let(:new_results) { Best.judge_best(score_array, results) }

    context "when 2 sets of cards with different hands are entered" do
      let(:score_array) { [0, 4] }
      let(:results) {
        [
          {
            "cards" => "S5 D12 D8 C4 H7",
            "hands" => "ハイカード",
            "best" => 0
          },
          {
            "cards" => "S5 D6 D4 C3 H7",
            "hands" => "ストレート",
            "best" => 4
          }
        ]
      }

      it "turns the 1st 'best' into false" do
        expect(new_results[0]["best"]).to eq false
      end

      it "turns the 2nd 'best' into true" do
        expect(new_results[1]["best"]).to eq true
      end

    end

    context "when 3 sets of cards with different hands are entered" do
      let(:score_array) { [8, 8, 6] }
      let(:results) {
        [
          {
            "cards" => "S10 S11 S9 S7 S8",
            "hands" => "ストレートフラッシュ",
            "best" => 8
          },
          {
            "cards" => "C2 C3 C4 C5 C6",
            "hands" => "ストレートフラッシュ",
            "best" => 8
          },
          {
            "cards" => "D3 S3 H12 H3 C12",
            "hands" => "フルハウス",
            "best" => 6
          }
        ]
      }

      it "turns the 1st 'best' into true" do
        expect(new_results[0]["best"]).to eq true
      end

      it "turns the 2nd 'best' into true" do
        expect(new_results[1]["best"]).to eq true
      end

      it "turns the 3rd 'best' into false" do
        expect(new_results[2]["best"]).to eq false
      end

    end

  end

end
