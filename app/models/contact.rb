class Contact < ActiveRecord::Base
  validates :name, :address, :number, :email, presence: true 
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_format_of :number,:with => /\+?1?\-?\d{3}\-*\d{3}\-*\d{4}/
  validates_uniqueness_of :name, :scope => [:address, :number, :email], 
    message: "has duplicate records"

  def self.search(search)
    if search
      where('name LIKE :s OR email LIKE :s OR address LIKE :s OR number LIKE :s', 
        :s =>"%#{search}%").all
    else
      all
    end
  end

end
