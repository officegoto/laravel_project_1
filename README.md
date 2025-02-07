## セットアップ

```
git clone https://github.com/officegoto/laravel_project_1
docker-compose build
docker-compose up -d
docker-compose exec app bash
#設定ファイル上書き
cp .env.example .env
# 実行権限付与して実行
chmod +x setup-laravel.sh
./setup-laravel.sh
```

## setup-laravel.shでエラー
```
SQLSTATE[42S02]: Base table or view not found: 1146 Table 'genar_web.cache' doesn't exist (Connection: mysql, SQL: delete from cache)
```
キャッシュテーブルが既に作成してあるエラー内容

1度laravelをセットアップしておりデータベースの接続情報を変えずに`setup-laravel.sh`を実行するとキャッシュテーブルがあるのでエラーが出る

キャッシュテーブルは作成されているので読み飛ばしてok.