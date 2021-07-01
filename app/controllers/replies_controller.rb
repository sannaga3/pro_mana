class RepliesController < ApplicationController
  before_action :set_reply, only: %i[ edit update destroy ]

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(contact_params)
    @reply.replyer_id = current_user
    if @reply.save
      redirect_to contacts_path, notice: t('notice.add_contact')
    else
      render :new, notice: t('notice.failed_add_contact')
    end
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      redirect_to contacts_path, notice: t('notice.edit_contact')
    else
      render :new, notice: t('notice.failed_edit_contact')
    end
  end

  def destroy
    @reply.destroy
    redirect_to contacts_path, notice: t('notice.destroy_contact')
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end
