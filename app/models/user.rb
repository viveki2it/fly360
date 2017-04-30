require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, :uniqueness => {:message => "Eamil is already taken"}, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 5,
      'html1' => 'For 5 friends',
      'html2' => '1 month Free',
      'class' => 'two'
    },
    {
      'count' => 10,
      'html1' => 'For 10 friends',
      'html2' => '3 months Free',
      'class' => 'three'
    },
    {
      'count' => 25,
      'html1' => 'For 25 friends',
      'html2' => '3 months Free <br> + Fireside chat with Erin',
      'class' => 'four'
    },
    {
      'count' => 50,
      'html1' => 'For 50 friends',
      'html2' => '3 months Free <br> + Fireside chat with Erin <br> + Erins 4x4 book',
      'class' => 'five'
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self).deliver_now
  end
end
