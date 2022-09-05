class User < ApplicationRecord
	has_secure_password
	
	validates_presence_of :first_name, :last_name
	validates_uniqueness_of :email
	validates :password, :length => { :in => 6..16 }, if: -> { password_digest_changed? }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	
	def send_password_reset
		self.password_reset_token = generate_token
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.forgot_password(self).deliver
		self.password_reset_token
	end

	def generate_token
		 SecureRandom.urlsafe_base64
	end
	
end
