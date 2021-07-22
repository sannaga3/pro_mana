class RepliesController < ApplicationController
  before_action :set_reply, only: %i[edit update destroy]
  before_action :set_contact, only: %i[new edit]

  def new
    @reply = Reply.new
  end

  def create
    @reply = current_user.replies.new(reply_params)
    @contact = Contact.find(@reply.contact.id)
    if @reply.save
      redirect_to contact_path(@reply.contact_id), notice: t('notice.add_reply')
    else
      render :new, notice: t('notice.failed_add_reply')
    end
  end

  def edit; end

  def update
    if @reply.update(reply_params)
      redirect_to contact_path(@reply.contact_id), notice: t('notice.edit_reply')
    else
      render :edit, notice: t('notice.failed_edit_reply')
    end
  end

  def destroy
    @reply.destroy
    redirect_to contact_path(@reply.contact_id), notice: t('notice.destroy_reply')
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:comment, :contact_id)
  end
end
