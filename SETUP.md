# 実装手順

## 事前準備

環境周りの準備は怠いので予め用意した雛形（[kkznch/laravel-project-boilerplate - GitHub](https://github.com/kkznch/laravel-project-boilerplate)）を使う。
この雛形の [README](https://github.com/kkznch/laravel-project-boilerplate/blob/master/README.md) 通りに環境の準備をしてからこれ以降の手順に従っていくと良いよ。

ちなみに、これ以降は上述した雛形の docker コンテナが起動している状態でコマンドを実行していくので注意してくれ。

## Lighthouse のセットアップ

Lighthouse 公式の手順でセットアップしていく。

[Lighthouse - Installation](https://lighthouse-php.com/master/getting-started/installation.html#install-via-composer)

### Lighthouse のインストール

まずは Lighthouse をインストールする。
```shell
$ docker-compose exec app composer require nuwave/lighthouse
```

### スキーマ定義の準備

デフォルトのスキーマ定義を作成する。
作成っていうかテンプレ的な奴を準備してくれる。
```shell
$ docker-compose exec app php artisan vendor:publish --provider="Nuwave\Lighthouse\LighthouseServiceProvider" --tag=schema
````

### IDE サポート

IDE で良い感じに開発するために、 Lighthouse 独自の構文が定義されたファイルを作成する。
公式だとこのコマンド実行すると入るよって書いてるんだけど、実行するとライブラリが足りんと怒られるのでそれを入れつつ実行する。
```shell
$ docker-compose exec app composer require --dev haydenpierce/class-finder
$ docker-compose exec app php artisan lighthouse:ide-helper
```

IDE は PhpStorm の場合は [JS GraphQL](https://plugins.jetbrains.com/plugin/8097-js-graphql) と組み合わせて使うとよさげな感じらしい。

### 便利な GraphQL Playground のインストール

開発時にブラウザから GraphQL のリクエストを投げて確認したい場合に使う。
公式サイトだと何故か composer に `--dev` オプションが付いていないので、このオプション付けてからインストールする。

```shell
$ docker-compose exec app composer require --dev mll-lab/laravel-graphql-playground
```

## Lighthouse の設定

Laravel の設定ファイル置き場（ `src/config` ）に Lighthouse の設定ファイルを設置し、環境に合わせた設定をしていく。

```shell
$ docker-compose exec app php artisan vendor:publish --provider="Nuwave\Lighthouse\LighthouseServiceProvider" --tag=config
```

### CORS の設定

GraphQL 叩く際は API 側のドメインと別のドメインから叩いてることがほとんどだと思うので、そういった場合のために CORS の設定しておく。
Laravel が 7 系の場合はデフォルトで CORS の設定が含まれているんだけど、 6 系の場合は [laravel-cors](https://github.com/fruitcake/laravel-cors) とか使う必要があるかも。
CORS の設定は `src/config/cors.php` で以下の通りにする。

```diff
- 'paths' => ['api/*'],
+ 'paths' => ['api/*', 'graphql'],
```

