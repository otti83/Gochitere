### ☕️Gochitere
 
mac環境におけるmirakurunのクライアントをソフトを目指し作成しました。  
最近windowsから乗り換えたのでTVTestの代わりが欲しくて…。  
まだまだ機能面は足りず映像の再生とスクショくらいです。  
<img src="https://github.com/otti83/Gochitere/blob/main/ss1.png" height="200">  

### 使い方
1) [リリース](https://github.com/otti83/Gochitere/releases) からダウンロードし起動してください。
2) mirakurunのURLを設定するアラートが起動するので入力してください。  
（初期値は私の家のローカルIPなので適宜書き換えください）
3) mirakurunのURL設定およびチャンネルjsonの取得に成功すると番組選択が可能になるので選択し視聴ください。  
※設定をミスった際はメインメニューの[settings]から初期化ください。

### ビルド方法
1) VLCkitが必要なのでCartfile等から導入ください。
M1 macからだと現状ではビルド不可のようなのでintel macが必要です。
xcode12だとなんかCartfileが上手くいかないときあるようなので、ググったshスクリプト使いました。
