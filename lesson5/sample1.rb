PICTURE_SIZE_X = 1920
PICTURE_SIZE_Y = 1080
ARC_CENTRAL_ANGLE = 30
$red = 0; $blue = 0; $green = 0;

Pixel = Struct.new(:r, :g, :b)

$img = Array.new(PICTURE_SIZE_Y) do
	Array.new(PICTURE_SIZE_X) do Pixel.new(0, 0, 0) end
end
def pset(x, y, r, g, b)
	#if 0 <= x && x < PICTURE_SIZE_X && 0 <= y && y < PICTURE_SIZE_Y
	if 0 <= x && x < 1920 && 0 <= y && y < 1080
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
	1080.times do |y|
		1920.times do |x|
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
end
def deg2rad(degree)
	return degree * Math::PI / 180;
end
def drawArc(x_, y_, radius_, startPoint_, endPoint_)
	((endPoint_ - startPoint_).abs * 10).times do |i|
		curAngle = (startPoint_).to_f + 0.1 * i
		pointX = x_ + (Math.cos(deg2rad(curAngle)) * radius_)
		pointY = y_ + (Math.sin(deg2rad(curAngle)) * radius_)
		#printf("x: %g, y: %g\n", pointX, pointY)
		pset(pointX, pointY, 255, 255, 255)
	end
end
def writeimage(name)
	open(name, "wb") do |f|
		f.puts("P6\n1920 1080\n255")
		$img.each do |a|		#y
			#p(a)
			k = 0
			a.each do |p|		#x
				#p(k)
				#p(p.to_a)
				hoge = p.to_a.pack("ccc")
				f.write(p.to_a.pack("ccc")) 
				k += 1
			end
		end
	end
end
def mypicture
	gradf(0, 480, 1920, 1080, 0x765312, 0x000000)
	$red = 255; $green = 255, $blue = 255
	drawStars()
	#p("------------------------------------")
	#sleep(20)
	fillCircle 960, 7680, 6720, 0, 0, 0
	writeimage("t.ppm")
end

mypicture()