require 'rails_helper'

RSpec.describe Errors, type: :service do
  include Errors

  describe "#search_errors" do

    subject { Errors.search_errors(cards) }

    context "when no card is entered" do
      let(:cards) { nil }
      it { is_expected.to eq ["カードを入力してください。"] }
    end

    context "when only blanks are entered" do
      let(:cards) { " " }
      it { is_expected.to eq ["カードを入力してください。"] }
    end

    context "when less than 5 cards are entered" do
      let(:cards) { "S2 C4 D13 H9" }
      it { is_expected.to eq ["5つのカード指定文字を半角スペース区切りで入力してください。"] }
    end

    context "when more than 5 cards are entered" do
      let(:cards) { "C11 H5 S12 C7 D3 H3" }
      it { is_expected.to eq ["5つのカード指定文字を半角スペース区切りで入力してください。"] }
    end

    context "when the suits of all cards are incorrect" do
      let(:cards) { "c11 V5 f12 $7 あ3" }
      it { is_expected.to eq ["1番目のカード指定文字が不正です。(c11)",
                              "2番目のカード指定文字が不正です。(V5)",
                              "3番目のカード指定文字が不正です。(f12)",
                              "4番目のカード指定文字が不正です。($7)",
                              "5番目のカード指定文字が不正です。(あ3)"
                             ]
      }
    end

    context "when the suit of particular card is incorrect" do
      let(:cards) { "C1 K3 S8 D10 C8" }
      it { is_expected.to eq ["2番目のカード指定文字が不正です。(K3)"] }
    end

    context "when the numbers of all cards are incorrect" do
      let(:cards) { "S0 H14 H29 D100 C0.5" }
      it { is_expected.to eq ["1番目のカード指定文字が不正です。(S0)",
                              "2番目のカード指定文字が不正です。(H14)",
                              "3番目のカード指定文字が不正です。(H29)",
                              "4番目のカード指定文字が不正です。(D100)",
                              "5番目のカード指定文字が不正です。(C0.5)"
                             ]
      }
    end

    context "when some cards with an incorrect suit and an incorrect number are entered" do
      let(:cards) { "c1 S30 S8 L19 C0" }
      it { is_expected.to eq ["1番目のカード指定文字が不正です。(c1)",
                              "2番目のカード指定文字が不正です。(S30)",
                              "4番目のカード指定文字が不正です。(L19)",
                              "5番目のカード指定文字が不正です。(C0)"
                             ]
      }
    end

    context "when a duplicate pair of cards is entered" do
      let(:cards) { "D5 C4 D5 H4 H9" }
      it { is_expected.to eq ["カードが重複しています。"] }
    end

    context "when a duplicate pair of cards is entered" do
      let(:cards) { "C10 C7 C10 C10 S13" }
      it { is_expected.to eq ["カードが重複しています。"] }
    end

    context "when integers is entered in array" do
      let(:cards){ 100 }
      it { is_expected.to eq ["文字列を入力してください。"] }
    end

    context "when multiple errors are possible" do
      let(:cards){ "F1 C0 C10 C10 S13 P89" }
      it { is_expected.to eq ["5つのカード指定文字を半角スペース区切りで入力してください。"] }
    end

  end

end