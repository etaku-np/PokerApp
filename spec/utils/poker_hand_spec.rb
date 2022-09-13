require 'rails_helper'

RSpec.describe PokerHand, type: :module do
  include PokerHand

  describe "#judge_cards" do
    let(:judge_cards){ PokerHand.judge_cards(cards) }

    context "when the hand is Straight Flush" do
      let(:cards) { "H13 H1 H11 H12 H10" }
      it "returns \"ストレートフラッシュ\"" do
        expect(judge_cards[:name]).to eq "ストレートフラッシュ"
      end
      it "returns 8" do
        expect(judge_cards[:score]).to eq 8
      end
    end

    context "when the hand is Four of a kind" do
      let(:cards) { "S13 H13 D13 C8 C13" }
      it "returns \"フォーカード\"" do
        expect(judge_cards[:name]).to eq "フォーカード"
      end
      it "returns 7" do
        expect(judge_cards[:score]).to eq 7
      end
    end

    context "when the hand is Full House" do
      let(:cards) { "D8 S2 C8 H8 C2" }
      it "returns \"フルハウス\"" do
        expect(judge_cards[:name]).to eq "フルハウス"
      end
      it "returns 6" do
        expect(judge_cards[:score]).to eq 6
      end
    end

    context "when the hand is Flush" do
      let(:cards) { "S1 S4 S11 S2 S3" }
      it "returns \"フラッシュ\"" do
        expect(judge_cards[:name]).to eq "フラッシュ"
      end
      it "returns 5" do
        expect(judge_cards[:score]).to eq 5
      end
    end

    context "when the hand is Straight" do
      let(:cards) { "S2 H3 D1 H4 C5" }
      it "returns \"ストレート\"" do
        expect(judge_cards[:name]).to eq "ストレート"
      end
      it "returns 4" do
        expect(judge_cards[:score]).to eq 4
      end
    end

    context "when the hand is Three of a kind" do
      let(:cards) { "H7 S9 D9 C3 H9" }
      it "returns \"スリーカード\"" do
        expect(judge_cards[:name]).to eq "スリーカード"
      end
      it "returns 3" do
        expect(judge_cards[:score]).to eq 3
      end
    end

    context "when the hand is Two pair" do
      let(:cards) { "C4 H7 H11 C7 D4" }
      it "returns \"ツーペア\"" do
        expect(judge_cards[:name]).to eq "ツーペア"
      end
      it "returns 2" do
        expect(judge_cards[:score]).to eq 2
      end
    end

    context "when the hand is Pair" do
      let(:cards) { "H10 H5 D13 S6 S10" }
      it "returns \"ワンペア\"" do
        expect(judge_cards[:name]).to eq "ワンペア"
      end
      it "returns 1" do
        expect(judge_cards[:score]).to eq 1
      end
    end

    context "when the hand is High card" do
      let(:cards) { "D4 H8 S1 C10 D9" }
      it "returns \"ハイカード\"" do
        expect(judge_cards[:name]).to eq "ハイカード"
      end
      it "returns 0" do
        expect(judge_cards[:score]).to eq 0
      end
    end
  end
end