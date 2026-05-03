---
name: coaching-log-publisher
description: >
  セルフコーチング学習ログサイト（C:\Users\maaru\Dev\claude\input\coaching-log）へ
  新しい記事を追加するためのスキル。MDファイルをアップロードしてファイル名の日付を指定したら、
  このスキルを使う。具体的には以下の3ステップを自動で行う：
  (1) MDファイルをサイトのデザインに合わせたHTMLファイルに変換して articles/ フォルダに保存
  (2) index.html の記事カードを日付順に追加し、記事数カウントを更新
  (3) 前後の記事のナビゲーションリンクを修正
  「mdをhtmlにして」「記事を追加して」「学習ログを更新して」などと言われたら必ずこのスキルを使う。
---

# coaching-log-publisher スキル

セルフコーチング学習ログサイトに新記事を追加する一連の作業を行う。

## 前提情報

- **サイトのルートフォルダ**: `C:\Users\maaru\Dev\claude\input\coaching-log`
- **記事フォルダ**: `articles/` （ルート直下）
- **インデックス**: `index.html` （ルート直下）
- **ファイル命名規則**: `{YYYYMMDD}-{スラグ}.html`
  - スラグ例：`woop-method`, `grow-model`, `abcde-model`
  - 日付はユーザーが指定する

## ステップ1：ファイルを読んで内容を把握する

まず以下をすべて読む：

1. **アップロードされたMDファイル** — 理論名・概要・教授解説・トレーナー課題を把握する
2. **既存の記事HTMLを1〜2本** — デザインの参考にする（articlesフォルダ内のいずれか）
3. **index.html** — カードの書き方と現在の記事一覧を把握する

MDファイルの典型的な構造：
```
- 【理論名】: XXXX
- 【概要】: ...

■ 教授の深掘り解説
  ### 1. 理論の本質
  ### 2. 直感的な例え話
  ### 3. 具体的なメカニズム（ステップカード）
  ### 教授からのメッセージ

■ トレーナーの今日の課題
  ### 1. ベビーステップ
  ### 2. ルーチン・トリガー
  ### 3. 今日のミッション
  トレーナーのアドバイス
```

## ステップ2：HTMLファイルを生成する

### デザインシステム（必ず踏襲する）

```css
:root {
  --orange: #E8722A;
  --orange-light: #FDF0E8;
  --orange-mid: #F5C4A0;
  --brown: #6B3A2A;
  --brown-light: #F9F3EF;
  --text: #2D2D2D;
  --text-muted: #7A7A7A;
  --border: #EAE0D8;
  --white: #FFFFFF;
  --teal: #3A8C8A;
  --teal-light: #EAF5F5;
}
```

フォント：`Noto Sans JP`（本文）・`Noto Serif JP`（見出し・タイトル）

### HTMLの構成（この順番で）

```
1. <head> — スタイルシート込み（既存記事からコピーして適宜調整）
2. <header class="site-header"> — 「学習ログ一覧に戻る」リンク
3. <main class="article-wrap">
   a. .article-meta — 日付タグ（.tag / .tag.teal）
   b. .article-title / .article-subtitle
   c. <hr class="divider">
   d. .lead-box — 理論の要点を1〜2文でまとめたリード文
   e. .section-label（教授アイコン付き）
   f. .article-body — 教授解説セクション
      - h3「理論の本質」
      - h3「例え話」＋ .drive-box
      - h3「ステップ」＋ ステップカードグリッド（下記参照）
   g. .trainer-section — トレーナー課題（3つのアクションアイテム）
   h. .closing-box — まとめ（印象的な一文）
   i. .infographic-section — 図解まとめ（画像プレースホルダー）
   j. .memo-section — マイメモ（3つのテキストエリア）
   k. <nav class="article-nav"> — 前後の記事ナビ
4. <footer class="site-footer">
5. <script> — メモのlocalStorage保存ロジック
```

### ステップカードグリッドの作り方

理論のステップ（GROW・WOOP・ABCDEなど）は必ずカードグリッドで表現する。

```html
<div class="{理論名}-grid">  <!-- 例：woop-grid, grow-grid -->
  <div class="{理論名}-card">
    <div class="{理論名}-letter">W</div>       <!-- 頭文字 -->
    <div class="{理論名}-card-name">Wish（願望）</div>
    <div class="{理論名}-card-title">心からの願いは？</div>
    <div class="{理論名}-card-q">問いかけ文</div>
    <div class="{理論名}-card-example">例：...</div>  <!-- 必要に応じて -->
  </div>
  <!-- 他のカードも同様 -->
</div>
```

CSSはグリッドを2列（モバイルは1列）にする。カード数が奇数なら1列にすることも検討。

### タグの選び方

MDの内容から3つ程度選ぶ（最後の1つは `.tag.teal` クラスで水色にする）：

- 思考整理 / 目標設定 / 目標達成 / 行動変容 / 認知科学 / 感情コントロール / 科学的手法 / 論理療法 / コーチング基礎 / 習慣形成 / 自己理解 / ストレス管理

### マイメモの質問文

メモセクションの3つの質問はその記事の内容に合わせてカスタマイズする。
- 1つ目：「今日の学びで一番印象に残ったこと」（汎用でOK）
- 2つ目：その理論に特有の問い（例：WOOPなら「自分のObstacleは何？」）
- 3つ目：「明日からやってみること」か理論に合った行動系の問い

### ナビゲーションリンク

前後の記事は index.html から日付順で判断する。

```html
<nav class="article-nav">
  <a class="nav-link prev" href="前の記事.html">← 前の記事：タイトル</a>
  <a class="nav-link next" href="次の記事.html">次の記事：タイトル →</a>
</nav>
```

前後どちらかしかない場合はその一方だけ表示する。

### 一覧へ戻るリンク

ナビの直後（`</nav>` の下）に必ず追加する：

```html
  <p style="text-align:center; margin-top:20px;">
    <a href="../index.html" style="text-decoration:none; color:var(--text-muted); font-size:14px; font-weight:500;">← 一覧へ戻る</a>
  </p>
```

### MEMO_KEY（localStorage用キー）

`memo-{スラグ}` の形式にする（例：`memo-woop-method`）。

## ステップ3：index.html を更新する

### 記事カードを日付順に挿入

```html
<a class="article-card" href="articles/{ファイル名}.html">
  <div class="card-meta">
    <span class="card-date">YYYY年M月D日</span>
    <span class="tag">タグ1</span>
    <span class="tag">タグ2</span>
    <span class="tag teal">タグ3</span>
  </div>
  <div class="card-title">理論名</div>
  <div class="card-desc">1〜2文の説明文（article-subtitleに近い内容）</div>
  <div class="card-arrow">続きを読む →</div>
</a>
```

### stats-bar の記事数を更新

```html
<span class="stat-num">N</span>  ← Nを現在の記事数+1に変更
```

## ステップ4：隣接記事のナビゲーションを修正する

新記事の前後に位置する既存記事の `.article-nav` を編集し、
新記事へのリンクを追加または更新する。

- 「前の記事」になる記事 → `next` リンクを新記事に変更
- 「次の記事」になる記事 → `prev` リンクを新記事に変更

## 完了確認

すべてのファイルを保存したら：
1. 作成したHTMLファイルへの `computer://` リンクを提示する
2. 更新したindex.htmlへの `computer://` リンクを提示する
3. 変更点を簡潔にまとめて伝える（どこにカードを挿入したか、ナビを何本修正したか）
