PICTURE_SIZE_X = 1920
PICTURE_SIZE_Y = 1080
ARC_CENTRAL_ANGLE = 30

Pixel = Struct.new(:r, :g, :b)

$img = Array.new(PICTURE_SIZE_Y) do
	Array.new(PICTURE_SIZE_X) do Pixel.new(0, 0, 0) end
end
def pset(x, y, r, g, b)
	if 0 <= x && x < PICTURE_SIZE_X && 0 <= y && y < PICTURE_SIZE_Y
		$img[y][x].r = r; $img[y][x].g = g; $img[y][x].b = b
	end
end
def gradf(x1, y1, x2, y2, colorCode1, colorCode2)
    firstColorB = colorCode1 % 0x100.to_i
    firstColorG = ((colorCode1 - firstColorB) / 0x100.to_i) % 0x100.to_i
    firstColorR = (colorCode1 - firstColorG * 0x100.to_i - firstColorB) / 0x10000.to_i
    endColorB = colorCode2 % 0x100.to_i
    endColorG = ((colorCode2 - endColorB) / 0x100.to_i) % 0x100.to_i
    endColorR = (colorCode2 - endColorG * 0x100.to_i - endColorB) / 0x10000.to_i
    curColorR = 0; curColorG = 0; curColorB = 0

	boxWidth = x2 - x1
    boxHeight = y2 - y1
    boxHeight.times do |i|
        curColorR = (firstColorR * i + endColorR * (boxHeight - i)) / boxHeight
        curColorG = (firstColorG * i + endColorG * (boxHeight - i)) / boxHeight
        curColorB = (firstColorB * i + endColorB * (boxHeight - i)) / boxHeight
        boxWidth.times do |j|
            pset(j + x1, i + y1, curColorR, curColorG, curColorB)
        end
    end
end
def fillCircle(x0, y0, rad, r, g, b)
	PICTURE_SIZE_Y.times do |y|
		PICTURE_SIZE_X.times do |x|
			if (x-x0)**2 + (y-y0)**2 <= rad**2
				pset(x, y, r, g, b)
			end
		end
	end
end
def drawStars()
	centerX = 960
	centerY = 540
	for i in 5..220 do
		radius = i * 5
		arcNum = rand(6)
		arcNum.times do |i|
			minPoint = i * 360 / arcNum
			maxPoint = (i + 1) * 360 / arcNum
			startPoint = rand(maxPoint - minPoint - ARC_CENTRAL_ANGLE) + minPoint
			endPoint = startPoint + ARC_CENTRAL_ANGLE
			drawArc(centerX, centerY, radius, startPoint, endPoint)
				#minPoint <= startPoint_ <= maxPoint - ARC_CENTRAL_ANGLE
		end
	end
end
def deg2rad(degree)
	return degree * Math::PI / 180;
end
def drawArc(x, y, radius, startPoint, endPoint)
	((endPoint - startPoint).abs * 10).times do |i|
		curAngle = (startPoint).to_f + 0.1 * i
		pointX = x + (Math.cos(deg2rad(curAngle)) * radius)
		pointY = y + (Math.sin(deg2rad(curAngle)) * radius)
		pset(pointX, pointY, 255, 255, 255)
	end
end
def writeimage(name)
	open(name, "wb") do |f|
		f.puts("P6\n" + PICTURE_SIZE_X.to_s + " " + PICTURE_SIZE_Y.to_s + "\n255")
		$img.each do |a|
			a.each do |p|
				hoge = p.to_a.pack("ccc")
				f.write(p.to_a.pack("ccc")) 
			end
		end
	end
end
def myPicture()
	gradf(0, 480, 1920, 1080, 0x765312, 0x000000)
	drawStars()
	fillCircle 960, 7680, 6720, 0, 0, 0
	fillCircle 960, 540, 2, 255, 255, 255
	writeimage("t.ppm")
end

myPicture()