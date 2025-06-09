require 'payjp'

# 本番・開発で SECRET_KEY の環境変数を切り替えて使う
Payjp.api_key = ENV['PAYJP_SECRET_KEY']