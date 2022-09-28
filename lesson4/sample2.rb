$x = 0
$pre = 0
$list = []
$preList = []
def sum(v)
    $pre = $x
    $list.push(v)
    $x += v; return $x
end
def reset
    $pre = $x
    $preList = $list.dup
    $x = 0
    $list.clear
    return
end
def dec(v)
    $pre = $x
    $list.push(v)
    $x -= v; return $x
end
def undo()
    $x = $pre
    $list = $preList.dup
    return
end

p(sum(10))
p(sum(20))
p(sum(-10))
reset()
undo()
p(sum(40))
p(dec(50))
p($list)