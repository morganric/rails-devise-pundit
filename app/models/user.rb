class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable , :omniauth_providers => [:facebook, :twitter]
  enum role: [:user, :vip, :admin, :pro, :paid, :banned]
  after_initialize :set_default_role, :if => :new_record?
  after_create :create_profile

  
  validates_exclusion_of :name, :in => %w( inboxes message discussions facebook tedx featured users feeds photos videos items admin oembed api facebook new popular featured favicon superuser 
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

  acts_as_messageable

  def mailboxer_email(object)
  #Check if an email should be sent for that object
  #if true
  return self.email.to_s
  #if false
  #return nil

  end

  def self.find_for_twitter_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.profile.image = auth.info.image # assuming the user model has an image
    end
  end

  def email_required?
    super && provider.blank?
  end

  def self.find_for_facebook_oauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        # user.profile.image = auth.info.image # assuming the user model has an image
      end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
