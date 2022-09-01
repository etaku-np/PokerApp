require 'rails_helper'

RSpec.describe Hands, type: :service do
  include Hands

  describe "#search_hands" do
    describe "hand's name" do
      subject { Hands.search_hands(cards)[:name] }

      context "when the hand is Straight Flush" do
        let(:cards) { "C5 C6 C4 C3 C7" }
        it { is_expected.to eq "ストレートフラッシュ" }
      end

      context "when the hand is Straight" do
        let(:cards) { "C12 H13 D10 H1 H11" }
        it { is_expected.to eq "ストレート" }
      end

      context "when the hand is Flush" do
        let(:cards) { "D7 D4 D10 D2 D3" }
        it { is_expected.to eq "フラッシュ" }
      end

      context "when the hand is Four of a kind" do
        let(:cards) { "S8 H8 D8 C8 C12" }
        it { is_expected.to eq "フォーカード" }
      end

      context "when the hand is Full House" do
        let(:cards) { "D5 S10 D10 H5 C5" }
        it { is_expected.to eq "フルハウス" }
      end

      context "when the hand is Three of a kind" do
        let(:cards) { "C7 S7 S11 C3 H7" }
        it { is_expected.to eq "スリーカード" }
      end

      context "when the hand is Two pair" do
        let(:cards) { "H9 H4 S9 C5 D4" }
        it { is_expected.to eq "ツーペア" }
      end

      context "when the hand is Pair" do
        let(:cards) { "H12 H5 D12 S6 S10" }
        it { is_expected.to eq "ワンペア" }
      end

      context "when the hand is High card" do
        let(:cards) { "D4 H8 S1 C10 D9" }
        it { is_expected.to eq "ハイカード" }
      end
    end

    describe "hand's score" do
      subject { Hands.search_hands(cards)[:score] }

      context "when the hand is Straight Flush" do
        let(:cards) { "H13 H1 H11 H12 H10" }
        it { is_expected.to eq 8 }
      end

      context "when the hand is Four of a kind" do
        let(:cards) { "S13 H13 D13 C8 C13" }
        it { is_expected.to eq 7 }
      end

      context "when the hand is Full House" do
        let(:cards) { "D8 S2 C8 H8 C2" }
        it { is_expected.to eq 6 }
      end

      context "when the hand is Flush" do
        let(:cards) { "S1 S4 S11 S2 S3" }
        it { is_expected.to eq 5 }
      end

      context "when the hand is Straight" do
        let(:cards) { "S2 H3 D1 H4 C5" }
        it { is_expected.to eq 4 }
      end

      context "when the hand is Three of a kind" do
        let(:cards) { "H7 S9 D9 C3 H9" }
        it { is_expected.to eq 3 }
      end

      context "when the hand is Two pair" do
        let(:cards) { "C4 H7 H11 C7 D4" }
        it { is_expected.to eq 2 }
      end

      context "when the hand is Pair" do
        let(:cards) { "H10 H5 D13 S6 S10" }
        it { is_expected.to eq 1 }
      end

      context "when the hand is High card" do
        let(:cards) { "D4 H8 S1 C10 D9" }
        it { is_expected.to eq 0 }
      end
    end
  end
end