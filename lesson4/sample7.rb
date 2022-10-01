def sort(a)
    sort1(a.length, a, [])
end
def sort1(n, a, b)
    if(n == 0) then
        if(isAscendingOrder(b)) then
            p(b)
            return
        end
    end
    a.each_index do |i|
        if(a[i] == nil) then; next; end
        b.push(a[i]); a[i] = nil; sort1(n-1, a, b); a[i] = b.pop
    end
end
def isAscendingOrder(a)
    for i in 0..(a.length - 2) do
        if(a[i] > a[i+1]) then; return false; end
    end
    return true
end

hoge = [2, 4, 3, 6, 7, 5]
#perm(hoge)
sort(hoge)