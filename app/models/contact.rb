class Contact < ActiveRecord::Base

  validates :name, :address, :number, :email, presence: true 
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_format_of :number,:with => /\+?1?\-?\d{3}\-*\d{3}\-*\d{4}/
  validates_uniqueness_of :name, :scope => [:address, :number, :email]

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%").all
    else
      all
    end
  end

  def self.format_number
    write_attribute(:phonenumber, :phonenumber.gsub(/\D/, ''))
  end

end
