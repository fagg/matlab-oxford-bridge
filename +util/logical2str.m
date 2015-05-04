function str = logical2str(b)
    if (~islogical(b))
        error('Supplied value is not a boolean.');
    end
    if (b == true)
        str = 'true';
    elseif (b == false)
        str = 'false';
    end
end