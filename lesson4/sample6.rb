def nest3(n, s) # 呼び方:nest3(3,"") ←空文字列渡す
    if n <= 0 then; puts(s); return; end;
    1.step(3) do |i| nest3(n-1, s + i.to_s) end
    return
end
def perm(a)
    perm1(a.length, a, [])
end
def perm1(n, a, b)
    if(n == 0) then; p(b); return; end
    a.each_index do |i|
        if(a[i] == nil) then; next; end
        b.push(a[i]); a[i] = nil; perm1(n-1, a, b); a[i] = b.pop
    end
end

#nest3(3, "")
hoge = [2, 4, 3, 6, 7, 5]
perm(hoge)