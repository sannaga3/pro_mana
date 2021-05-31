### タイトル
---
#### 「 プロマネ 」

<br>

### 概要
---
体重を増やしたい、筋肉を増やしたい人向けのタンパク質摂取量の可視化アプリ。
筋肉をつける上でタンパク質摂取量の管理は重要ですが、食品毎にタンパク質含有量を覚えて記録するのには労を要します。
プロマネを使うことで、タンパク質摂取量を簡単に管理できるようになります。

### 開発言語
---

* Ruby2.6.5
* Rails5.2.5
* PostgreSQL13.2

### 機能一覧
* ユーザー管理機能
* フォロー機能
* ログイン機能
* ゲストログイン機能
* 管理者権限機能
* 食品登録機能
* 食品検索機能
* 食品記録機能
* お問合せ機能
* カレンダー機能
* Heroku

### 就業Termの技術

---
* devise
* フォロー機能

### カリキュラム外の技術
---
* ransack

### 実行手順
---

```
$ git clone https://github.com/sannaga3/pro_mana.git
$ cd pro_mana
$ bundle install
$ rails db:create && rails db:migrate
$ rails s
```
### カタログ設計
---
https://docs.google.com/spreadsheets/d/1b-93eLD9PEazR-0uknWynZlzxDp9Q4nkhaAt-NXBC9M/edit?usp=sharing

### テーブル定義所
---
https://docs.google.com/spreadsheets/d/1b-93eLD9PEazR-0uknWynZlzxDp9Q4nkhaAt-NXBC9M/edit#gid=1639636113

### ワイヤーフレーム
---
https://docs.google.com/spreadsheets/d/1b-93eLD9PEazR-0uknWynZlzxDp9Q4nkhaAt-NXBC9M/edit#gid=208904404

### ER図
---
<img src="./public/images/ER図.png" alt="ER図" width='650px'>

### 画面遷移図
---

<img src="./public/images/画面遷移図.png" alt="画面遷移図" width='650px'>