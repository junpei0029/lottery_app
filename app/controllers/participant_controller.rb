class ParticipantController < ApplicationController
  def new
    @lottery = Lottery.find(params[:lottery_id])
    @participant = @lottery.participants.build
  end

  def create
    @lottery = Lottery.find(params[:participant][:lottery_id])
    @participant = @lottery.participants.build(participant_params)
    @participant.result = Participant.results[:none]

    respond_to do |format|
      if @participant.save
        format.html { redirect_to({controller: :lottery, action: :show, id: @participant.lottery_id}, notice: '抽選に参加しました')}
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  private

    def participant_params
      params.require(:participant).permit(:user_name, :lottery_id)
    end

end
