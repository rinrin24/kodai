$printedAnagram = {}
def makeAnagram(name)
    names = [];
    cnt = 0
    name.chars do |c|
        names[cnt] = c;
        cnt += 1
    end
    makeAnagram2(names.length, names, []);
end
def makeAnagram2(n, name, outputArray)
    if(n == 0)
        if(!$printedAnagram[outputArray]) then; $printedAnagram[outputArray] = true; p(outputArray); return; end
    end
    name.each_index do |i|
        if(name[i] == nil) then; next; end
        if(outputArray.length >= 1)
            if(!isProper(outputArray[outputArray.length-1], name[i])) then; next; end;
        end
        if(n == 1)
            if(!isProperForLastWord(name[i])) then; next; end;
        end
        outputArray.push(name[i])
        name[i] = nil;
        makeAnagram2(n-1, name, outputArray)
        name[i] = outputArray.pop
    end
end
def isProper(alphabetBefore, alphabet)
    if(alphabet == 'h')
        if((alphabetBefore == 'c') | (alphabetBefore == 's')) then; return true; end;
    end
    if((alphabetBefore == 't') & (alphabet == 's')) then; return true; end
    if(alphabet == 'y')
        if((alphabetBefore == 'k') | (alphabetBefore == 's') | (alphabetBefore == 't') | (alphabetBefore == 'n') | (alphabetBefore == 'h') | (alphabetBefore == 'm') | (alphabetBefore == 'r')) then; return true; end;
        if((alphabetBefore == 'g') | (alphabetBefore == 'z') | (alphabetBefore == 'd') | (alphabetBefore == 'b') | (alphabetBefore == 'p')) then; return true; end;
    end
    if((alphabetBefore == 'n') & (alphabet == 'n')) then; return false; end;
    if((alphabetBefore == 'n') & (!isVowel(alphabet))) then; return true; end;
    if((!isVowel(alphabetBefore)) & (!isVowel(alphabet))) then; return false; end;
    return true
end
def isProperForLastWord(alphabet)
    if(alphabet == 'n') then; return true; end;
    if(isVowel(alphabet)) then; return true; end;
    return false
end
def isVowel(alphabet)
    if(alphabet == 'a') then; return true; end;
    if(alphabet == 'e') then; return true; end;
    if(alphabet == 'i') then; return true; end;
    if(alphabet == 'o') then; return true; end;
    if(alphabet == 'u') then; return true; end;
    return false;
end

makeAnagram("name")