require 'rails_helper'

describe LotteryController, type: :request do

  #Webリクエストが成功したか
  #正しいページにリダイレクトされたか
  #ユーザー認証が成功したか
  #レスポンスのテンプレートに正しいオブジェクトが保存されたか
  #ビューに表示されたメッセージは適切か

  describe 'GET #index' do
    before do
      FactoryBot.create :lot_one
      FactoryBot.create :lot_two
    end

    it 'リクエストが成功すること' do
      get "/"
      expect(response.status).to eq 200
    end

    it '抽選名が表示されていること' do
      get "/"
      expect(response.body).to include "MyString1"
      expect(response.body).to include "MyString2"
    end

  end

  describe 'GET #show' do
    context 'ユーザーが存在する場合' do
      let(:lot_one) { FactoryBot.create :lot_one }
      let(:show_url) { "/lottery/#{lot_one.id}" }

      it 'リクエストが成功すること' do
        get show_url
        expect(response.status).to eq 200
      end

      it '抽選名が表示されていること' do
        get show_url
        expect(response.body).to include 'MyString1'
      end
    end

    context '抽選IDが存在しない場合' do
      subject { -> { get "/lottery/2" } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_lottery_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post "/lottery", params: { lottery: FactoryBot.attributes_for(:lottery) }
        expect(response.status).to eq 302
      end

      it '抽選が登録されること' do
        expect do
          post "/lottery", params: { lottery: FactoryBot.attributes_for(:lottery) }
        end.to change(Lottery, :count).by(1)
      end

      it 'リダイレクトすること' do
        post "/lottery", params: { lottery: FactoryBot.attributes_for(:lottery) }
        expect(response).to redirect_to Lottery.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post "/lottery", params: { lottery: FactoryBot.attributes_for(:lottery, :invalid) }
        expect(response.status).to eq 200
      end

      it '抽選が登録されないこと' do
        expect do
          post "/lottery", params: { lottery: FactoryBot.attributes_for(:lottery, :invalid) }
        end.to_not change(Lottery, :count)
      end

      it 'エラーが表示されること' do
        post "/lottery", params: { lottery: FactoryBot.attributes_for(:lottery, :invalid) }
        expect(response.body).to include '抽選名を入力してください'
      end
    end
  end

end
