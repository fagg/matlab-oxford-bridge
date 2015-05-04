function landmarkPlot(landmarks)
    faceFeatures = fieldnames(landmarks);
    lmX = []; lmY = [];
    for i = 1:length(faceFeatures)
        lm = getfield(landmarks, faceFeatures{i});
        lmX(end+1) = lm.x;
        lmY(end+1) = lm.y;
    end
    plot(lmX, lmY, 'rx');
end

