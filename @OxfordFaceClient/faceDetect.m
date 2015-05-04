function faces = faceDetect(obj, image, landmarksFlag, ageFlag, genderFlag, poseFlag)
    % image files are read in as binary. Eventually we should also be able
    % to pass a URL rather than just a local file.
    body = util.readImFile(image);
    header = http_createHeader('Content-Type', 'application/octet-stream');
    params = {'analyzesFaceLandmarks', util.logical2str(landmarksFlag), ...
              'analyzesAge', util.logical2str(ageFlag), ...
              'analyzesGender', util.logical2str(genderFlag), ...
              'analyzesHeadPose', util.logical2str(poseFlag), ...
              'subscription-key', obj.API_KEY};
    urlToHit = [obj.OXFORD_INSTANCE '?' http_paramsToString(params)];
    [respOutput, respExtra] = urlread2(urlToHit, 'POST', body, header);
    faces = handleResponse(respOutput, respExtra);
end

% urlread2 has it's own error handling in situations where the request
% itself fails. This function handles the response from
% urlread2 assuming it has been succesful in that something has come back.
% These response codes are as per the documentation.

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