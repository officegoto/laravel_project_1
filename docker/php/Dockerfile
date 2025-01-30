FROM php:8.2-fpm

# 必要な依存パッケージのインストール
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    zip \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql

# Node.js の公式セットアップスクリプトを使ったインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# nvm のインストール
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    echo "export NVM_DIR=\"$HOME/.nvm\"" >> /root/.bashrc && \
    echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\"" >> /root/.bashrc && \
    echo "[ -s \"$NVM_DIR/bash_completion\" ] && \\. \"$NVM_DIR/bash_completion\"" >> /root/.bashrc

# Composer のインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# php.ini のコピー
COPY ./php.ini /usr/local/etc/php/php.ini

# 作業ディレクトリの設定
WORKDIR /var/www/html

# 環境変数設定（nvm の初期化を有効にするため）
ENV NVM_DIR=/root/.nvm

# Node.js バージョンの設定
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 18 && nvm use 18"