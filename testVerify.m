clear all, close all;

startOxfordFace;

% Perform registration
faceA = faceService.faceDetect('testImages/detectTest.jpg', false, false, false, false);
faceB = faceService.faceDetect('testImages/verifyTest.jpg', false, false, false, false);

% Perform verification
[isIdentical, confidence] = faceService.faceVerify(faceA{1}, faceB{1});

if (isIdentical)
    disp('Faces are same person.');
else
    disp('Faces are not same person.');
end
disp(['Confidence: ', num2str(confidence)]);