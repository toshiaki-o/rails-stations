namespace :rank do
  desc '予約ランキング集計'
  task aggregation: :environment do
    Rank.movie
  end
end
