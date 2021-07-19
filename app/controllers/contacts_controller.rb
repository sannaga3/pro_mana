class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update destroy]

  def index
    @contacts = if current_user.admin == true
                  Contact.all.order_id
                else
                  Contact.pick_current_user_id(current_user.id).order_id
                end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contacts_path, notice: t('notice.add_contact')
    else
      render :new, notice: t('notice.failed_add_contact')
    end
  end

  def show
    @replies = Reply.pick_contact_id(params[:id])
  end

  def edit; end

  def update
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: t('notice.edit_contact')
    else
      render :new, notice: t('notice.failed_edit_contact')
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: t('notice.destroy_contact')
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:title, :content, :user_id)
  end
end
