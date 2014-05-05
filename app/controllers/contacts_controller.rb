class ContactsController < ApplicationController
  respond_to :html, :json

  def new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact[:number] = @contact[:number].gsub(/\D/, '')
    
    if @contact.save
      redirect_to action: "index"
    else

    end
  end

  def show
    @contact = Contact.find(params[:id]) 
  end

  def index
    @contacts = Contact.search(params[:search])
  end
  

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(contact_params)
    respond_with @contact
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
   
    redirect_to contacts_path
  end


  private
    def contact_params
      params.require(:contact).permit(:name, :email, :address, :number)
    end 
end
