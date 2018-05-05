require 'rails_helper'

RSpec.describe Participant, type: :model do

  before(:each) do
    FactoryBot.create :lot_one
    FactoryBot.create :part_one
  end

  let(:participant) do
    FactoryBot.build :part_two
  end

  describe '保存・更新' do
    describe '正常系の場合' do
      example '正しく保存できること' do
        expect(participant).to be_valid
      end
    end

    describe '異常系の場合' do
      describe '異常系 lottery_idがnilの場合' do
        example 'バリデーションNGとなること' do
          participant.lottery_id = nil
          expect(participant).to be_invalid
        end
      end
      describe '異常系 user_nameがnilの場合' do
        example 'バリデーションNGとなること' do
          participant.user_name = nil
          expect(participant).to be_invalid
        end
      end
      describe '異常系 user_nameが重複の場合' do
        example 'バリデーションNGとなること' do
          participant.user_name = "StringName1"
          expect(participant).to be_invalid
        end
      end

      describe '異常系 resultがnilの場合' do
        example 'バリデーションNGとなること' do
          participant.result = nil
          expect(participant).to be_invalid
        end
      end

    end
  end

  #describe '検索' do
  #  example '検索条件：初回表示' do
  #    q = Query::Common.new
  #    inquiries = participant.search_participant(q)
  #    expect(inquiries.size).to eq(3)
  #  end
  #end
end
