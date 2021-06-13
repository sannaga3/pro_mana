FactoryBot.define do
  factory :user do
    name { 'すだまさき' }
    email { 'machigaisagasi@example.com' }
    password { 'sayonaraerezi' }
    profile_image { '' }
    profile_comment { '趣味は服を買うことです。あと有村〇〇にギターを教えることです' }
    height { '172' }
    weight { '63' }
    protein_target { '95' }
    admin { 'true' }
  end

  factory :second_user, class: User do
    name { 'garnetcrow' }
    email { 'wasurezaki@example.com' }
    password { 'natunomaboroshi' }
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/camera.jpg'))}
    profile_comment { 'ボーカルの中村です、コナンの曲歌ってました。解散後ソロで活動しています' }
    height { '156' }
    weight { '49' }
    protein_target { '75' }
    admin { 'false' }
  end

  factory :third_user, class: User do
    name { 'asian kong-hu generation' }
    email { 'mirainokakera@example.com' }
    profile_image { '' }
    profile_comment { 'ボーカルのGotchです。リライト聴いたら帰る人多いんで、リライト警察が見回りしてます。' }
    height { '155' }
    weight { '58' }
    protein_target { '80' }
    password { 'standard' }
    admin { 'false' }
  end

  factory :fourth_user, class: User do
    name { 'SUPER BEAVER' }
    email { 'arigatou@example.com' }
    profile_image { '' }
    profile_comment { 'ボーカルの渋谷です。多くの方にお集まり頂きありがとうございます。みんなにじゃなくて、あなたに歌うので聴いてください' }
    height { '175' }
    weight { '65' }
    protein_target { '110' }
    password { 'himitsu' }
    admin { 'false' }
  end
end
