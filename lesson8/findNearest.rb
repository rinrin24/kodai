def findNearest()
	currentX = 1;
	previousX = currentX
	errorRange = 0.00000001
	currentX = currentX * 2
	while(true) do
		if((Math.log(currentX)**(0.0000009591602249 * currentX - 0.12)) < (0.0007186097056 * currentX + 0.023809692956))
			break;
		end
		previousX = currentX
		currentX = currentX * 2
	end
	max = currentX
	min = previousX
	currentX = (max + min).to_f / 2
	currentMax = max.to_f
	currentMin = min.to_f
	p(currentMax)
	p(currentMin)
	p(currentX)
	70.times do
		currentDifference = (Math.log(currentX)**(0.0000009591602249 * currentX - 0.12)) - (0.0007186097056 * currentX + 0.023809692956)
		puts("currentX: " + currentX.to_s + ", currentDifference" + currentDifference.to_s)
		if(currentDifference.abs < errorRange) then; break; end;
		smallX = (currentMin + currentX) / 2
		littleDifference = (Math.log(smallX)**(0.0000009591602249 * smallX - 0.12)) - (0.0007186097056 * smallX + 0.023809692956)
		if(littleDifference.abs < currentDifference.abs)
			currentMax = currentX
			currentX = (currentMax + currentMin) / 2
			next
		end
		currentMin = currentX
		currentX = (currentMax + currentX) / 2
	end
	return currentX
end

hoge = findNearest()
p(hoge)