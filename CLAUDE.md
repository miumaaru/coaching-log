# セルフコーチング学習ログ — プロジェクトガイド

## プロジェクト概要

毎日届く学習メルマガ（セルフコーチング理論）をHTMLページとしてアーカイブするサイト。
認知科学・心理学に基づく理論を、教授解説・トレーナー課題・マイメモ付きで1記事ずつまとめている。

---

## フォルダ構成

```
coaching-log/
├── index.html                  # トップページ（記事一覧）
├── CLAUDE.md                   # このファイル
├── articles/
│   ├── {YYYYMMDD}-{slug}.html  # 各記事
│   └── {理論名}.png            # インフォグラフィック画像（記事と同フォルダ）
```

---

## 記事ファイルの命名規則

- 形式: `{YYYYMMDD}-{slug}.html`
- スラグは英小文字・ハイフン区切り
- 例: `20260416-narrative-therapy.html`

### 既存記事一覧（日付順）

| ファイル名 | 理論名 | 日付 |
|---|---|---|
| `20260412-grow-model.html` | GROWモデル | 2026年4月12日 |
| `20260413-woop-method.html` | WOOP（ウープ）法 | 2026年4月13日 |
| `20260414-abcde-model.html` | ABCDEモデル（論理療法） | 2026年4月14日 |
| `20260415-descartes-matrix.html` | デカルトの座標 | 2026年4月15日 |
| `20260416-narrative-therapy.html` | ナラティブ・セラピー | 2026年4月16日 |

---

## デザインシステム

### CSSカスタムプロパティ（全記事共通）

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

### フォント

- 本文: `Noto Sans JP`
- 見出し・タイトル: `Noto Serif JP`
- Google Fonts から読み込み（weight: 400/500/700）

---

## 各記事HTMLの構成（この順番を守る）

```
1. <head>          スタイルシート込み（既存記事からコピー）
2. .site-header    「学習ログ一覧に戻る」リンク（href="../index.html"）
3. .article-wrap（max-width: 720px）
   a. .article-meta     日付 + タグ（.tag / .tag.teal）
   b. .article-title    理論名（Noto Serif JP）
   c. .article-subtitle 1〜2文のサブタイトル
   d. <hr class="divider">
   e. .lead-box         リード文（border-left: orange）
   f. .section-label    「📚 教授の解説」ラベル
   g. .article-body     教授解説（h3 × 3）
      - h3「理論の本質」
      - h3「例え話」+ .drive-box
      - h3「ステップ／プロセス」+ カードグリッド
   h. .trainer-section  トレーナー課題（teal背景）
   i. .closing-box      まとめ（brown背景・中央揃え）
   j. .infographic-section  画像（.infographic-img）
   k. .memo-section     マイメモ（textarea × 3 + 保存ボタン）
   l. <nav class="article-nav">  前後ナビ
   m. 「← 一覧へ戻る」リンク（nav直後）
4. <footer class="site-footer">
5. <script>        メモのlocalStorage保存ロジック
```

---

## タグの選び方

3つ選び、最後の1つを `.tag.teal`（水色）にする。

使用可能タグ: 思考整理 / 目標設定 / 目標達成 / 行動変容 / 認知科学 / 感情コントロール / 科学的手法 / 論理療法 / コーチング基礎 / 習慣形成 / 自己理解 / ストレス管理 / 意思決定 / NLP / ナラティブ心理学

---

## カードグリッドの作り方

理論のステップは必ずカードグリッドで表現する（2列、モバイルは1列）。

```html
<div class="{理論名}-grid">
  <div class="{理論名}-card">
    <div class="{理論名}-step">① ラベル</div>
    <div class="{理論名}-card-name">ステップ名</div>
    <div class="{理論名}-card-en">英語名（斜体）</div>
    <div class="{理論名}-card-desc">説明文</div>
    <div class="{理論名}-card-effect">効果（✨ prefix）</div>
  </div>
  ...
</div>
```

CSSクラス名は理論ごとにユニークにする（例: `narrative-grid`, `descartes-grid`）。

---

## インフォグラフィック画像

- 保存場所: `articles/` フォルダ内（記事HTMLと同階層）
- 参照: `<img class="infographic-img" src="{理論名}.png" alt="...">`
- スタイル: `width: 100%; border-radius: 12px; border: 1px solid var(--border); display: block; box-shadow: 0 4px 16px rgba(0,0,0,0.07);`
- 画像がない場合はプレースホルダー div を置き、後から差し替える

---

## マイメモのlocalStorageキー

`memo-{slug}` の形式（例: `memo-narrative-therapy`）。

メモの質問は3つ。1つ目は「今日の学びで一番印象に残ったこと」（共通）、2〜3つ目はその理論に合わせてカスタマイズする。

---

## 新記事追加の手順（3ステップ）

### ステップ1: 記事HTMLを作成
`articles/{YYYYMMDD}-{slug}.html` を作成。既存記事（`20260415-descartes-matrix.html` など）をベースにする。

### ステップ2: index.html を更新
- `.article-list` 内に記事カードを日付順で追加
- `.stats-bar` の記事数（`.stat-num`）を +1 する

```html
<a class="article-card" href="articles/{ファイル名}.html">
  <div class="card-meta">
    <span class="card-date">YYYY年M月D日</span>
    <span class="tag">タグ1</span>
    <span class="tag">タグ2</span>
    <span class="tag teal">タグ3</span>
  </div>
  <div class="card-title">理論名</div>
  <div class="card-desc">1〜2文の説明文</div>
  <div class="card-arrow">続きを読む →</div>
</a>
```

### ステップ3: 隣接記事のナビを修正
- 「前の記事」になる既存記事 → `next` リンクを新記事に追加
- 「次の記事」になる既存記事 → `prev` リンクを新記事に追加

```html
<nav class="article-nav">
  <a class="nav-link prev" href="前の記事.html">前の記事：タイトル</a>
  <a class="nav-link next" href="次の記事.html">次の記事：タイトル</a>
</nav>
```

---

## よくある注意点

- `coaching-log-publisher` スキルを使うと上記3ステップを自動実行できる
- インフォグラフィック画像は `articles/` 直下に置く（ルートではない）
- 新記事の `.infographic-img` CSS を忘れると画像が原寸で表示される（各記事のCSSに定義が必要）
- ナビリンクは `href` が相対パス（`articles/` 内からは同フォルダ参照）
- `index.html` からの記事リンクは `href="articles/{ファイル名}.html"`
- 記事内の「一覧へ戻る」は `href="../index.html"`
