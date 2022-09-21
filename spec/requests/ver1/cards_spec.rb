require 'rails_helper'

RSpec.describe API::Ver1::Cards, type: :request do
  describe "POST API" do
    include API::Ver1

    let(:results){ JSON.parse(response.body)[:results] }
    let(:errors){ JSON.parse(response.body)[:errors] }

    before do
      post "/api/v1/poker", params
    end

    describe "the valid input" do
      shared_examples "returns Status: 200" do
        it "returns Status: 200" do
          expect(response.status).to eq 200
        end
      end

      context "when only valid cards are entered" do
        let(:params){
          {
            "cards": [
              "S10 S11 S9 S7 S8",
              "C2 C3 C4 C5 C6",
              "D3 S3 H12 H3 C12"
            ]
          }
        }
        it_behaves_like "returns Status: 200"
      end

      context "when only invalid cards are entered" do
        let(:params){
          {
            "cards": [
              " ",
              "c2 C30 f4 V5 v0",
              "D3 D3 H12 H3 C12"
            ]
          }
        }
        it_behaves_like "returns Status: 200"
      end

      context "when mixed cards are entered" do
        let(:params){
          {
            "cards": [
              "D10 S10 C9 S8 H8",
              "C2 H6 D6 S6 C6",
              "c2 C30 f4 V5 v0",
              "D3 D3 H12 H3 C12"
            ]
          }
        }
        it_behaves_like "returns Status: 200"
      end
    end

    describe "the invalid input" do
      let(:error_msg) { JSON.parse(response.body)["errors"][0]["msg"] }
      shared_examples "returns Status: 400" do
        it "returns Status: 400" do
          expect(response.status).to eq 400
        end
      end

      context "when a duplicate pair of cards is entered" do
        let(:params){
          {
            "cards": [
              "C2 C3 C4 C5 C6",
              "C2 C3 C4 C5 C6"
            ]
          }
        }
        it_behaves_like "returns Status: 400"
        it "returns error message" do
          expect(error_msg).to eq "入力内容が重複しています。"
        end
      end

      context "when nothing is entered in array" do
        let(:params){
          {
            "cards": []
          }
        }
        it_behaves_like "returns Status: 400"
        it "returns error message" do
          expect(error_msg).to eq "入力形式を確認してください。"
        end
      end
    end
  end
end