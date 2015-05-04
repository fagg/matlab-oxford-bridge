%% USER CONFIGURATION
FACE_API_KEY = 'YOUR API KEY GOES HERE';
URLREAD2_PATH = 'urlread2';
JSONLAB_PATH = 'jsonlab';

%% Path configuration
addpath(URLREAD2_PATH);
addpath(JSONLAB_PATH);

%% Configure a client instance
faceService = OxfordFaceClient(FACE_API_KEY);