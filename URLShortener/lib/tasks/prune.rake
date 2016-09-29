namespace :URLShortener do
  task purge: :environment do
    puts "Purging old audits..."
    ShortenedUrl.prune
  end
end
