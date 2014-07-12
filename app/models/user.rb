class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin, :pro, :paid, :banned]
  after_initialize :set_default_role, :if => :new_record?
  after_create :create_profile

  
  validates_exclusion_of :name, :in => %w( facebook tedx featured users feeds photos videos items admin oembed api facebook new popular featured favicon superuser 
    pages partners categories category creators platforms media posts authors types providers tagged ), :message => "You don't belong here"

  def current_user?(user)
    current_user == user
  end

  def set_default_role
    self.role ||= :user
  end

  def create_profile
    @profile = Profile.new(:user_id => id)
    @profile.save
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  has_one :profile, dependent: :destroy
  has_many :photos
  has_many :leafs, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  has_many :user_favs
  # has_many :favourites, :through => :user_favs, :source => :leaf
  has_many :favourites, :through => :user_favs, :source => :leaf

  has_many :user_categories
  has_many :categories, :through => :user_categories

  searchable do
      text :name
      # text :comments do
      #   comments.map { |comment| comment.body }
      # end

      string  :sort_name do
        name.downcase.gsub(/^(an?|the)/, '')
      end
  end

end
