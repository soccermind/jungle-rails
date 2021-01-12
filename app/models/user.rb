class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, 
    presence: true,
    :uniqueness => { :case_sensitive => false }
  validates :password, :length => { :minimum => 6 }

  def self.authenticate_with_credentials(email, password)
    # ILIKE does a case insensitive search
    User.find_by('email ILIKE ?', email.strip)&.authenticate(password) || nil 
  end

end
