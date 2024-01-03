class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :posts, dependent: :destroy

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 15 }
  validates :self_introduction, length: { maximum: 255 }

  attribute :place_of_birth, :string, default: '未設定'
  attribute :hobbies, :string, default: '未設定'
  attribute :self_introduction, :text, default: '未設定'
end
