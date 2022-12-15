class ComplexNumber
	def initialize(newRealNumber, newImaginaryNumber)
		@realNumber = newRealNumber;
		@imaginaryNumber = newImaginaryNumber;
	end;
	def realNumber
		return @realNumber;
	end;
	def imaginaryNumber
		return @imaginaryNumber;
	end;
	def +(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		newRealNumber = newComplexNumber.realNumber + @realNumber;
		newImaginaryNumber = newComplexNumber.imaginaryNumber + @imaginaryNumber;
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def -(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		newRealNumber = -newComplexNumber.realNumber + @realNumber;
		newImaginaryNumber = -newComplexNumber.imaginaryNumber + @imaginaryNumber;
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def *(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		newRealNumber = newComplexNumber.realNumber * @realNumber - newComplexNumber.imaginaryNumber * @imaginaryNumber;
		newImaginaryNumber = newComplexNumber.realNumber * @imaginaryNumber + newComplexNumber.imaginaryNumber * @realNumber;
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def /(newNumber)
		newComplexNumber = to_complexNumber(newNumber);
		bunbo = newComplexNumber.realNumber**2 - newComplexNumber.imaginaryNumber**2
		bunshi = self * ComplexNumber.new(newComplexNumber.realNumber, -newComplexNumber.imaginaryNumber)
		newRealNumber = 1.0 * bunshi.realNumber / bunbo
		newImaginaryNumber = 1.0 * bunshi.imaginaryNumber / bunbo
		return ComplexNumber.new(newRealNumber, newImaginaryNumber);
	end;
	def **(power)
		outputNumber = self;
		(power-1).times do
			outputNumber = outputNumber * self;
		end
		return outputNumber;
	end;
	def inspect()
		if(@imaginaryNumber == 0) then; return @realNumber; end;
		if(@realNumber == 0) then; return @imaginaryNumber.to_s + " * i"; end;
		return @realNumber.to_s + " + " + @imaginaryNumber.to_s + " * i"
	end
	private
	def to_complexNumber(newNumber)
		if(newNumber.instance_of?(ComplexNumber)) then; return newNumber; end;
		return ComplexNumber.new(newNumber, 0);
	end;
end;

complexNumber = ComplexNumber.new(10, 5);
p(complexNumber);
p(complexNumber.realNumber);
p(complexNumber.imaginaryNumber);
otherComplexNumber = ComplexNumber.new(20, 10);
complexNumber = complexNumber + 5;
p(complexNumber);
complexNumber = complexNumber + 5.5;
p(complexNumber);
complexNumber = complexNumber + otherComplexNumber;
p(complexNumber);
complexNumber = complexNumber - 10;
p(complexNumber);
complexNumber = complexNumber - 5.5;
p(complexNumber);
complexNumber = complexNumber - otherComplexNumber;
p(complexNumber);
complexNumber = complexNumber * 2
p(complexNumber);
complexNumber = complexNumber * 1.25
p(complexNumber);
complexNumber = complexNumber * otherComplexNumber;
p(complexNumber);
complexNumber = complexNumber / 2;
p(complexNumber);
complexNumber = complexNumber / 2.5;
p(complexNumber);
complexNumber = complexNumber / otherComplexNumber;
p(complexNumber);
complexNumber = ComplexNumber.new(10, 10);
p(complexNumber);
complexNumber = complexNumber**3;
p(complexNumber);
