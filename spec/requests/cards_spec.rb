require 'rails_helper'

RSpec.describe API::Ver1::Cards, type: :request do
  describe "POST API" do
    include API::Ver1

    # 結果のハッシュが入った配列を定義
    let(:results){ JSON.parse(response.body)["results"] }
    # エラーのハッシュが入った配列を定義
    let(:errors){ JSON.parse(response.body)["errors"] }

    before do
      post "/api/v1/poker", params
    end

    describe "the correct input" do
      shared_examples "returns Status: 200" do
        it "returns Status: 200" do
          expect(response.status).to eq 200
        end
      end

      context "when only correct cards are entered" do
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

      context "when only incorrect cards are entered" do
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
        it "returns results and errors" do
          expect(results.length + errors.length).to eq 4
        end
      end
    end

    describe "the incorrect input" do
      let(:error_msg) { JSON.parse(response.body)["errors"][0]["msg"] }
      shared_examples "returns Status: 400 and error massage" do
        it "returns Status: 400" do
          expect(response.status).to eq 400
        end
        it "returns error message" do
          expect(error_msg).to eq "入力形式を確認してください。"
        end
      end

      context "when nothing is entered in body" do
        let(:params){  }
        it_behaves_like "returns Status: 400 and error massage"
      end

      context "when nothing is entered in hash" do
        let(:params){ {  } }
        it_behaves_like "returns Status: 400 and error massage"
      end

      context "when nothing is entered in array" do
        let(:params){ { "cards": [] } }
        it_behaves_like "returns Status: 400 and error massage"
      end

      context "when the key is incorrect" do
        let(:params){ { "card": [] } }
        it_behaves_like "returns Status: 400 and error massage"
      end
    end
  end

  describe "GET API" do
    before do
      get "/api/v1/poker"
    end

    it "returns Status: 400" do
      expect(response.status).to eq 400
    end
    it "returns error message" do
      expect(JSON.parse(response.body)["errors"][0]["msg"]).to eq "入力形式を確認してください。"
    end
  end
end