clear all, close all;

startOxfordFace;
faces = faceService.faceDetect('testImages/detectTest.jpg', true, true, true, true);


f = figure(1);
imshow(imread('testImages/detectTest.jpg')), hold on;

% Draw the bounding box
rect = util.drawBoundBox(faces{1}.faceRectangle);
set(rect, 'EdgeColor', 'red');

% Plot the registration landmarks
%util.landmarkPlot(faces{1}.faceLandmarks);

set(f, 'Name', ['ID: ', faces{1}.faceId, ', Gender: ', faces{1}.attributes.gender, ...
                ', Age: ', num2str(faces{1}.attributes.age)]);