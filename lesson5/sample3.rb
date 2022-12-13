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
  open('t3/' + name, 'wb') do |f|
    f.puts("P6\n300 200\n255")
    $img.each do |a|
      a.each { |p| f.write(p.to_a.pack('ccc')) }
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
def mypictureC
	fillTriangle(10, 10, 100, 80, 50, 150, 255, 0, 0)
	writeimage('t3_C.ppm')
end

mypictureC