function ret = isURL(s)
    ret = ~isempty(regexpi(s, '^(h|f)tt?ps?://'));
end

