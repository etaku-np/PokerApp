require 'rails_helper'

RSpec.describe Errors, type: :service do
  include Errors

  describe "#search_errors" do

    subject { Errors.search_errors(cards) }

    context "When no card is entered" do
      let(:cards) { nil }
      it { is_expected.to eq ["カードを入力してください。"]}
    end

    context "When only blanks are entered" do
      let(:cards) { " " }
      it { is_expected.to eq ["カードを入力してください。"]}
    end

    context "When less than 5 cards are entered" do
      let(:cards) { "S2 C4 D13 H9" }
      it { is_expected.to eq ["5つのカード指定文字を半角スペース区切りで入力してください。"]}
    end

    context "When more than 5 cards are entered" do
      let(:cards) { "C11 H5 S12 C7 D3 H3" }
      it { is_expected.to eq ["5つのカード指定文字を半角スペース区切りで入力してください。"]}
    end

    context "When the suits of all cards are incorrect" do
      let(:cards) { "c11 V5 f12 $7 ?3" }
      it { is_expected.to eq ["1番目のカード指定文字が不正です。(c11)",
                              "2番目のカード指定文字が不正です。(V5)",
                              "3番目のカード指定文字が不正です。(f12)",
                              "4番目のカード指定文字が不正です。($7)",
                              "5番目のカード指定文字が不正です。(?3)"
                             ]}
    end

  end

end