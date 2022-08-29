require 'rails_helper'

RSpec.describe Hands, type: :service do
  include Hands

  describe "#search_hands" do
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


end