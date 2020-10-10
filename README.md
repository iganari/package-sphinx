# package-dojo

## 使い方

+ コンテナ起動 ---> :whale:

```
sh docker-build-run.sh
```

+ :whale: コンテナに入る

```
docker exec -it $(cat docker-build-run.sh | grep _I_TAG | awk -F\' 'NR==1 {print $2}') /bin/ash
```

## 新しいドキュメントを作成する

+ :whale: テスト時にドキュメントを作成する

```
cd test-doc
```

+ `sphinx-quickstart` を使用した初期構築

```
sphinx-quickstart
```
```
### Ex.

> Separate source and build directories (y/n) [n]: y
> Project name: test_doc
> Author name(s): iganari
> Project release []: 1.0.0
> Project language [en]: en
```

+ :whale: ドキュメントを修正する
  + 以下のディレクトリのソースコードを修正する

```
test-doc/source
```

+ :whale: ドキュメントのビルド

```
make html
```

+ ブラウザで見てみる

http://0.0.0.0:8080/test-doc/build/html/


## リソースの修正

+ コンテナの再起動など

```
docker stop $(cat docker-build-run.sh | grep _I_TAG | awk -F\' 'NR==1 {print $2}')
docker rm $(cat docker-build-run.sh | grep _I_TAG | awk -F\' 'NR==1 {print $2}')
```

+ コンテナの作り直し

```
sh docker-build-run.sh
```

## Markdown を使えるようにする

+ 公式ドキュメント
  + https://www.sphinx-doc.org/en/master/usage/markdown.html
  + https://recommonmark.readthedocs.io/en/latest/

+ pip install

```
pip3 install recommonmark
```

+ conf.py

```
### 修正前

extensions = []
```
```
### 修正後

extensions = ['recommonmark']
source_suffix = {
    '.rst': 'restructuredtext',
    '.md': 'markdown',
}


from recommonmark.parser import CommonMarkParser

source_parsers = {
    '.md': CommonMarkParser,
}
```

+ add indx.md

```

```


## 以下はドキュメント作成メモ



### テーマを変える(公式)

+ テーマのインストール
  + 使えるテーマ ---> https://sphinx-themes.org/
  + 試しに `Flask-Sphinx-Themes` を入れてみる
    + https://github.com/pallets/flask-sphinx-themes

+ pip で入れる

```
pip3 install Flask-Sphinx-Themes
```

+ 確認

```
ls -la /usr/local/lib/python3.9/site-packages/flask_sphinx_themes
```

+ テーマの変更を行なう
  + `source/conf.py`

```
### 修正前

html_theme = 'alabaster'
```
```
### 修正後

# html_theme = 'alabaster'
html_theme = 'flask'
```

+ :whale: ドキュメントのビルド

```
cd test-doc
make html
```














### テーマを変える(jupyter_sphinx_theme)

+ テーマのインストール
  + 使えるテーマ ---> https://sphinx-themes.org/
  + 試しに `jupyter_sphinx_theme` を入れてみる
    + WIP

+ pip で入れる

```
pip3 install jupyter_sphinx_theme
```

+ 確認

```
ls -la /usr/local/lib/python3.9/site-packages/jupyter_sphinx_theme
```

+ `source/conf.py` のコメントアウトを外す

```
### 修正前

# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))
```
```
### 修正後

import os
import sys
sys.path.insert(0, os.path.abspath('.'))
```

+ import の設定の追加

```
### 修正前

import os
import sys
sys.path.insert(0, os.path.abspath('.'))
```
```
### 修正後

import os
import sys
import jupyter_sphinx_theme
sys.path.insert(0, os.path.abspath('.'))
```

+ テーマの変更を行なう

```
### 修正前

html_theme = 'alabaster'
```
```
### 修正後

# html_theme = 'alabaster'
html_theme = 'jupyter_sphinx_theme'
html_theme_path = [jupyter_sphinx_theme.get_html_theme_path()]
```

+ :whale: ドキュメントのビルド

```
cd test-doc
make html
```


## 参考

+ https://planset-study-sphinx.readthedocs.io/ja/latest/06.html
+ https://qiita.com/kinpira/items/505bccacb2fba89c0ff0
+ https://qiita.com/kodai100/items/4b93f2fa735f49449db6