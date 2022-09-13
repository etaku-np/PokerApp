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
  end
end
