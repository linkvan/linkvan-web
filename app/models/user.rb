class User < ActiveRecord::Base
  has_secure_password
  has_many :facilities

  validates :name, presence: true
  validates :email, presence: true,
  					format: /\A\S+@\S+\z/,
  					uniqueness: { case_sensitive: false}

  def self.authenticate(email, password)
  	user = User.find_by(email: email)
	  user && user.authenticate(password)
  end

  def self.to_csv
    attributes = %w{id name email password_digest created_at updated_at admin activation_email_sent phone_number verified}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

end
