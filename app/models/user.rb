class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin, :pro, :paid, :banned]
  after_initialize :set_default_role, :if => :new_record?
  after_create :create_profile

  
  validates_exclusion_of :name, :in => %w( featured users feeds photos videos items admin oembed api facebook new popular featured favicon superuser 
    pages partners categories category creators platforms media posts authors types providers tagged ), :message => "You don't belong here"


  def set_default_role
    self.role ||= :user
  end

  def create_profile
    @profile = Profile.new(:user_id => id)
    @profile.save
  end

  has_one :profile, dependent: :destroy
  has_many :photos
  has_many :leafs, dependent: :destroy

  has_many :user_favs
  # has_many :favourites, :through => :user_favs, :source => :leaf
  has_many :favourites, :through => :user_favs, :source => :leaf

  has_many :user_categories
  has_many :categories, :through => :user_categories

end
