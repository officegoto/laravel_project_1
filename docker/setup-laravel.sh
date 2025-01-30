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

# 必要なマイグレーションを実行
echo "Running migrations..."
php artisan migrate

# セッションテーブルが必要な場合に作成
if [ ! -f "database/migrations/2022_XX_XX_XXXXXX_create_sessions_table.php" ]; then
    echo "Creating session table migration..."
    php artisan session:table
    php artisan migrate
else
    echo "Session table migration already exists."
fi

# パーミッションを再確認
echo "Verifying permissions for storage and cache directories..."
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

# APP_KEY
php artisan key:generate

echo "Laravel setup is complete."
