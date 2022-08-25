# 基礎プログラミングおよび演習レポート ＃01
* 学籍番号: 2291029
* 氏名:中村凜
* ペア学籍番号・氏名(または「個人作業」):個人作業
* 提出日付:2022/08/22

# [課題の再掲]
演習4-b 整数 m と n を受け取り「m 個のりんごを n 人で分けると、一人 d 個ずつもらえ、r 個余ります」という文章を英訳して出力。

# [プログラム・実行例とその説明]
## 演習4-b
### <sample4_1.rb>
```ruby
def divideApple(m, n)
	printf("If %d apples are divided in %d people, %d apples will be given to each person and %d will remain\n", m, n, m / n, m % n);
	return 0;
end
divideApple(20, 3);
```

sample4_1.rbを実行すると、以下の結果が得られた。

### <実行結果>
```
PS C:\略\kodai\lesson1> ruby sample4.rb
If 20 apples are divided in 3 people, 6 apples will be given to each person and 2 will remain
```

### <sample4_2.rb>
```ruby
def divideApple(m, n)
	printf("If %d apples are divided in %d people, %d apples will be given to each person and %d will remain\n", m, n, m / n, m % n);
	return 0;
end
divideApple(20, 3);
```

sample4_2.rbのようにdivideAppleメソッドの2つ目の引数を文字列"hoge"へと変更するとエラーが発生し、以下の結果が得られた。

### <実行結果>
```
PS C:\略\kodai\lesson1> ruby sample4.rb
sample4.rb:10:in `/': String can't be coerced into Integer (TypeError)
        from sample4.rb:10:in `divideApple'
        from sample4.rb:16:in `<main>'
```

ここでは、10行目にエラーが発生しているとなっているが、10行目には上プログラムの3行目にあたるprintf命令の行が書かれている。

エラーの文章は"文字列は整数のなかに強要させられない(型エラー)"と書かれており、つまり本来printf命令の文字列の中で%dと書かれているためで整数型の変数(もしくは整数)を引数として渡すべきだったところ、文字列型の変数を渡してしまったからだと思われる。

しかし、これはprintf命令の問題ではなく、printf命令の第三引数のm / nや、第四引数のm % nが原因の可能性もある。

そこで、m / n, m % nの部分を一度変数に代入し、それからprintf命令の引数に入れるように、プログラムを以下のように書き換えた。

### <sample4_3.rb>
```ruby
def divideApple(m, n)
	foo = m / n
	bar = m % n
	printf("If %d apples are divided in %d people, %d apples will be given to each person and %d will remain\n", m, n, foo, bar);
	return 0;
end
divideApple(20, "hoge");
```

これを実行したところ、再びエラーが発生し、以下のような結果が出た。

### <実行結果>
```
PS C:\略\kodai\lesson1> ruby sample4.rb
sample4.rb:10:in `/': String can't be coerced into Integer (TypeError)
        from sample4.rb:10:in `divideApple'
        from sample4.rb:18:in `<main>'
```

また、プログラムの2行目をコメントアウトして再び実行すると、エラーが発生し、以下のような結果が得られた。

### <sample4_4.rb>
```ruby
def divideApple(m, n)
	#foo = m / n
	bar = m % n
	printf("If %d apples are divided in %d people, %d apples will be given to each person and %d will remain\n", m, n, foo, bar);
	return 0;
end
divideApple(20, "hoge");
```

### <実行結果>
```
PS C:\略\kodai\lesson1> ruby sample4.rb
sample4.rb:11:in `%': String can't be coerced into Integer (TypeError)
        from sample4.rb:11:in `divideApple'
        from sample4.rb:18:in `<main>'
```

両方とも"String can't be coerced into Integer (TypeError)"というエラーが発生しているが、その前に書いてある、in\`/':という部分と、in\`%":という部分が異なっている。

これはつまりそれぞれの演算子を表しており、文字列を数値の計算に使おうとしたからだと思われる。

また、sample4_2.rbのprintfの第四、第五引数を定数に変えて再びコードを書き換えて実行した。

### <sample4_5.rb>
```ruby
def divideApple(m, n)
	printf("If %d apples are divided in %d people, %d apples will be given to each person and %d will remain\n", m, n, 1, 1);
	return 0;
end
divideApple(20, "hoge");
```

### <実行結果>
```
sample4.rb:12:in `printf': invalid value for Integer(): "hoge" (ArgumentError)
        from sample4.rb:12:in `divideApple'
        from sample4.rb:18:in `<main>'
```

ここには'整数に無効な値が: "hoge"(引数エラー)'と書かれている。

つまり本来引数に整数が与えられるべきところに文字列が与えられていたためだと考えられる。

# [課題に対する報告]
/ や %の計算式においてオペランドに文字列を使うことはできない。

また、printf命令において%dと書かれているところに文字列を代入することもできない。

# [考察]
これらから、命令を実行する際、まず初めに引数を第一引数から一つずつ参照し、その後命令を実行していることがわかる。

# [アンケート]
## Q1. プログラムを作るという課題はどれくらい大変でしたか?
rubyの独特の構文にあまりなれなかった、またemacsという未知のテキストエディタを使用したことでかなり大変だったが、いつも使っているvisual studio codeで編集するとかなり楽になり、結果的にはそこまで大変ではなかった。

## Q2. コンピュータでの数値の計算に対する数学とは違う挙動についてどう思いましたか?
実際に計算する場合は、計算し続ければ正確な数値は出るが、コンピュータでは数値を出す場合は有限時間で答えを出す必要があり、ある程度で計算をやめなければならないため、個の挙動は妥当だと感じた。

## Q3. リフレクション(今回の課題で分かった222こと)・感想・要望をどうぞ。
探求できる部分が多く楽しかった。ただレポートというものをあまり書いたことがないので少し苦労した。
