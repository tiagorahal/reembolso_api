class Tag < ApplicationRecord
    validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
