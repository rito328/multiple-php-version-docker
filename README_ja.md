# multiple-php-version-docker
Docker による PHP 実行環境を複数の PHP バージョンで構築するスターター

## introduction
一つのPHP実行ファイルを複数のPHPバージョンで確認したい時に便利です。

## Getting started
### 1. 起動したい PHP のバージョンをスペース区切りで入力
```bash:order.sh
PHP_VERSIONS=(8.0 7.4 7.3 7.2 7.1 7.0 5.6)
```
- 入力するバージョンは 1 つだけでも動作します。
### 2. 起動
```bash
sh order.sh start
```
- イメージが存在しない場合はダウンロードを行うので最初は時間がかかりますが、二回目からは高速に起動します。
- バージョンの数だけコンテナが起動します。

### 3. コンソールにメッセージが表示されたらブラウザからアクセス可能になります。
```bash
+-----------------------------------+
      PHP Container is Started.
  [PHP 8.0]  http://localhost:8080
  [PHP 7.4]  http://localhost:8074
  [PHP 7.3]  http://localhost:8073
  [PHP 7.2]  http://localhost:8072
  [PHP 7.1]  http://localhost:8071
  [PHP 7.0]  http://localhost:8070
  [PHP 5.6]  http://localhost:8056
+-----------------------------------+
```
## How to use
`src/` がドキュメントルートです。 PHP ファイルを設置するだけです。

### Commands
```bash
start   : Docker コンテナを起動します
stop    : コンテナを停止します
restart : コンテナを再起動します
destroy : コンテナを停止し コンテナとイメージを削除します
conn    : コンテナへ接続します
   args : [必須] 第２引数には接続したいコンテナのPHPバージョン (数値) を入力します
          exp.) PHP7.4 => 74 / `sh order.sh conn 74`
help    : ヘルプを表示します
```
