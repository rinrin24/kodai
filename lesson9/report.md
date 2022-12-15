# 基礎プログラミングおよび演習レポート ＃09
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」):個人作業
* 提出日付: 2022/12/15

# [課題の再掲]
複素数 (complex number) を表すクラス Comp を定義し、動作を確認せよ。これを用いて何
らかの役に立つ計算をしてみられるとなおよい。

# [プログラム・実行例とその説明]
## sample4.rb
```Ruby
class ComplexNumber
	def initialize(newRealNumber, newImaginaryNumber)
		@realNumber = newRealNumber;
		@imaginaryNumber = newImaginaryNumber;
	end;
	def realNumber
		return @realNumber;
	end;
	def imaginaryNumber
		return @imaginaryNumber;
	end;
	def +(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		newRealNumber = newComplexNumber.realNumber + @realNumber;
		newImaginaryNumber = newComplexNumber.imaginaryNumber + @imaginaryNumber;
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def -(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		newRealNumber = -newComplexNumber.realNumber + @realNumber;
		newImaginaryNumber = -newComplexNumber.imaginaryNumber + @imaginaryNumber;
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def *(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		newRealNumber = newComplexNumber.realNumber * @realNumber - newComplexNumber.imaginaryNumber * @imaginaryNumber;
		newImaginaryNumber = newComplexNumber.realNumber * @imaginaryNumber + newComplexNumber.imaginaryNumber * @realNumber;
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def /(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		bunbo = newComplexNumber.realNumber**2 - newComplexNumber.imaginaryNumber**2
		bunshi = self * ComplexNumber.new(newComplexNumber.realNumber, -newComplexNumber.imaginaryNumber)
		newRealNumber = 1.0 * bunshi.realNumber / bunbo
		newImaginaryNumber = 1.0 * bunshi.imaginaryNumber / bunbo
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def **(power)
		outputNumber = self;
		(power-1).times do
			outputNumber = outputNumber * self;
		end
		return outputNumber;
	end;
	def inspect()
		if(@imaginaryNumber == 0) then; return @realNumber; end;
		if(@realNumber == 0) then; return @imaginaryNumber.to_s + " * i"; end;
		return @realNumber.to_s + " + " + @imaginaryNumber.to_s + " * i"
	end
	private
	def to_complexNumber(newNumber)
		if(newNumber.instance_of?(ComplexNumber)) then; return newNumber; end;
		return ComplexNumber.new(newNumber, 0);
	end;
end;

complexNumber = ComplexNumber.new(10, 5);
p(complexNumber);
p(complexNumber.realNumber);
p(complexNumber.imaginaryNumber);
otherComplexNumber = ComplexNumber.new(20, 10);
complexNumber = complexNumber + 5;
p(complexNumber);
complexNumber = complexNumber + 5.5;
p(complexNumber);
complexNumber = complexNumber + otherComplexNumber;
p(complexNumber);
complexNumber = complexNumber - 10;
p(complexNumber);
complexNumber = complexNumber - 5.5;
p(complexNumber);
complexNumber = complexNumber - otherComplexNumber;
p(complexNumber);
complexNumber = complexNumber * 2
p(complexNumber);
complexNumber = complexNumber * 1.25
p(complexNumber);
complexNumber = complexNumber * otherComplexNumber;
p(complexNumber);
complexNumber = complexNumber / 2;
p(complexNumber);
complexNumber = complexNumber / 2.5;
p(complexNumber);
complexNumber = complexNumber / otherComplexNumber;
p(complexNumber);
complexNumber = ComplexNumber.new(10, 10);
p(complexNumber);
complexNumber = complexNumber**3;
p(complexNumber);
```

## 実行結果
```
PS C:\Users\略\kodai\lesson9> ruby sample4.rb
10 + 5 * i
10
5
15 + 5 * i
20.5 + 5 * i
40.5 + 15 * i
30.5 + 15 * i
25.0 + 15 * i
5.0 + 5 * i
10.0 + 10.0 * i
12.5 + 12.5 * i
125.0 + 375.0 * i
62.5 + 187.5 * i
25.0 + 75.0 * i
4.166666666666667 + 4.166666666666667 * i
10 + 10 * i
-2000 + 2000 * i
```

`ComplexNumber` クラスはコンストラクタで実数部、虚数部をそれぞれ初期化し、値を代入する。

それぞれ`+`, `-`, `*`, `/`, `**`演算子を計算として使うことができる。

足し算、引き算はそれぞれ単純に実数部と虚数部を分けて計算して、`ComplexNumber`クラスのインスタンスを`new`して返している。

掛け算の場合、`(a + b * i) * (c + d * i) = (a * c - b * d) + (a * d + b * c) * i`となる。

割り算の場合は分母が複素数になってしまい、そのまま割ることができないため一度有利化してから計算している。

また、べき乗については単に掛け算を複数回行ってるのみである。

それぞれの演算子のメソッドでは複素数と複素数の計算のみではなく複素数と整数、複素数と浮動小数点数など、他の種類の数字とも計算できるように、`to_complexNumber()`という引数を`ComplexNumber`型にして返すプライベートメソッドを追加した。

さらに、`inspect()`というメソッドを追加することによって、`p()`メソッドで`ComplexNumber`クラスのインスタンスを出力する際に、`a + b * i`の形式で出力するようにした。

# [課題に対する報告]
オブジェクト指向を理解し、適切なクラスを作ることができた。

# [考察]
もともとはそれぞれの演算子のメソッドでは`int`型か`float`型か`ComplexNumber`型かを判断していたのだが、`to_complexNumber()`というプライベートメソッドを作ることによって重複コードや複雑条件分岐がなくなった。

また、出来ればインスタンス変数を不変にしたかったのだが、変数の最初の文字を大文字にしても一文字目の`@`の影響か不変にならなかった。保守性を高めるためにvalueオブジェクトである`ComplexNumber`クラスのインスタンス変数へのアクセスはpublic(本当はpackage privateが望ましいのだがJavaなどのpackageやC++などのnamespace機能がなかったため)にし、不変にするべきだと思う。

# [アンケート]
## Q1. クラス定義が書けるようになりましたか。
書けるようになりました。
インスタンス変数をメソッド内で定義できるところがJavascriptと似ていると感じた。

## Q2. オブジェクト指向について納得しましたか。
オブジェクト指向については納得したが、動的型付け言語であるRubyなどで型ともいえるクラスを使うのには違和感を感じた。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
先ほども述べたようにRubyでオブジェクト指向を行うのに少し違和感を感じた。しかし、C++などとは違って最近の言語の様にインスタンスを標準で参照型としてではなくポインタ型として渡すのは使い勝手が良いと感じた。
