# 基礎プログラミングおよび演習レポート ＃10
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」): 個人作業
* 提出日付:

# [課題の再掲]
クラス Buffer を打ち込み、動作を確認せよ。動いたら、以下の操作 (メソッド) を追加して
みよ。
* 現在行を削除する
* 現在行と次の行の順序を交換する
* 1 つ前の行に戻る
* すべての行の順番を逆順にする

# [プログラム・実行例とその説明]
## sample3.rb
```Ruby
class Buffer
	Cell = Struct.new(:data, :next)
	def initialize
		@tail = @cur = Cell.new('EOF', nil)
		@head = @prev = Cell.new('', @cur)
	end

	def ateof
		@cur == @tail
	end

	def top
		@prev = @head; @cur = @head.next
	end

	def forward
	    return if ateof
		@prev = @cur; @cur = @cur.next
	end
	def backward
		if(@prev == @head) then; return; end;
		tmp = @prev;
		self.top();
		while(@cur != tmp) do
			self.forward();
		end
	end

	def swap
		if ateof then; return; end;
		if @cur.next == @tail then; return; end;
		tmp = @cur.next.next;
		@prev.next = @cur.next;
		@cur.next.next = @cur;
		@cur.next = tmp;
		@cur = @prev.next;
	end
	def reverse
		self.top
		tail = @head;
		tail.next = nil;
		pre = tail;
		cur = @cur;
		while(cur != @tail)
			curNext = cur.next
			cur.next = pre;
			pre = cur;
			cur = curNext;
		end
		cur.next = pre;
		@head = cur;
		@tail = tail;
	end

	def insert(s)
    	@prev.next = Cell.new(s, @cur); @prev = @prev.next;
	end

	def delete
    	if ateof then; return; end;
	    @prev.next = @cur.next; @cur = @cur.next;
	end

	def print
    	puts(' ' + @cur.data);
  	end
end

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.top;
buffer.print;
buffer.forward;
buffer.delete;
buffer.print
buffer.forward
buffer.print
buffer.forward
buffer.print

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.top;
buffer.print;
buffer.forward;
buffer.swap();
buffer.print
buffer.forward
buffer.print
buffer.forward
buffer.print

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.top;
buffer.print;
buffer.forward;
buffer.print
buffer.backward;
buffer.print
buffer.forward
buffer.print

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.reverse;
buffer.top;
buffer.print;
buffer.forward;
buffer.print
buffer.forward
buffer.print
buffer.forward
buffer.print
```
## 実行結果
```
PS C:\Users\中略\kodai\lesson10> ruby sample3.rb
 hello
 world
 !!!  
 EOF  
 hello
 world
 my   
 !!!  
 hello
 my   
 hello
 my   
 !!!  
 world
 my   
 hello
```

課題の通りの動作をするメソッドを追加した。

`delete()` メソッドは単純に一つ前の要素の `next` を次の要素にし、次の要素を現在の要素にする。

`swap()` メソッドは現在の要素と次の要素を交換するために、次の次の要素を予め保存しておき、前の要素の `next` を次の要素にし、次の要素の `next` を現在の要素にする。そして現在の要素の次の要素を予め保存しておいた次の次の要素に変更し、現在の要素をもともと次の要素であったものに合わせる。

`backward()` メソッドは予め一つ前の要素を保存しておき、一度 `top()` メソッドで先頭に戻ってから一つ前の要素と `@cur` が同じ要素にたどり着くまで `forward()` メソッドを呼び出し続けている。

`reverse()` メソッドは最初に戦闘の要素を末尾の要素として保存し、`next` を `nil` として設定する。一つ前の要素として一時的にそれを保存する。そして現在の要素の次の要素を一つ前の要素にする。そして現在の要素をその次の要素にし、その工程を繰り返す。最後に `@head` と `@tail` を設定して完了。

# [課題に対する報告]
単連結リストを理解し、適切に使うことができた。

# [考察]
とても複雑なロジックだったので紙に書きながら試行錯誤していた。このような複雑なロジックをクラスに隠すというのはとても合理的だと感じた。

# [アンケート]
## Q1. 何らかの動的データ構造が扱えるようになりましたか。
簡単なものならば使えるようになった。

## Q2. 複雑な構造をクラスの中にパッケージ化する利点について納得しましたか。
納得した。使う側がいちいちこのようなことを考えていたらまともにプログラミングができないだろう。

## Q3. リフレクション (今回の課題で分かったこと)・感想・要望をどうぞ。
思ったよりも難しかった。やはりプログラミングでロジックに困ったときは紙に手書きするに限ると感じた。