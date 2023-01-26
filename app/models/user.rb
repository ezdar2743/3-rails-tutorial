class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { email.downcase! }
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 30 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }, allow_nil: true
  # 渡された文字列のハッシュ値を返す
  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost:)
    end

    # random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  def session_token
    remember_digest || remember
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # discard user's login info
  def forget
    update_attribute(:remember_digest, nil)
  end
end
