# Treasure-Hunter

## Description
これはモンスターに捕まらないように宝を集めるゲームです。制限時間があり、移動するごとにタイマーが1減ります。  
  
@：ハンター。方向キーで動かせます。  
M：モンスター。ハンターを追いかけるように動きます。  
\*：宝。ステージ数と同じ数を集めるとステージクリアになります。  
+：薬。拾うと制限時間を延ばすことができます。

## Requirement
* Ruby
* curses  

インストール方法   
``` 
$ sudo apt install ruby
$ sudo apt ncurses-dev
$ sudo gem install curses
```

## Download
`git clone https://github.com/talos-ta/Treasure-Hunter [ダウンロード先のディレクトリ]`

## Usage
`ruby main.rb`

## Anyting Else
ウィンドウサイズが大きいほど、文字サイズが小さいほど難しくなります。

## Author
[twitter](https://twitter.com/talosta_/)  
[はてなブログ](https://talosta.hatenablog.com/)
