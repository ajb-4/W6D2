# == Schema Information
#
# Table name: restaurants
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  address    :string           not null
#  owner_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Restaurant < ApplicationRecord

    belongs_to :owner,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :User

    has_many :dishes,
    primary_key: :id,
    foreign_key: :restaurant_id,
    class_name: :Dish,
    dependent: :destroy

    has_many :reviews,
    primary_key: :id,
    foreign_key: :restaurant_id,
    class_name: :Review,
    dependent: :destroy

    has_many :customers_reviewed,
    through: :reviews,
    source: :reviewer


end