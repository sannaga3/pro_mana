class RepliesController < ApplicationController
  before_action :set_reply, only: %i[ edit update destroy ]

  def new
    @reply = Reply.new
    @contact = Contact.find(params[:contact_id])
  end

  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      redirect_to contacts_path, notice: t('notice.add_reply')
    else
      render :new, notice: t('notice.failed_add_reply')
    end
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      redirect_to contacts_path, notice: t('notice.edit_reply')
    else
      render :edit, notice: t('notice.failed_edit_reply')
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
    params.require(:reply).permit(:comment, :replier_id, :contact_id)
  end
end
