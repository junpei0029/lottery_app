class LotteryController < ApplicationController
  before_action :set_lottery, only: [:show]
  before_action :set_my_lottery, only: [:exec, :destroy]

  def index
    @lotteries = Lottery.my_lotteries(session_id)
  end

  def new
    @lottery = Lottery.new
  end

  def create
    @lottery = Lottery.new(lottery_params)
    @lottery.status = Lottery.statuses[:wanted]
    @lottery.user_session = request.session_options[:id]

    respond_to do |format|
      if @lottery.save
        format.html { redirect_to({action: :show, id: @lottery.id}, notice: '抽選を登録しました')}
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  def exec
    # error処理
    if @lottery.status_before_type_cast == Lottery.statuses[:finished] or @lottery.participants.count < @lottery.winning_number
      redirect_to({action: :show, id: @lottery.id}, notice: '抽選が失敗しました。参加者人数が足りません。当選者数より多く参加者を集めてください。')
      return
    end

    # 抽選対象者取得
    participants = @lottery.participants.sort_by{rand}.take(@lottery.winning_number)
    Array(participants).each do |participant|
      participant.assign_attributes(result: Participant.results[:winning])
    end
    @lottery.status = Lottery.statuses[:finished]

    respond_to do |format|
      if @lottery.save
        format.html { redirect_to({action: :show, id: @lottery.id}, notice: '抽選を実行しました')}
      else
        format.html { redirect_to({action: :show, id: @lottery.id}, notice: '抽選が失敗しました')}
      end
    end
  end

  def destroy
    @lottery.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: '抽選を削除しました' }
    end
  end

  private
    def set_my_lottery
      @lottery = Lottery.my_lotteries(session_id).find(params[:id])
    end

    def set_lottery
      @lottery = Lottery.find(params[:id])
    end

    def lottery_params
      params.require(:lottery).permit(:name, :winning_number, :detail)
    end

end
