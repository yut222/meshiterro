class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   # ユーザーごとのプロフ画像を(保存)扱うため追記
  has_one_attached :profile_image  #profile_image という名前でActiveStorageでプロフ画像を保存できる設定

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def get_profile_image(width, height)  #Userモデルの中に記述することで、カラムを呼び出すようにこの処理（メソッド）を呼び出すことができる.
    unless profile_image.attached?  # .attached? imageが存在するかを確認するメソッド
    file_path = Rails.root.join('app/assets/images/sample-author1.jpg')  #profile_imageがなければsample-author1.jpgが表示される
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed  #画像サイズの変更(メソッドに対して引数に設定した値に画像のサイズを変換する),
  end

end
