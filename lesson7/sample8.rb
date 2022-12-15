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

def combSort(a)
	isSwapped = true
	h = a.length * 10 / 13
	while(h > 1 || isSwapped)
		if(h > 1) 
			h = (h * 10 / 13).to_i
		end
		i = 0;
		isSwapped = false
		while(true)
			if(a[i] > a[i+h]) then; swap(a, i, i+h); isSwapped = true; end;
			i = i + 1
			if(i + h >= a.length) then; break; end;
		end
	end
	return a
end
def heapSort(a)
	index = 0
	i = 0
	while(index < a.length)
		i = 1
		while(i < a.length - index)
			makeHeap(a, i)
			i += 1
		end
		index += 1
		swap(a, 0, a.length - index)
		#p(a)
	end
	return a
end
def makeHeap(a, n)
	while(n > 0)
		parent = (n+1) / 2 - 1
		if(a[n] > a[parent]) then; swap(a, n, parent);
		else; break; end;
		n = parent
	end
end
class Array
	def sleep_sort
		mem = []
		map do |i|
    		Thread.new(i) do |n|
        		sleep n
    			mem << n
    		end
    	end.each(&:join)
		mem
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
#a = (1..10).sort_by { rand }
#p(a.sleep_sort)
RiseAmount = 100
10000.times do |i|
	hoge = randarray((1 + i) * RiseAmount)	
	puts(((1 + i) * RiseAmount).to_s + ", " + (bench do spaghettiSort(hoge); end).to_s)
	#p(hoge)
	#hoge = combSort(hoge)
	#hoge = heapSort(hoge)
	#hoge = spaghettiSort(hoge)
	#p(hoge)
	#p(issorted(hoge))
end