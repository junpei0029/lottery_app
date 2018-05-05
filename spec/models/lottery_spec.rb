require 'rails_helper'

RSpec.describe Lottery, type: :model do

  before(:each) do
    #@now = Time.parse('2016-02-10 00:00:00.000')
  end

  let(:lottery) do
    FactoryBot.build :lot_one
  end

  describe '保存・更新' do
    describe '正常系の場合' do
      example '正しく保存できること' do
        expect(lottery).to be_valid
      end
    end
    describe '正常系 当選数が1の場合' do
      example 'バリデーションOKとなること' do
        lottery.winning_number = 1
        expect(lottery).to be_valid
      end
    end
    describe '正常系 当選数が5の場合' do
      example 'バリデーションOKとなること' do
        lottery.winning_number = 5
        expect(lottery).to be_valid
      end
    end

    describe '異常系の場合' do
      describe '異常系 抽選名がnilの場合' do
        example 'バリデーションNGとなること' do
          lottery.name = nil
          expect(lottery).to be_invalid
        end
      end
      describe '異常系 当選数がnilの場合' do
        example 'バリデーションNGとなること' do
          lottery.winning_number = nil
          expect(lottery).to be_invalid
        end
      end

      describe '異常系 当選数が数値以外の場合' do
        example 'バリデーションNGとなること' do
          lottery.winning_number = "aaa"
          expect(lottery).to be_invalid
        end
      end
      describe '異常系 当選数が0以下の場合' do
        example 'バリデーションNGとなること' do
          lottery.winning_number = 0
          expect(lottery).to be_invalid
        end
      end
      describe '異常系 当選数が6以上の場合' do
        example 'バリデーションNGとなること' do
          lottery.winning_number = 6
          expect(lottery).to be_invalid
        end
      end

      describe '異常系 statusがnilの場合' do
        example 'バリデーションNGとなること' do
          lottery.status = nil
          expect(lottery).to be_invalid
        end
      end
    end
  end

  #describe '検索' do
  #  example '検索条件：初回表示' do
  #    q = Query::Common.new
  #    inquiries = lottery.search_lottery(q)
  #    expect(inquiries.size).to eq(3)
  #  end
  #end
end
