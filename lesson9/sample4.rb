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
	def +(newComplexNumber)
		if(newComplexNumber.instance_of?(Integer))
			newRealNumber = newComplexNumber + @realNumber;
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(Float))
			newRealNumber = newComplexNumber + @realNumber;
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(ComplexNumber))
			newRealNumber = newComplexNumber.realNumber + @realNumber;
			newImaginaryNumber = newComplexNumber.imaginaryNumber + @imaginaryNumber;
			return ComplexNumber.new(newRealNumber, newImaginaryNumber);
		end;
	end;
	def -(newComplexNumber)
		if(newComplexNumber.instance_of?(Integer))
			newRealNumber = -newComplexNumber + @realNumber;
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(Float))
			newRealNumber = -newComplexNumber + @realNumber;
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(ComplexNumber))
			newRealNumber = -newComplexNumber.realNumber + @realNumber;
			newImaginaryNumber = -newComplexNumber.imaginaryNumber + @imaginaryNumber;
			return ComplexNumber.new(newRealNumber, newImaginaryNumber);
		end;
	end;
	def *(newComplexNumber)
		if(newComplexNumber.instance_of?(Integer))
			newRealNumber = newComplexNumber + @realNumber;
			newImaginaryNumber = newComplexNumber * @imaginaryNumber
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(Float))
			newRealNumber = newComplexNumber * @realNumber;
			newImaginaryNumber = newComplexNumber * @imaginaryNumber
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(ComplexNumber))
			newRealNumber = newComplexNumber.realNumber * @realNumber - newComplexNumber.imaginaryNumber * @imaginaryNumber;
			newImaginaryNumber = newComplexNumber.realNumber * @imaginaryNumber + newComplexNumber.imaginaryNumber * @realNumber;
			return ComplexNumber.new(newRealNumber, newImaginaryNumber);
		end;
	end;
	def /(newComplexNumber)
		if(newComplexNumber.instance_of?(Integer))
			newRealNumber = 1.0 * @realNumber / newComplexNumber;
			newImaginaryNumber = 1.0 * @imaginaryNumber / newComplexNumber;
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(Float))
			newRealNumber = 1.0 * @realNumber / newComplexNumber;
			newImaginaryNumber = 1.0 * @imaginaryNumber / newComplexNumber;
			return ComplexNumber.new(newRealNumber, @imaginaryNumber);
		end;
		if(newComplexNumber.instance_of?(ComplexNumber))
			bunbo = newComplexNumber.realNumber**2 - newComplexNumber.imaginaryNumber**2
			bunshi = self * ComplexNumber.new(newComplexNumber.realNumber, -newComplexNumber.imaginaryNumber)
			newRealNumber = 1.0 * bunshi.realNumber / bunbo
			newImaginaryNumber = 1.0 * bunshi.imaginaryNumber / bunbo
			return ComplexNumber.new(newRealNumber, newImaginaryNumber);
		end;
	end;
end;

complexNumber = ComplexNumber.new(10, 5);
p(complexNumber)
p(complexNumber.realNumber)
p(complexNumber.imaginaryNumber)
otherComplexNumber = ComplexNumber.new(20, 10);
complexNumber = complexNumber + 5
p(complexNumber)
complexNumber = complexNumber + 5.5
p(complexNumber)
complexNumber = complexNumber + otherComplexNumber
p(complexNumber)