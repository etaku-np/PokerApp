require 'rails_helper'

RSpec.describe PokerService, type: :service do
  include PokerService

  describe "#webapp" do
    let(:error){ PokerValidation.validate_cards(cards) }
    let(:result){ PokerHand.judge_cards(cards)[:name] }

    context "when the input is invalid" do
      let(:cards){ "H6 C8 C1 D10" }
      it "returns an error" do
        expect(error||result).to eq error
      end
    end

    context "when the input is valid" do
      let(:cards){ "H6 C8 C1 D10 S1" }
      it "returns a result" do
        expect(error||result).to eq result
      end
    end
  end

  describe "#api" do
    let(:results){ PokerService.api(cards_set)["results"] }
    let(:errors){ PokerService.api(cards_set)["errors"] }

    context "when only valid cards are entered" do
      let(:cards_set){
        [
          "S10 S11 S9 S7 S8",
          "C2 C3 C4 C5 C6",
          "D3 S3 H12 H3 C12"
        ]
      }
      it "returns 3 results" do
        expect(results.length).to eq 3
      end
      it "returns correct results" do
        expect(results[2]["hand"]).to eq "フルハウス"
      end
      it "dose not display array of errors" do
        expect(errors).to eq nil
      end
    end

    context "when only invalid cards are entered" do
      let(:cards_set){
        [
          " ",
          "c2 C30 f4 V5 v0",
          "D3 D3 H12 H3 C12"
        ]
      }
      it "returns 3 errors" do
        expect(errors.length).to eq 3
      end
      it "returns correct errors" do
        expect(errors[0]["msg"]).to eq ["カードを入力してください。"]
      end
      it "returns correct errors" do
        expect(errors[2]["msg"]).to eq ["カードが重複しています。"]
      end
      it "dose not display array of results" do
        expect(results).to eq nil
      end
    end

    context "when mixed cards are entered" do
      let(:cards_set){
        [
          "D10 S10 C9 S8 H8",
          "C2 H6 D6 S6 C6",
          "c2 C30 f4 V5 v0",
          "D3 D3 H12 H3 C12"
        ]
      }
      it "returns results and errors" do
        expect(results.length + errors.length).to eq 4
      end
    end
  end
end