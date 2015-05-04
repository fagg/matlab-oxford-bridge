% faceVerify - verifies if two registered faces are of the same person via
% Project Oxford. Registration with .faceDetect() must be performed first.
%
% Inputs:
%           face1 and face2 are face data structures, as returned from
%           .faceDetect()
%
% Outputs:
%           isIdentical -> flag indicating whether faces belong to same
%           person.
%
%           confidence -> confidence score.

function [isIdentical, confidence] = faceVerify(obj, face1, face2)
    params = {'subscription-key', obj.API_KEY};
    body = savejson([], struct('faceId1', face1.faceId, 'faceId2', face2.faceId));
    header = http_createHeader('Content-Type', 'application/json');
    urlToHit = [obj.OXFORD_INSTANCE '/verifications?' http_paramsToString(params)];
    [respOutput, respExtra] = urlread2(urlToHit, 'POST', body, header);
    [isIdentical, confidence] = handleResponse(respOutput, respExtra);
end

function [isIdentical, confidence] = handleResponse(output, extra)
    if (extra.status.value == 200)
        rData = loadjson(output);
        isIdentical = rData.isIdentical;
        confidence = rData.confidence;
    elseif (extra.status.value == 400)
        errData = loadjson(output);
        if (strcmp(errData.code, 'FaceNotFound'))
            error(errData.message);
        elseif (strcmp(errData.code, 'BadArgument'))
            error(errData.message);
        end
    elseif (extra.status.value == 401)
        error('Invalid API key, apparently.');
    elseif (extra.status.value == 403)
        error('Call volume quota exceeded.');
    elseif (extra.status.value == 429)
        error('Rate limit exceeded. Try again soon.');
    else
        error('Something has gone terribly wrong.');
    end
end