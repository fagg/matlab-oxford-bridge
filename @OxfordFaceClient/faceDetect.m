% faceDetect - Call basic face detection and registration from Project
% Oxford.
%
% Input: 
%       image -> path to image (local or URL to remote image)
%
% The following are flags which turn on requests for various information
% about the face. If all are false, only the bounding box info is returned.
%       landmarksFlag -> return full landmark registration
%       ageFlag -> return estimated age
%       genderFlag -> return estimated gender
%       poseFlag -> return head pose information
%
% Output:
%       faces -> cell array containing structures with metadata for each
%       face.

function faces = faceDetect(obj, image, landmarksFlag, ageFlag, genderFlag, poseFlag)
    if (ischar(image))
        if (util.isURL(image))
            % if we're pointing to a remote image, send as JSON
            body = savejson([], struct('url', image));
            header = http_createHeader('Content-Type', 'application/json');
        else
            % if we're pointing to a local file, we can't use imread(). API
            % specifies that we need to send the image as a binary blob.
            body = util.readImFile(image);
            header = http_createHeader('Content-Type', 'application/octet-stream');
        end
    else
        error('image should be a file path or URL.');
    end
    
    params = {'analyzesFacialLandmarks', util.logical2str(landmarksFlag), ...
              'analyzesAge', util.logical2str(ageFlag), ...
              'analyzesGender', util.logical2str(genderFlag), ...
              'analyzesHeadPose', util.logical2str(poseFlag), ...
              'subscription-key', obj.API_KEY};
    urlToHit = [obj.OXFORD_INSTANCE '/detections?' http_paramsToString(params)];
    [respOutput, respExtra] = urlread2(urlToHit, 'POST', body, header);
    faces = handleResponse(respOutput, respExtra);
end

function faces = handleResponse(resp, extra)
    if (extra.status.value == 200)
        faces = buildFacesFromResponse(resp);
    elseif (extra.status.value == 401)
        error('Invalid API key, apparently.');
    elseif (extra.status.value == 429)
        error('Rate limit exceeded. Try again soon.');
    elseif (extra.status.value == 403)
        error('Call volume quota exceeded.');
    elseif (extra.status.value == 415)
        error('Invalid or corrupted file.');
    elseif (extra.status.value == 408)
        error('Response timeout.');
    elseif (extra.status.value == 400)
        error('Image is either unsupported, too big, too small or JSON cannot be parsed.');
    else
        error('Something has gone terribly wrong.');
    end
end

function faces = buildFacesFromResponse(responseJSON)
    faces = loadjson(responseJSON);
end