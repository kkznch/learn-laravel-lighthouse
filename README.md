# Laravel Lighthouse 使ってみる

- [本リポジトリをすぐに動かしたい人はコチラ](#動かす方法)
- [本リポジトリの実装手順はコチラ](SETUP.md)

## 動かす方法

以下の手順で docker コンテナの起動から Laravel アプリの初期化、DB のマイグレートを行う。

```shell
$ make up
$ make app-init
$ make app-db-fresh-seed
```

多分これで動いてるので、あとはフロント側から GraphQL のスキーマ定義に沿ってリクエスト投げればいけるはず。

## 停止する方法

これを叩けばオッケー。

```shell
$ make down
```
