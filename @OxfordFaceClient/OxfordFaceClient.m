classdef OxfordFaceClient < handle
    properties (Access = private)
        API_KEY;  
    end
    
    properties (Constant)
        OXFORD_INSTANCE = 'https://api.projectoxford.ai/face/v0/detections'; 
    end
    
    methods (Access = public)
        function obj = OxfordFaceClient(userKey)
            obj.API_KEY = userKey;
        end       
    end
end

