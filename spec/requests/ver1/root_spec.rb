require 'rails_helper'

RSpec.describe API::Ver1::Root, type: :request do
  include API::Ver1

  describe "POST API" do
    let(:results){ JSON.parse(response.body)["results"] }
    let(:errors){ JSON.parse(response.body)["errors"] }

    before do
      post "/api/v1/poker", params
    end

    describe "the invalid input" do
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