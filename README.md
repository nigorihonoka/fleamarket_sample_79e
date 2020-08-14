## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthdate|date|null: false|

### Association
- has_many :seller_items, class_name: 'item', foreign_key: 'seller_id'
- has_many :buyer_items, class_name: 'item', foreign_key: 'buyer_id'
- has_one :credit_card, dependent: :destroy
- has_one :delivery_address, dependent: :destroy

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|payjp_id|string|null: false, unique: true|
|customer_id|string|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## delivery_addressesテーブル
|Column|Type|Options|
|------|----|-------|
|delivery_family_name|string|null: false|
|delivery_first_name|string|null: false|
|delivery_family_name_kana|string|null: false|
|delivery_first_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|home_number|string|null: false|
|building_name|string||
|phone_number|string|unique: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|explanation|text|null: false|
|category|references|null: false, foreign_key: true|
|brand|string||
|condition_id|integer|null: false|
|postage_id|integer|null: false|
|prefecture_id|integer|null: false|
|prepare_id|integer|null: false|
|price|integer|null: false|
|seller|references|null: false, foreign_key: true|
|buyer|references|foreign_key: true|

### Association
- has_many :item_images, dependent: :destroy
- belongs_to_active_hash :prefecture
- belongs_to :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :postage
- belongs_to_active_hash :prepare
- belongs_to :seller, class_name: 'user', foreign_key: 'seller_id'
- belongs_to :buyer, class_name: 'user', foreign_key: 'buyer_id'

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## categoriesテーブル(gem ancestryを使用)
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

### Association

- has_many :items
フォーク　test