# whenever設定コマンド
# bundle exec whenever 構文確認
# bundle exec whenever --update-crontab 設定反映
# bundle exec whenever --clear-crontab 設定削除
# crontab -l 設定反映確認

# OSの時刻はJSTに変更したが、cronはutcのままだった。
# /etc/localtimeを変更すればよいと思うが今回は見送る。

require File.expand_path("#{File.dirname(__FILE__)}/environment")
rails_env = Rails.env.to_sym
set :environment, rails_env
ENV.each { |k, v| env(k, v) }
set :output, 'log/cron.log'

every 1.day, at: Time.parse('7pm').utc do
  rake 'remind_mail:reminder'
end

# 予約ランキングスケジュール
every 1.day, at: Time.parse('0am').utc do
  rake 'rank:aggregation'
end
