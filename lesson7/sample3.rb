def arrayminrange(a, i, j)
	minIndex = i
	minNumber = a[i]
	(j-i+1).times do |k|
		if a[k+i] < minNumber
			minNumber = a[k+i]
			minIndex = i + k
		end
	end
	return minIndex
end
def swap(a, i, j)
	tmp = a[i]
	a[i] = a[j]
	a[j] = tmp
end
def selectionsort(a)
	(a.length-1).times do |i|
		if(arrayminrange(a, i, a.length-1) != i)
			swap(a, arrayminrange(a, i, a.length-1), i)
		end
	end
end
def shiftlarger(a, i, x)
	while i>0 && a[i-1] > x do 
		a[i] = a[i-1]
		i -= 1
	end
	return i
end
def insertionsort(a)
	1.step(a.length-1) do |i|
			x = a[i]
		k = shiftlarger(a, i, x)
		a[k] = x
	end
end
def bucketsort(a)
	array = Array.new(10000) do 1 end;
	(a.length).times do |i|
		array[a[i]] += 1
	end
	currentindex = 0
	(10000).times do |i|
		while array[i] > 0
			a[currentindex] = i
			array[i] -= 1
			currentindex += 1
		end
	end
end
def merge(a1, i1, j1, a2, i2, j2)
	b = []
	while i1 <= j1 || i2 <= j2 do
		if i1 > j1 then b.push(a2[i2]); i2 = i2 + 1
		elsif i2 > j2 then b.push(a1[i1]); i1 = i1 + 1
		elsif a1[i1] > a2[i2] then b.push(a2[i2]); i2 = i2 + 1
		else b.push(a1[i1]); i1 = i1 + 1
		end
	end
	return b
end
def mergesort(a, i = 0, j = a.length-1)
	if j <= i
		# do nothing
	else
		k = (i + j) / 2
		mergesort(a, i, k); mergesort(a, k+1, j)
		b = merge(a, i, k, a, k+1, j)
		b.length.times do |m| a[i+m] = b[m] end
	end
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

Element = 20000
hoge = randarray(Element)
p(bench do insertionsort(hoge) end)
p(issorted(hoge))
hoge = randarray(Element)
p(bench do selectionsort(hoge) end)
p(issorted(hoge))
hoge = randarray(Element)
p(bench do bucketsort(hoge) end)
p(issorted(hoge))
hoge = randarray(Element)
p(bench do mergesort(hoge) end)
p(issorted(hoge))
hoge = randarray(Element)
p(bench do quicksort(hoge) end)
p(issorted(hoge))
#p(shiftlarger(hoge, 3, 10))
#p(hoge)