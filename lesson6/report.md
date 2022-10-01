# 課題 X 自分 (達) の「美しい」と思う絵を生成するプログラムを作成しなさい。
* 学籍番号: 2291029
* 氏名: 中村凜
* 提出日付: 2022/08/26

# 構想・計画・設計
## 構想
美しいものとは何か、と考え、星空は美しいのではと考えた。
しかしただの星空では点を敷き詰めるだけとなってしまう。
また、星空を美しく表現しようとすると背景のグラデーションなどかなり大変になるはずだ。
そこで、星の動きのタイムラプス画像を作成しようと考えた。

## 計画
一定の時間において移動した星の軌跡を描くのだが、今回は円型にしたいと考え、北半球において北を向いた時のタイムラプス画像とした。
また、ただただ背景が黒いだけでは味気ないのでグラデーションを使い、夜明けを表現してみた。
さらに、下部に円の弧を描くことにより、地球から見ていることを表現した。

## 設計
まず背景のグラデーションの設計をした。
仕様としては、塗りつぶしの色を二色、そして矩形のXY座標左上と右下それぞれ二つ定める。そこで、上から順に色の変化の割合を求めてゆき、RGB値をそれぞれ二色目の値に近づけていくというものだ。
非常に単純で、ただただpsetで特定の色を配置していくのみだった。

次にメインの星の軌跡の設計をした。
仕様としては、まず360度を何分割にして表示するかを決める、つまり一つの円にいくつ弧を描くかを決める。それは全て乱数に定めており、一つの円周に0～5個の弧を描くようになっている。そこで一つの弧が描くことが可能な領域が決定し、その中に納まるように弧の開始地点を定める。また、中心角は全て一定にしている(30度)。中心角を一定に設定しているため、開始地点となる範囲は、領域の始めの部分～(終わりの部分 - 30度)となっている。そのなかで乱数を使って開始地点を定めている。そこから終わりの地点までsinとcosを使い点を定めてpsetで描画している。
また、複数の円の層になっているが、それらの間隔は5pxとなっておりこれらは半径に5を足すことにより実装した。
これらを繰り返し処理により実装した。

#  プログラムコード
```Ruby
PICTURE_SIZE_X = 1920
PICTURE_SIZE_Y = 1080
ARC_CENTRAL_ANGLE = 30

Pixel = Struct.new(:r, :g, :b)

$img = Array.new(PICTURE_SIZE_Y) do
	Array.new(PICTURE_SIZE_X) do Pixel.new(0, 0, 0) end
end
def pset(x, y, r, g, b)
	if 0 <= x && x < PICTURE_SIZE_X && 0 <= y && y < PICTURE_SIZE_Y
		$img[y][x].r = r; $img[y][x].g = g; $img[y][x].b = b
	end
end
#gradf 縦向きのグラデーションの矩形の描画
#@param
#	x1, y1: 左上座標
#	x2, y2:	右下座標
#	colorCode1, colorCode2: それぞれの塗りつぶしの色(16進カラーコード)
def gradf(x1, y1, x2, y2, colorCode1, colorCode2)
    firstColorB = colorCode1 % 0x100.to_i
    firstColorG = ((colorCode1 - firstColorB) / 0x100.to_i) % 0x100.to_i
    firstColorR = (colorCode1 - firstColorG * 0x100.to_i - firstColorB) / 0x10000.to_i
    endColorB = colorCode2 % 0x100.to_i
    endColorG = ((colorCode2 - endColorB) / 0x100.to_i) % 0x100.to_i
    endColorR = (colorCode2 - endColorG * 0x100.to_i - endColorB) / 0x10000.to_i
    curColorR = 0; curColorG = 0; curColorB = 0

	boxWidth = x2 - x1
    boxHeight = y2 - y1
    boxHeight.times do |i|
        curColorR = (firstColorR * i + endColorR * (boxHeight - i)) / boxHeight
        curColorG = (firstColorG * i + endColorG * (boxHeight - i)) / boxHeight
        curColorB = (firstColorB * i + endColorB * (boxHeight - i)) / boxHeight
        boxWidth.times do |j|
            pset(j + x1, i + y1, curColorR, curColorG, curColorB)
        end
    end
end
def fillCircle(x0, y0, rad, r, g, b)
	PICTURE_SIZE_Y.times do |y|
		PICTURE_SIZE_X.times do |x|
			if (x-x0)**2 + (y-y0)**2 <= rad**2
				pset(x, y, r, g, b)
			end
		end
	end
end
def drawStars()
	centerX = 960
	centerY = 540
	for i in 5..220 do
		radius = i * 5
		arcNum = rand(6)
		arcNum.times do |i|
			minPoint = i * 360 / arcNum
			maxPoint = (i + 1) * 360 / arcNum
			startPoint = rand(maxPoint - minPoint - ARC_CENTRAL_ANGLE) + minPoint
			endPoint = startPoint + ARC_CENTRAL_ANGLE
			drawArc(centerX, centerY, radius, startPoint, endPoint)
				#minPoint <= startPoint_ <= maxPoint - ARC_CENTRAL_ANGLE
		end
	end
end
def deg2rad(degree)
	return degree * Math::PI / 180;
end
def drawArc(x, y, radius, startPoint, endPoint)
	((endPoint - startPoint).abs * 10).times do |i|
		curAngle = (startPoint).to_f + 0.1 * i
		pointX = x + (Math.cos(deg2rad(curAngle)) * radius)
		pointY = y + (Math.sin(deg2rad(curAngle)) * radius)
		pset(pointX, pointY, 255, 255, 255)
	end
end
def writeimage(name)
	open(name, "wb") do |f|
		f.puts("P6\n" + PICTURE_SIZE_X.to_s + " " + PICTURE_SIZE_Y.to_s + "\n255")
		$img.each do |a|
			a.each do |p|
				hoge = p.to_a.pack("ccc")
				f.write(p.to_a.pack("ccc")) 
			end
		end
	end
end
def myPicture()
	gradf(0, 480, 1920, 1080, 0x765312, 0x000000)
		#背景
	drawStars()
		#星
	fillCircle 960, 7680, 6720, 0, 0, 0
		#地面
	fillCircle 960, 540, 2, 255, 255, 255
		#北極星
	writeimage("t.ppm")
end

myPicture()
```
# プログラムの説明
## psetメソッド
描画色と座標を指定して点を描画
## gradfメソッド
左上座標と右下座標とそれぞれの塗りつぶしの色を指定して縦に色がグラデーションした矩形を描画
## fillCircleメソッド
中心座標と半径、塗りつぶしの色を指定して塗りつぶされた円を描画
## drawStarsメソッド
引数には何も取らず、弧を描画する場所を計算して弧を描くdrawArcメソッドを呼び出す
## deg2radメソッド
度数法の角度を受け取り、弧度法の角度で返す
## drawArcメソッド
弧の中心座標と半径、開始地点と終了地点の角度をそれぞれ指定して、白色(255,255,255)の弧を描画する
## writeImageメソッド
作成した画像データを指定したファイルに出力する
## myPictureメソッド
メインメソッド

# 生成された絵
夜明けの空でタイムラプスで星空を撮影したときの画像をイメージした絵

# 考察
プログラムのロジック自体は簡単にできたが、やはりruby独自の仕様に苦労した。
実は他の言語で先に同じのを作ってからrubyに移植しようとし、その言語では1時間程度でできたためかなり余裕だと考えていたところ、なかなかに苦戦してしまった。

# 6. 以下のアンケートの解答。
## Q1. 画像が自由に生成できるようになりましたか。
色々な図形を描画するメソッドができたため、今後もそれらを組み合わせて様々な画像が生成できるはずだ。
## Q2. 画像をうまく生成する「コツ」は何だと思いましたか。
誤差に気を付けること。
## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
まだ余り使い慣れていないが、グローバル変数になかなか癖があることが分かった。
また、今回作成したメソッドはどれも引数が多くなってしまったため、クラスや構造体にして引数を少なくすべきだと感じた。
