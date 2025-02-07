#!/bin/bash

# Laravel プロジェクトディレクトリに移動
cd /var/www/html

# ファイルとディレクトリの所有権を www-data ユーザーに変更
echo "Setting permissions for storage and cache directories..."
chown -R www-data:www-data storage bootstrap/cache

# 権限を設定
chmod -R 775 storage bootstrap/cache

# Laravel のキャッシュをクリア
echo "Clearing Laravel caches..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear

# cache テーブルを作成するためのマイグレーションファイルを生成
echo "Generating cache table migration..."
php artisan cache:table

# 必要なマイグレーションを実行
echo "Running migrations..."
php artisan migrate

# APP_KEY を生成
php artisan key:generate

# パーミッションを再確認
echo "Verifying permissions for storage and cache directories..."
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

echo "Laravel setup is complete."
