def deg2rad(degree)
	return degree * 180 / Math.PI;
end

def drawArc(x_, y_, radius_, startPoint_, endPoint_)
	(abs(endPoint_ - startPoint_) * 10).times do |i|
		curAngle = double(startPoint_) + 0.1 * i
		pset x_ + cos(deg2rad(curAngle)) * radius_, y_ + sin(deg2rad(curAngle)) * radius_
	end
end

#screen 0,1920,1080
ARC_CENTRAL_ANGLE = 30
#cls 4
centerX = 960
centerY = 540

#gradf 0, 480, 1920, 960, 1, $000000,$765312

#rgbcolor $ffffff
#circle centerX - 1, centerY - 1, centerX + 1, centerY + 1, 1

for i in 5..200 do
	radius = i * 5
	initialPointAngle = 10
	lastPointAngle = 50
	arcNum = rand(5) + 1
	arcNum.times do |i|
		minPoint = i * 360 / arcNum
		maxPoint = (i + 1) * 360 / arcNum
		startPoint = rand(maxPoint - minPoint - 30) + minPoint
		endPoint = startPoint + 30
		drawArc centerX, centerY, radius, startPoint, endPoint
		#minPoint <= startPoint_ <= maxPoint - 30
	end
end

#color
#circle -5760, 960, 7680, 14400, 1


bmpsave "itoutukusi.bmp"