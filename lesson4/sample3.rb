$val = []
$legacyMemory = []
$preArray = []
def e(x)
    $preArray = $val.dup
    $legacyMemory.push(x)
    $val.push(x); return $val
end
def add
    $preArray = $val.dup
    $legacyMemory.push("add")
    y = $val.pop; x = $val.pop; $val.push(x+y); return $val
end
def sub
    $preArray = $val.dup
    $legacyMemory.push("sub")
    y = $val.pop; x = $val.pop; $val.push(x-y); return $val
end
def mul
    $preArray = $val.dup
    $legacyMemory.push("mul")
    y = $val.pop; x = $val.pop; $val.push(x*y); return $val
end
def div
    $preArray = $val.dup
    $legacyMemory.push("div")
    y = $val.pop; x = $val.pop; $val.push(x/y); return $val
end
def mod
    $preArray = $val.dup
    $legacyMemory.push("mod")
    y = $val.pop; x = $val.pop; $val.push(x%y); return $val
end
def inv
    $preArray = $val.dup
    $legacyMemory.push("inv")
    x = $val.pop; $val.push(-x); return $val
end
def exch
    $preArray = $val.dup
    $legacyMemory.push("exch")
    x = $val.pop; y = $val.pop; $val.push(x); $val.push(y); return $val
end
def clear
    $preArray = $val.dup
    $legacyMemory.push("clear")
    $val = []; return $val
end
def show
    p($legacyMemory)
end
def cancel
    $legacyMemory.push("cancel")
    $val = $preArray.dup; return $val
end

p(e(8))
p(e(5))
p(e(3))
p(exch())
p(mul())
p(add())
p(clear())
p(cancel())
show()
p(e(8))
p(e(5))
p(exch())
p(sub())
p(e(3))
p(mul())