# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



# テーブル設計

## users テーブル

| Column           | Type        | Options     |
| ---------------- | ----------- | ----------- |
| nickname         | string      | null: false |
| email            | string      | null: false |
| password         | string      | null: false |
| family_name      | string      | null: false |
| first_name       | string      | null: false |
| family_name_kana | string      | null: false |
| first_name_kana  | string      | null: false |
| birth_year       | active hash | null: false |
| birth_month      | active hash | null: false |
| birth_day        | active hash | null: false |

### Association

- has_many :items
- has_many :purchases
- has_many :deliveries

## items テーブル

| Column   | Type        | Options                  |
| -------- | ----------- | ------------------------ |
| name     | string      | null: false              |
| price    | string      | null: false              |
| category | active hash | null: false              |
| status   | active hash | null: false              |
| postage  | active hash | null: false              |
| source   | active hash | null: false              |
| period   | active hash | null: false              |
| user     | reference   | null: false, foreign_key |

### Association

- belongs_to :user
- has_many   :purchases
- has_many   :deliveries

## purchases テーブル

| Column           | Type      | Options                  |
| ---------------- | --------- | ------------------------ |
| card_number      | string    | null: false              |
| expiration_month | string    | null: false              |
| expiration_year  | string    | null: false              |
| security_code    | string    | null: false              |
| user             | reference | null: false, foreign_key |
| item             | reference | null: false, foreign_key |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :delivery

## purchases テーブル

| Column       | Type        | Options                  |
| ------------ | ----------- | ------------------------ |
| post_number  | string      | null: false              |
| prefectures  | active hash | null: false              |
| municipality | string      | null: false              |
| address      | string      | null: false              |
| apartment    | string      | null: true               |
| phone_number | string      | null: false              |
| user         | reference   | null: false, foreign_key |
| item         | reference   | null: false, foreign_key |
| purchase     | reference   | null: false, foreign_key |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :purchase
