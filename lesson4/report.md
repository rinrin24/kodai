# 基礎プログラミングおよび演習レポート ＃04
* 学籍番号: 2291029
* 氏名: 中村凜
* ペア学籍番号・氏名(または「個人作業」): 個人作業
* 提出日付: 2022/10/07

# [課題の再掲]
## 演習8
自分の名前のローマ字表記を与えるとローマ字として成立するようなそのアナグラムを表示するプログラムを作れ。

# [プログラム・実行例とその説明]
## sample8.rb
```Ruby
$printedAnagram = {}
def makeAnagram(name)
    names = [];
    cnt = 0
    name.chars do |c|
        names[cnt] = c;
        cnt += 1
    end
    makeAnagram2(names.length, names, []);
end
def makeAnagram2(n, name, outputArray)
    if(n == 0)
        if(!$printedAnagram[outputArray]) then; $printedAnagram[outputArray] = true; p(outputArray); return; end
    end
    name.each_index do |i|
        if(name[i] == nil) then; next; end
        if(outputArray.length >= 2)
            if(isVowel(outputArray[outputArray.length-2]))
                if(outputArray[outputArray.length-1] == name[i])
                else
                    if(!isProper(outputArray[outputArray.length-1], name[i])) then; next; end;
                end
            end
        end
        if(outputArray.length == 1)
            if(!isProper(outputArray[outputArray.length-1], name[i])) then; next; end;
        end
        if(n == 1)
            if(!isProperForLastWord(name[i])) then; next; end;
        end
        outputArray.push(name[i])
        name[i] = nil;
        makeAnagram2(n-1, name, outputArray)
        name[i] = outputArray.pop
    end
end
def isProper(alphabetBefore, alphabet)
    if(alphabet == 'h')
        if((alphabetBefore == 'c') | (alphabetBefore == 's')) then; return true; end;
    end
    if((alphabetBefore == 't') & (alphabet == 's')) then; return true; end
    if(alphabet == 'y')
        if((alphabetBefore == 'k') | (alphabetBefore == 's') | (alphabetBefore == 't') | (alphabetBefore == 'n') | (alphabetBefore == 'h') | (alphabetBefore == 'm') | (alphabetBefore == 'r')) then; return true; end;
        if((alphabetBefore == 'g') | (alphabetBefore == 'z') | (alphabetBefore == 'd') | (alphabetBefore == 'b') | (alphabetBefore == 'p')) then; return true; end;
    end
    if((alphabetBefore == 'n') & (alphabet == 'n')) then; return false; end;
    if((alphabetBefore == 'n') & (!isVowel(alphabet))) then; return true; end;
    if((!isVowel(alphabetBefore)) & (!isVowel(alphabet))) then; return false; end;
    return true
end
def isProperForLastWord(alphabet)
    if(alphabet == 'n') then; return true; end;
    if(isVowel(alphabet)) then; return true; end;
    return false
end
def isVowel(alphabet)
    if(alphabet == 'a') then; return true; end;
    if(alphabet == 'e') then; return true; end;
    if(alphabet == 'i') then; return true; end;
    if(alphabet == 'o') then; return true; end;
    if(alphabet == 'u') then; return true; end;
    return false;
end

name = "rin"
makeAnagram(name)
```

## 実行結果
```
PS C:\Users\略\kodai\lesson4> ruby sample8.rb
["r", "i", "n"]
["n", "r", "i"]
```

`makeAnagram()` メソッドは引数に与えられた文字列からできるローマ字のアナグラムをすべて出力する。

また `makeAnagram2()` メソッドは `makeAnagram()` メソッドで呼び出され、それから再帰的に自分を呼び出すメソッドである。途中で `isProper()` メソッド、 `isProperForLastWord()` メソッドによってそれがローマ字として成立しているかを判別し、不適切なものは `next` することによって処理を終わらせている。

`isProper()` メソッドは２つの引数を受け取り、現在追加しようとしているアルファベットと一つ前のアルファベットだ(現在追加しようとするアルファベットが先頭の文字の場合は条件により呼び出されない)。一つ前のアルファベットと現在のアルファベットが両方とも子音ならば `false` を返す。しかし例外が複数あり、拗音や `sh` , `ch` , `ts` などの特殊な記述方法の場合、そして撥音はそれぞれ子音が連続でいても成り立つ例外なので、それらの場合 `true` を返している。もちろんこれらの条件のどれにも当てはまらない、つまり子音が連続していない場合は成り立つため `true` を返す。また、 `isProper()`メソッドを呼び出す際に

```Ruby
if(outputArray.length >= 2)
    if(isVowel(outputArray[outputArray.length-2]))
        if(outputArray[outputArray.length-1] == name[i])
        else
            if(!isProper(outputArray[outputArray.length-1], name[i])) then; next; end;
        end
    end
end
if(outputArray.length == 1)
    if(!isProper(outputArray[outputArray.length-1], name[i])) then; next; end;
end
```

のような条件式が書いてあるが、まず上の8行の部分は促音に対する例外の設定である。促音を条件として `isProper()` に入れることは、連続した２つの子音の前が、つまり現在のアルファベットの2つ前の文字が母音である必要があり、3つの数を引数として受け取らねばならないからだ。よって特殊な条件によって例外としている。促音は2つ前の文字を参照する必要があることから単語の長さが2以上の場合のみにしている。しかし単語の長さが1の場合も `isProper()` のチェックは必要であるため分離している。

また、 `isProperForLastWord()` メソッドは最後の文字が子音であるとローマ字として成立しないためその場合は `false` を返す。しかし、最後の文字が `n` の場合、つまり撥音の場合は最後の文字が子音でも成り立つため、例外として `true` を返す。

`isVowel()` メソッドはその名の通りその単語が母音なら `true` 、子音なら `false` を返すメソッドで、母音子音の判定を複数回行っていたためメソッドとして分離した。

さらに、`$printedAnagram` は `bool` 値をもつグローバルなハッシュであり、出力された文字の配列をキーとして、すでにその文字を出力していたならば `true` にするというものだ。これにより出力の重複をなくしている。

このプログラムは演習6の順列を表示するプログラムを改変したものであり、`makeAnagram()` メソッド内で与えられた文字列を一文字づつ分離し、配列として整形している。そのようにすることにより、配列の並び替えを行うという順列と同じ考え方ができるのである。

# [課題に対する報告]
再帰処理を適切に使うことができた。

# [考察]
メソッドを分離して細分化することによって保守性が高まった。

ただし重複を防ぐために `$printedAnagram` という**グローバル変数**を使ってしまっているため、コードが追いにくくなってしまっているため改善が必要だ。

# [アンケート]
## Q1. 手続きが使いこなせるようになりましたか。
使いこなせるようになったと思う。今まで手続き型言語を頻繁に使っていたため理解は容易だった。

## Q2. 再帰的な呼び出しについてはどうですか。
まだ複雑なロジックなどには慣れが必要だとは思うが、ある程度は使いこなせるようになったと思う。余談だが、Python の turtle graphics を使ってコッホ雪片なども作ることができた。バーンズリーのシダなども作ってみたい。

## Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。
再帰処理は会場やフィボナッチ数列などの単純な計算ならば簡単だが、順列などへ応用できることは驚いた。再帰処理は処理をスマートに行い、様々なものに使えそうだが、ロジックが複雑になりそうなので可読性の面では難ありだと思った。
