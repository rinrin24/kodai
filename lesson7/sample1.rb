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

hoge = [10, 2, 4, 7, 3, 1, 5]
p(hoge)
#p(arrayminrange(hoge, 2, 4))
selectionsort(hoge)
p(hoge)