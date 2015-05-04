function im = readImFile(fileName)
    if (exist(char(fileName), 'file'))
        fd = fopen(char(fileName), 'r');
        im = fread(fd, inf, 'uchar=>uchar');
        fclose(fd);
    else
        error('Invalid image file.');
    end
end

