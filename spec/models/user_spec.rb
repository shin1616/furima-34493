require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録できるとき' do
      it 'nicknameとemailtとpasswordとpassword_confirmationとfamily_nameとfirst_nameとfamily_name_kanaとfirst_name_kanaとbirth_dayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上かつ、英数字混合であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@を含まず登録できない' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上ではないと登録できない（5文字以下だと登録できない）' do
        @user.password = 'abc12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英数字混合でないと登録できない（英字だけだと登録できない）' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは、半角英数字混合でないと登録できない（数字だけだと登録できない）' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード（確認用）は、値が相違していると登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe '新規登録/本人情報確認' do
    context '新規登録できるとき' do
      it 'ユーザー本名は、名字と名前がそれぞれ全角（漢字・ひらがな・カタカナ）での入力であると登録できる' do
        @user.family_name = '田中'
        @user.first_name = 'たかし'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、名字と名前がそれぞれ全角（カタカナ）での入力であると登録できる' do
        @user.family_name_kana = 'タナカ'
        @user.first_name_kana = 'タカシ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ユーザー本名は、名字が空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", 'Family name is invalid')
      end
      it 'ユーザー本名は、名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it 'ユーザー本名は、名字が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.family_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end
      it 'ユーザー本名は、名前が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'ユーザー本名のフリガナは、名字が空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", 'Family name kana is invalid')
      end
      it 'ユーザー本名のフリガナは、名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
      end
      it 'ユーザー本名のフリガナは、名字が全角（カタカナ）でないと登録できない' do
        @user.family_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana is invalid')
      end
      it 'ユーザー本名のフリガナは、名前が全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '生年月日が空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
