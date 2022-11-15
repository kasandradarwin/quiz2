class User < ApplicationRecord
    has_secure_password
    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :liked_questions, through: :likes, source: :question

end
