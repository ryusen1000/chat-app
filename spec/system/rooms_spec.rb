require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージが全て削除されていること' do
    # サインインする
    sign_in(@room_user.user)
    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)
    # メッセージ情報を５つDBに追加する
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)
    # 「チャットを終了する」ボタンをクリックする事で、作成した５つのメッセージが削除されていることを確認する
    expect{click_on('チャットを終了する')}.to change { Message.count }.by(-5)
    #expect{find_link('チャットを終了する', href: room_path(@room_user.room)).click}.to change { @room_user.room.messages.count }.by(-5)でも大丈夫
    # トップページへ遷移していることを確認する
    expect(current_path).to eq (root_path)
  end

end
