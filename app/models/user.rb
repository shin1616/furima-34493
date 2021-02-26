class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_MIX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_NAME_KANJI = /\A[ぁ-んァ-ヶ一-龥々]+\z/
  VALID_NAME_KANA = /\A[ァ-ヶ]+\z/
  validates :password,         presence: true, format: { with: VALID_PASSWORD_MIX }
  validates :nickname,         presence: true
  validates :family_name,      presence: true, format: { with: VALID_NAME_KANJI }
  validates :first_name,       presence: true, format: { with: VALID_NAME_KANJI }
  validates :family_name_kana, presence: true, format: { with: VALID_NAME_KANA }
  validates :first_name_kana,  presence: true, format: { with: VALID_NAME_KANA }
  validates :birth_day,        presence: true
end
