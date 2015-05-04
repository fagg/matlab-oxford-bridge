function h = drawBoundBox(boxProps)
    h  = rectangle('Position', [boxProps.left boxProps.top, ...
                           boxProps.width boxProps.height]);
end