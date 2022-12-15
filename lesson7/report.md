# 基礎プログラミングおよび演習レポート ＃07
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」):個人作業
* 提出日付: 2022/12/15

# [課題の再掲]
**演習 4** quicksort を動かしてみなさい。データ数 N を何通りかに変化させて時間も測ること。N と所要時間の関係を検討すること。

**演習 6** ビンソートのプログラムを作成しなさい。動くことを確認すること。そのあと、N を何通りかに変化させて時間も測ること。N と所要時間の関係を検討すること。

**演習 7** 基数ソートのプログラムを作成しなさい。データ量と所要時間の関係を検討すること。

# [プログラム・実行例とその説明]
```Ruby
def randarray(n)
	return Array.new(n) do rand(100000) end
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
def bucketsort(a)
	maxNum = maxNumber(a)
	#p(maxNum)
	array = Array.new(maxNum+1) do 1 end;
	(a.length).times do |i|
		array[a[i]] += 1
	end
	currentindex = 0
	maxNum.times do |i|
		while array[i] > 0
			a[currentindex] = i
			array[i] -= 1
			currentindex += 1
		end
	end
end
def radixSort(array)
	outputArray = array.dup
	((Math.log2(maxNumber(array))).to_i + 1).times do |i|
		leftArray = Array.new();
		rightArray = Array.new();
		mask = 2**i
		(array.length).times do |j|
			if((outputArray[j] & mask) == 0) then
				leftArray.push(outputArray[j])
			else
				rightArray.push(outputArray[j])
			end;
		end
		leftArray.concat(rightArray)
		outputArray = leftArray
	end	
	return outputArray;	
end

Element = 1000
RiseAmount = 1000
((10000000 - Element) / RiseAmount + 1).times do |i|
	foo = randarray(Element + i * RiseAmount)
	hoge = foo.dup
	fuga = foo.dup
	piyo = foo.dup
	quickSortSpeed = bench do quicksort(hoge) end
	bucketSortSpeed = bench do bucketsort(fuga) end
	radixSortSpeed = bench do radixSort(piyo) end
	puts((Element + i*RiseAmount).to_s + ", " + quickSortSpeed.to_s + ", " + bucketSortSpeed.to_s + ", " + radixSortSpeed.to_s)
	if((Element + i*RiseAmount) == 1000000) then break end;
end
```

## 実行結果
1000行以上に及ぶので割愛。

ここでは単純に`randarray()`メソッドで配列を生成し、それを2つ`dup`して、同じ配列をソートさせ、それにかかった処理時間と要素数の関係を計測した。

それから得たデータ(csv形式)は、以下のようになった(実行環境はreplit)

[ソートアルゴリズムの計測_シート1](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubhtml?gid=0&single=true)

<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=1188886262&amp;format=interactive"></iframe>
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=1830937694&amp;format=interactive"></iframe>
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=982456464&amp;format=interactive"></iframe>
<iframe width="636" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=1207505387&amp;format=interactive"></iframe>

これらのデータから、データ数が大きくなるとクイックソートは二次関数的に、バケツソート、基数ソートは一次関数的に処理時間が増加することが分かった。

ただし、クイックソートはアルゴリズムではデータ数nに対して *nlogn* の処理時間がかかるとされているが、この図のみでは分からないのでさらなる検証が必要だ。

また、要素の数の範囲が0~99999であった場合はバケツソートがもっとも速く、続いて基数ソート、そして大きく差がついてクイックソートが最も遅いという結果になった。

さらに、要素の数の範囲と処理時間の関係も計測した。

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
def bucketsort(a)
	maxNum = maxNumber(a)
	#p(maxNum)
	array = Array.new(maxNum+1) do 1 end;
	(a.length).times do |i|
		array[a[i]] += 1
	end
	currentindex = 0
	maxNum.times do |i|
		while array[i] > 0
			a[currentindex] = i
			array[i] -= 1
			currentindex += 1
		end
	end
end
def radixSort(array)
	outputArray = array.dup
	((Math.log2(maxNumber(array))).to_i + 1).times do |i|
		leftArray = Array.new();
		rightArray = Array.new();
		mask = 2**i
		(array.length).times do |j|
			if((outputArray[j] & mask) == 0) then
				leftArray.push(outputArray[j])
			else
				rightArray.push(outputArray[j])
			end;
		end
		leftArray.concat(rightArray)
		outputArray = leftArray
	end	
	return outputArray;	
end

Element = 1000
RiseAmount = 1000
((10000000 - Element) / RiseAmount + 1).times do |i|
	foo = randarray(Element + i * RiseAmount)
	hoge = foo.dup
	fuga = foo.dup
	piyo = foo.dup
	quickSortSpeed = bench do quicksort(hoge) end
	bucketSortSpeed = bench do bucketsort(fuga) end
	radixSortSpeed = bench do radixSort(piyo) end
	puts((Element + i*RiseAmount).to_s + ", " + quickSortSpeed.to_s + ", " + bucketSortSpeed.to_s + ", " + radixSortSpeed.to_s)
	if((Element + i*RiseAmount) == 1000000) then break end;
end
```

`randarray()`メソッドを引数で受け取ったnをデータ数ではなくデータ範囲にした。

それから得たデータ(csv形式)は、以下のようになった(実行環境はreplit)。

[ソートアルゴリズムの計測_シート2](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubhtml?gid=832482499&single=true)

<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=990884199&amp;format=interactive"></iframe>
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=2046191560&amp;format=interactive"></iframe>
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=1900159568&amp;format=interactive"></iframe>
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vR1Ay5cNRqmOaFriMe_ZllmceHw0muG9cr36MCKVrNvsgRmo22zOTsWG-klkfenWhxWBaxdFoHU0o4E/pubchart?oid=2102373181&amp;format=interactive"></iframe>

このとき、クイックソートはデータ範囲nに対して処理時間が *nlogn* のような関係になった。また、バケツソート、基数ソートは一次関数的な関係になった。

クイックソートはデータ範囲が非常に小さいと処理時間が長くなるというのは何度やり直しても起こった。クイックソートがデータ範囲nに対して処理時間と *nlogn* の関係を持っているからだと思われる。

また、データ範囲が1000000程度になると、バケツソートと基数ソートがクイックソートの処理時間と同じくらいになった。
しかし、クイックソートが *O(nlogn)* の計算量であるのに対し、バケツソート、基数ソートは *O(n)* であるので、いずれ再びクイックソートよりもバケツソート、基数ソートの方が処理時間が短くなると思われる。

# [課題に対する報告]
クイックソート、バケツソート、基数ソートをそれぞれ理解し、それぞれの処理時間の関係を求めることができた。

# [考察]
今回は全てブラウザで動くIDEのreplitで実行したが、そこまで実行側のCPUの性能が高いとは言い切れず、正確なデータが取れていない可能性がある。

とはいえ、自分が普段使っているPCも10年以上前の機種で、CPU性能もあまりよいといえない。

よってさらに正確なデータを求めるには、安定した実行環境を得ることが必要だ。

# [アンケート]
## Q1. 整列アルゴリズムをいくつ理解しましたか。
理解した整列アルゴリズムは、
* 挿入ソート
* 選択ソート
* マージソート
* クイックソート
* 基数ソート
* コムソート
* ヒープソート
* スパゲッティソート

の8つ。

## Q2. . アルゴリズムの違いによる所要時間の違いをどう考えますか。
やはり状況によってそれぞれ処理時間が変わる。現在最も早いといわれているクイックソートでも状況によっては計算量が *O(n)* になってしまう。

よって多くの言語の標準のソートロジックで使われている複数のアルゴリズムを組み合わせるという考えは合理的だと思う。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
1000 * 6個のデータを集めるのは思ったよりも大変だった。