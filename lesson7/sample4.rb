def randarray(n)
	return Array.new(n) do rand(10000) end
end
def bench
	t1 = Process.times.utime
	yield
	t2 = Process.times.utime
	return t2 - t1
end
def issorted(a)
	(a.length-1).times do |i|
		if(a[i] > a[i+1]) then; return false; end;
	end
	return true
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

Element = 1000
#i = 0
#hoge = randarray(Element + i * 1000)
#p(bench do quicksort(hoge) end)
1000000.times do |i|
	hoge = randarray(Element + i * 1000)
	puts((Element + i*1000).to_s + ", " + (bench do quicksort(hoge) end).to_s)
end
#p(issorted(hoge))