def shiftlarger(a, i, x)
	while i>0 && a[i-1] > x do 
		a[i] = a[i-1]
		i -= 1
	end
	return i
end
def insertionsort(a)
	1.step(a.length-1) do |i|
		#p(i)
		x = a[i]
		k = shiftlarger(a, i, x)
		a[k] = x
	end
end

#p(hoge)

#p(hoge)