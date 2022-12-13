Pixel = Struct.new(:r, :g, :b)
$img = Array.new(200) do
  Array.new(300) { Pixel.new(255, 255, 255) }
end
def pset(x, y, r, g, b)
  if 0 <= x && x < 300 && 0 <= y && y < 200
    $img[y][x].r = r; $img[y][x].g = g; $img[y][x].b = b
  end
end

def writeimage(name)
  open('t1/' + name, 'wb') do |f|
    f.puts("P6\n300 200\n255")
    $img.each do |a|
      a.each { |p| f.write(p.to_a.pack('ccc')) }
    end
  end
end

def drawLine(p, q, r, g, b)
  300.times do |x|
    pset(x, (p * x + q), r, g, b)
  end
  200.times do |y|
    pset(((y - q) / p), y, r, g, b)
  end
end

def drawThickLine(p, q, r, g, b)
  p1 = -1.0 / p
  300.times do |x|
    y1 = p * x + q
    pset(x, y1, r, g, b)
    q1 = y1 - p1 * x
    x1 = (y1 + 1 - q1).to_f / p1
    pset(x1, y1 + 1, r, g, b)
    x1 = (y1 - 1 - q1).to_f / p1
    pset(x1, y1 - 1, r, g, b)
  end
  200.times do |y|
    x1 = (y - q).to_f / p
    pset(x1.to_i, y, r, g, b)
    q1 = y.to_f - x1 * p1
    y1 = (x1 + 1).to_f * p1 + q1
    pset(x1 + 1, y1, r, g, b)
    y1 = (x1 - 1).to_f * p1 + q1
    pset(x1 - 1, y1, r, g, b)
  end
end

def drawSegment(x1, y1, x2, y2, r, g, b)
  (x2 - x1).times do |x|
    pset(x + x1, ((y2 - y1).to_f / (x2 - x1) * x + y1).to_i, r, g, b)
  end
  (y2 - y1).times do |y|
    pset(((x2 - x1).to_f / (y2 - y1) * y + x1).to_i, y + y1, r, g, b)
  end
end
def fillRectangle(x1, y1, x2, y2, r, g, b)
	(x2-x1).times do |x|
		(y2-y1).times do |y|
			pset(x + x1, y + y1, r, g, b)
		end
	end
end
def fillTriangle(x1, y1, x2, y2, x3, y3, r, g, b)
	x0 = (x1+x2+x3).to_f/3
	y0 = (y1+y2+y3).to_f/3
	
	a1 = (y1 - y2).to_f / (x1 - x2)
	b1 = y1.to_f - a1 * x1
	line1 = 1
	if y0 >= (a1 * x0 + b1) then; line1 = -1; end

	a2 = (y2 - y3).to_f / (x2 - x3)
	b2 = y2.to_f - a2 * x2
	line2 = 1
	if y0 >= (a2 * x0 + b2) then; line2 = -1; end

	a3 = (y3 - y1).to_f / (x3 - x1)
	b3 = y3.to_f - a3 * x3
	line3 = 1
	if y0 >= (a3 * x0 + b3) then; line3 = -1; end
	200.times do |y|
		300.times do |x|
			if (y * line1 <= (a1 * x + b1) * line1) & (y * line2 <= (a2 * x + b2) * line2) & (y * line3 <= (a3 * x + b3) * line3)
				pset(x, y, r, g, b)
			end
		end
	end
end

def mypictureA
  drawLine(2, 10, 255, 0, 0)
  drawLine(0.5, 10, 0, 255, 0)
  writeimage('t1_A.ppm')
end

def mypictureB
  drawThickLine(2, 10, 255, 0, 0)
  drawThickLine(0.5, 10, 0, 255, 0)
  writeimage('t1_B.ppm')
end

def mypictureC
  drawSegment(10, 10, 10, 100, 255, 0, 0)
  drawSegment(10, 10, 100, 10, 255, 0, 0)
  drawSegment(10, 100, 100, 100, 255, 0, 0)
  drawSegment(100, 10, 100, 100, 255, 0, 0)
  writeimage('t1_C.ppm')
end
def mypictureD
	fillRectangle(10, 10, 100, 100, 255, 0, 0)
	writeimage('t1_D.ppm')
end
def mypictureE
	fillTriangle(10, 10, 100, 80, 50, 150, 255, 0, 0)
	writeimage('t1_E.ppm')
end

mypictureE
