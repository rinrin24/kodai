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
def spaghettiSort(a)
	maxNum = maxNumber(a)
	spaghetti = []
	n = a.length
	i = maxNum
	while(i > 0)
		n.times do |j|
			if(a[j])
			if(a[j] >= i)
				spaghetti.unshift(a[j])
				a.delete_at(j)
			end
			end
		end
		i -= 1
	end
	return spaghetti
end

Element = 1000
RiseAmount = 1000
((10000000 - Element) / RiseAmount + 1).times do |i|
	hoge = randarray(Element + i * RiseAmount)
	quickSortSpeed = bench do quicksort(hoge) end
	puts((Element + i*RiseAmount).to_s + ", " + quickSortSpeed.to_s)
	if((Element + i*RiseAmount) == 3000000) then break end;
end
100.times do |i|
	hoge = randarray((1 + i) * RiseAmount / 10)	
	puts(((1 + i) * RiseAmount / 10).to_s + ", " + (bench do spaghettiSort(hoge); end).to_s)
end