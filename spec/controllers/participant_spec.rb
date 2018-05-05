require 'rails_helper'

describe ParticipantController, type: :request do

  #Webリクエストが成功したか
  #正しいページにリダイレクトされたか
  #ユーザー認証が成功したか
  #レスポンスのテンプレートに正しいオブジェクトが保存されたか
  #ビューに表示されたメッセージは適切か

  before(:each) do
    FactoryBot.create :lot_one
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_lottery_participant_url lottery_id: 1
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post "/lottery/1/participant/", params: { participant: FactoryBot.attributes_for(:participant) }
        expect(response.status).to eq 302
      end

      it '参加者が登録されること' do
        expect do
          post "/lottery/1/participant/", params: { participant: FactoryBot.attributes_for(:participant) }
        end.to change(Participant, :count).by(1)
      end

      it 'リダイレクトすること' do
        post "/lottery/1/participant/", params: { participant: FactoryBot.attributes_for(:participant) }
        expect(response).to redirect_to Lottery.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post "/lottery/1/participant/", params: { participant: FactoryBot.attributes_for(:participant, :invalid) }
        expect(response.status).to eq 200
      end

      it '抽選が登録されないこと' do
        expect do
          post "/lottery/1/participant/", params: { participant: FactoryBot.attributes_for(:participant, :invalid) }
        end.to_not change(Participant, :count)
      end

      it 'エラーが表示されること' do
        post "/lottery/1/participant/", params: { participant: FactoryBot.attributes_for(:participant, :invalid) }
        expect(response.body).to include '参加者名を入力してください'
      end

    end
  end

end
