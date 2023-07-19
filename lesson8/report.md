<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
# 基礎プログラミングおよび演習レポート ＃08
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」): 個人作業
* 提出日付: 2022/12/31

# [課題の再掲]
計算量の異なる複数のアルゴリズムを用いたプログラムを作成し、それらの答えが一致することを確認した上で、実行時間を比較しなさい。

# [プログラム・実行例とその説明]
## sample2.rb
```Ruby
def randarray(n)
	return Array.new(100000) do rand(n) end
end
def bench
	t1 = Process.times.utime
	yield
	t2 = Process.times.utime
	return t2 - t1
end

def swap(a, i, j)
	tmp = a[i]
	a[i] = a[j]
	a[j] = tmp
end
def quicksort(a, i = 0, j = a.length-1)
	if j <= i
		# do nothing
	else
		pivot = a[j]; s = i
		i.step(j-1) do |k|
			if a[k] <= pivot then swap(a, s, k); s = s + 1
			end
		end
		swap(a, j, s); quicksort(a, i, s-1); quicksort(a, s+1, j)
	end
end
def maxNumber(array)
	maxNum = 0
	(array.length).times do |i|
		if(array[i] > maxNum) then; maxNum = array[i]; end
	end
	return maxNum
end
def spaghettiSort(a)
	maxNum = maxNumber(a)
	spaghetti = []
	n = a.length
	i = maxNum
	while(i > 0)
		n.times do |j|
			if(a[j])
			if(a[j] >= i)
				spaghetti.unshift(a[j])
				a.delete_at(j)
			end
			end
		end
		i -= 1
	end
	return spaghetti
end

Element = 1000
RiseAmount = 1000
((10000000 - Element) / RiseAmount + 1).times do |i|
	hoge = randarray(Element + i * RiseAmount)
	quickSortSpeed = bench do quicksort(hoge) end
	puts((Element + i*RiseAmount).to_s + ", " + quickSortSpeed.to_s)
	if((Element + i*RiseAmount) == 3000000) then break end;
end
100.times do |i|
	hoge = randarray((1 + i) * RiseAmount / 10)	
	puts(((1 + i) * RiseAmount / 10).to_s + ", " + (bench do spaghettiSort(hoge); end).to_s)
end
```

## 実行結果
1000行以上に及ぶため割愛。

ここでは、計測を行うループを二つに分けた。スパゲッティソートの計算時間が非常に長く、あまり多くのサンプルを得られないからだ。

それぞれのループでは、単純に`randarray()`メソッドで配列を生成し、それをソートさせている。ソートする配列はソートアルゴリズムによって異なっているため、正確なデータは得られていないかもしれない。

それから得たデータ(csv形式)は以下のようになった(実行環境はreplit)。

[ソートアルゴリズムの計測_シート3](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubhtml?gid=1953407655&single=true)

<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=2033809595&amp;format=interactive"></iframe>

<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=238404367&amp;format=interactive"></iframe>

アルゴリズムの理論上、クイックソートは *O(nlogn)* , スパゲッティソートは *O(n)* の計算量となるとされている。

つまるところ、データ数 *n* が大きくなると、いずれスパゲッティソートの計算量がクイックソートの計算量よりも小さくなるということがわかる。

そのクイックソートの計算量がスパゲッティソートの計算量を超える時のデータ数 *n* を求める。

### それぞれの関数を求める

まずそれぞれのデータ数と処理時間の関係の関数を求める必要がある。クイックソートの関数は最小二乗法によって求める。

以降数式をLaTeX形式で記述するため、javascriptが動作し、"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"にアクセスできる環境で閲覧すると数式がLaTeXの形式で表示される。

また、以降$\sum_{i=1}^{n}$を簡略化のため、$\sum$と表す。

データを $(データ数N, 所要時間s)$ の、 $(x1, y1), (x2, y2), (x3, y3), \cdots (xn, yn)$ とすると、 

$$ J=\sum(y_i-f(x_i)) $$

が最小になるようにすれば良い。
ここで、関数は原点を通るとして 
$$ f(x) = ax\log x + b\log x + c $$
とすると 

$$ J(a,b,c) = \sum(y_i - (a(x_i)(\log x_i) + b(\log x_i) + c))^2 $$

よってa, b, cのそれぞれでJを偏微分すると、

$$ \frac{\partial J} {\partial a} = \sum(y_i-(ax_i\log x_i+b\log x_i+c))(-x_i\log x_i) $$

$$ \frac{\partial J}{\partial b} = \sum(y_i-(ax_i\log x_i + b\log x_i + c)(-\log x_i)$$ 

$$ \frac{\partial J}{\partial c} = \sum(y_i-(ax_i\log x_i + b\log x_i + c)(-1) $$

ここから3つの連立方程式が導き出される

$$ a\sum(x_i^2(\log x_i)^2) + b\sum(x_i(\log x_i)^2) + c\sum(x_i\log x_i) - \sum(x_i(\log x_i) y_i) = 0 $$

$$ a\sum(x_i(\log x_i)^2) + b\sum(\log x_i)^2 + c\sum(\log x_i) - \sum((\log x_i) y_i) = 0 $$

$$ a\sum(x_i\log x_i) + b\sum(\log x_i) + c - \sum(y_i) = 0 $$

これらの方程式に値を代入し、

$$ 6.07222 \times 10^{16}a + 88871861143b + 6664663859c - 47858972200 = 0 $$

$$ 88871861143a + 165319.578b + 12819.88346c - 65920.34213= 0 $$

$$ 6664663859a + 12819.88346b + c - 4910.322076 = 0 $$

よってこの連立方程式を解いて、

$$ a = 0.0000009591602249, b = -0.12, c = -0.02 $$

となり、つまり求める近似曲線は

$$ f(x) = 0.0000009591602249x\log x - 0.12\log x - 0.02 $$

実際の所要時間のグラフと近似曲線にて求めた関数は以下のようになった。

[ソートアルゴリズムの計測_シート5](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubhtml?gid=1434970489&single=true)

<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=1064009704&amp;format=interactive"></iframe>

次に、スパゲッティソートの関数も同様に最小二乗法によって求める。

$$ g(x) = ax + b $$

とすると、

$$ J(a, b) = \sum(y_i - ax_i - b) $$

よってこれを、a, bで偏微分すると

$$ \frac{\partial J}{\partial a} = \sum(y_i - ax_i - b)(-x_i) $$

$$ \frac{\partial J}{\partial b} = \sum(y_i - ax_i - b)(-1) $$

これらから2つの連立方程式が導き出される。

$$ a\sum(x_i)^2 + b\sum(x_i) - \sum(x_iy_i) = 0 $$

$$ a\sum(x_i) + b - \sum(y_i) = 0 $$

よってこれを解くと、

$$ a = 0.0007186097056, b = 0.003809692956 $$

故に、求める関数は

$$ g(x) = 0.0007186097056x + 0.003809692956 $$

実際の所要時間のグラフと近似曲線にて求めた関数は以下のようになった。

[ソートアルゴリズムの計測_シート6](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubhtml?gid=1939245894&single=true)

<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=562224261&amp;format=interactive"></iframe>

### 関数が交差する点を求める

次に、それぞれの関数が交差する点、つまり$f(x)=g(x)$となるxを求める。

$$ 0.0000009591602249x\log x - 0.12\log x - 0.02 = 0.0007186097056x + 0.003809692956 $$

これを変形すると、

$$ (0.0000009591602249x - 0.12)\log x - 0.02 = 0.0007186097056x + 0.003809692956 $$

$$ (\log x)^{0.0000009591602249x - 0.12} = 0.0007186097056x + 0.023809692956 $$

この方程式の解を求めようと考えたのだが、調べた限り対数関数と一次関数の交点は求められないの記載が複数あった。よってこの一次関数も対数関数との交点も求められないと考え、近似値を求めることにした。

近似値を求めるために以下のプログラムを作成した。

## findNearest.rb
```Ruby
def findNearest()
	currentX = 1;
	previousX = currentX
	errorRange = 0.00000001
	currentX = currentX * 2
	while(true) do
		if((Math.log(currentX)**(0.0000009591602249 * currentX - 0.12)) < (0.0007186097056 * currentX + 0.023809692956))
			break;
		end
		previousX = currentX
		currentX = currentX * 2
	end
	max = currentX
	min = previousX
	currentX = (max + min).to_f / 2
	currentMax = max.to_f
	currentMin = min.to_f
	p(currentMax)
	p(currentMin)
	p(currentX)
	70.times do
		currentDifference = (Math.log(currentX)**(0.0000009591602249 * currentX - 0.12)) - (0.0007186097056 * currentX + 0.023809692956)
		puts("currentX: " + currentX.to_s + ", currentDifference" + currentDifference.to_s)
		if(currentDifference.abs < errorRange) then; break; end;
		smallX = (currentMin + currentX) / 2
		littleDifference = (Math.log(smallX)**(0.0000009591602249 * smallX - 0.12)) - (0.0007186097056 * smallX + 0.023809692956)
		if(littleDifference.abs < currentDifference.abs)
			currentMax = currentX
			currentX = (currentMax + currentMin) / 2
			next
		end
		currentMin = currentX
		currentX = (currentMax + currentX) / 2
	end
	return currentX
end

hoge = findNearest()
p(hoge)
```

## 実行結果
```
2048.0
1024.0
1536.0
currentX: 1536.0, currentDifference-0.3379828861138192
currentX: 1280.0, currentDifference-0.15204277185405024
currentX: 1152.0, currentDifference-0.05885477113323978
currentX: 1088.0, currentDifference-0.012190700416399358        
currentX: 1056.0, currentDifference0.011161486202036497
currentX: 1072.0, currentDifference-0.0005163767658120655       
currentX: 1080.0, currentDifference-0.006353973866891294        
currentX: 1076.0, currentDifference-0.0034352850144219182       
currentX: 1074.0, currentDifference-0.001975858425666832        
currentX: 1073.0, currentDifference-0.0012461244935780824       
currentX: 1072.5, currentDifference-0.0008812523559031948       
currentX: 1072.25, currentDifference-0.0006988149926285825      
currentX: 1072.125, currentDifference-0.0006075959871905123     
currentX: 1072.0625, currentDifference-0.0005619864034972499    
currentX: 1072.03125, currentDifference-0.000539181591404092    
currentX: 1072.015625, currentDifference-0.0005277791802954512  
currentX: 1072.0078125, currentDifference-0.0005220779734755876 
currentX: 1072.00390625, currentDifference-0.0005192273697494088
currentX: 1072.001953125, currentDifference-0.0005178020678071604
currentX: 1072.0009765625, currentDifference-0.0005170894168161633
currentX: 1072.00048828125, currentDifference-0.0005167330913158352
currentX: 1072.000244140625, currentDifference-0.0005165549285643944
currentX: 1072.0001220703125, currentDifference-0.00051646584718823
currentX: 1072.0000610351562, currentDifference-0.0005164213065002032
currentX: 1072.0000305175781, currentDifference-0.0005163990361561899
currentX: 1072.000015258789, currentDifference-0.0005163879009840722
currentX: 1072.0000076293945, currentDifference-0.0005163823333981243
currentX: 1072.0000038146973, currentDifference-0.0005163795496051504
currentX: 1072.0000019073486, currentDifference-0.0005163781577085524
currentX: 1072.0000009536743, currentDifference-0.0005163774617603645
currentX: 1072.0000004768372, currentDifference-0.0005163771137861595
currentX: 1072.0000002384186, currentDifference-0.0005163769397992235
currentX: 1072.0000001192093, currentDifference-0.0005163768528057
currentX: 1072.0000000596046, currentDifference-0.0005163768093088272
currentX: 1072.0000000298023, currentDifference-0.0005163767875605574
currentX: 1072.0000000149012, currentDifference-0.0005163767766862559
currentX: 1072.0000000074506, currentDifference-0.0005163767712491607
currentX: 1072.0000000037253, currentDifference-0.0005163767685306686
currentX: 1072.0000000018626, currentDifference-0.0005163767671714226
currentX: 1072.0000000009313, currentDifference-0.000516376766491633
currentX: 1072.0000000004657, currentDifference-0.0005163767661519048
currentX: 1072.0000000002328, currentDifference-0.0005163767659819296
currentX: 1072.0000000001164, currentDifference-0.0005163767658971086
currentX: 1072.0000000000582, currentDifference-0.000516376765854587
currentX: 1072.000000000029, currentDifference-0.0005163767658333818
currentX: 1072.0000000000146, currentDifference-0.0005163767658226126
currentX: 1072.0000000000073, currentDifference-0.0005163767658173946
currentX: 1072.0000000000036, currentDifference-0.00051637676581473
currentX: 1072.0000000000018, currentDifference-0.0005163767658133978
currentX: 1072.000000000001, currentDifference-0.0005163767658127316
currentX: 1072.0000000000005, currentDifference-0.0005163767658123986
currentX: 1072.0000000000002, currentDifference-0.0005163767658122875
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
currentX: 1072.0, currentDifference-0.0005163767658120655
1072.0
```

プログラムとしては、
$$ (\log x)^{0.0000009591602249x - 0.12} = 0.0007186097056x + 0.023809692956 $$
の $x$ を変化させてゆき、$(\log x)^{0.0000009591602249x - 0.12}$ が $0.0007186097056x + 0.023809692956$ よりも小さくなるまで $x$ に $2$ をかけ続ける。

そしてそで得られた値を最大とし、その半分の値を最小とした範囲で二分探索を行う。そこでRubyの桁数の限界まで探索を続ける。

これによって $1072.0$ というデータを得た(右辺と左辺の誤差は $0.0005163767658120655$ )。

よって数式によると、データ数が $1072$ を超えるとスパゲティソートの性能がクイックソートの性能を超えるとされている。

# [課題に対する報告]
計算量の異なるアルゴリズムのプログラムの性能を比較することができた。

# [考察]
なんとか解を導き出すことができたが、実際にデータ数2000で比較してみたところ、クイックソートが *0.004271s*, スパゲティソートが *1.506938s* となった。よって導き出した答えは間違っていた。どこかで式、または計算で間違いがあった、もしくはスパゲティソートの近似直線の精度は十分だったが、クイックソートの近似曲線の精度が不十分だったことが原因として挙げられる。

# [アンケート]
## Q1. 乱数を使ったアルゴリズムを自分なりにどのように考えますか。
確率などの確認などには使いやすいと考える。試行回数が精度に直結するので、実行環境によって結果の得やすさが大きく変わるのが問題点。また、ボゴソートアルゴリズムの様に、無限ループになる得るアルゴリズムでは、一定確率で非常に時間がかかる場合があり、試行の間にスリープなどを入れていないと強い負荷がかかる可能性がある。多くの試行回数が伴うアルゴリズムでは、本当に使う必要があるか見極める必要がある。

## Q2. シミュレーションを構成するときのコツは何だと思いますか。
ただただ乱数によるシミュレーションを行うだけでなく、シミュレーションを数学的なモデルへ落とし込み、期待値などの計算式を構築しながら、その結果と計算を照らし合わせながら調整することだと思う。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
今回クイックソートの平均計算量である $O(n\log n)$ の近似曲線を求めようとしたが、調べたところ日本語ではヒットしなかった。最小二乗法によって求めようとしたが、最小二乗法の例をいくつか見たところ、多くが $\sum(y_i - f(x_i))^2$ の式を採用していた。これでは関数 $f(x)$ からの**距離**を求めているわけではないので、正確なデータは取れないと考え、色々な方法を模索したが、$a, b, c$ に加えて、接点など、多くの文字が式に出てしまい、現在の知識では簡略化が不可能であったため、結果的にあきらめることとなってしまった。ここに数週間かかり、とても大変だった。

また、 $\sum(y_i - f(x_i))^2$ で計算をしても、数列の扱いにとても苦労した。 $\sum(x_iy_i) \neq \sum(x_i)\sum(y_i)$ ということになかなか築かなかった。さらに、今回の大半は*Google Spreadsheet*で計算を行ったのだが、有効数字の問題で計算が何回か失敗した。

このプログラムは、ソートアルゴリズムを色々検索していて、スパゲティソートという非常に面白いソートアルゴリズムを知り、これがクイックソートの計算量を超えるデータ数を知りたいという突発的な考えで作り始めたが、データの整理にかなり時間がかかった。結果はあまり良いものが出なかったが、自分の数学の範囲外のことを色々勉強したりしたので、達成感があった。