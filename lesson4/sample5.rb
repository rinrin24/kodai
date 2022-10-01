def kaijo number
    if(number == 1) then; return 1; end
    return number * kaijo(number - 1)
end
def fibonacci number
    if(number == 0) then; return 0; end
    if(number == 1) then; return 1; end
    return fibonacci(number - 1) + fibonacci(number - 2)
end
def combination n, r
    if(r == 0) then return 1; end
    if(r == n) then return 1; end
    return combination(n - 1, r) + combination(n - 1, r - 1);
end
def binary number
    if(number == 0) then; return "0"; end
    if(number == 1) then; return "1"; end
    if((number % 2) == 0) then; return binary(number / 2) + "0"; end
    return binary(number / 2) + "1"
end
p(kaijo(5))
p(fibonacci(22))
p(combination(5, 2))
p(binary(334))