These are some MATLAB bindings I've written to work with Project Oxford
(http://www.projectoxford.ai - perhaps better known as how-old.net).

These are completely unofficial, so don't bother the Project Oxford people about them.

In order for this to work, you will need your own API key, which you place in
"startOxfordFace.m" as "FACE_API_KEY". You can find how to get your own API key
from the Project Oxford documentation.

This library relies upon:

- jsonlab (http://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab--a-toolbox-to-encode-decode-json-files-in-matlab-octave)
- urlread2 (http://www.mathworks.com/matlabcentral/fileexchange/35693-urlread2)

You will need to download and install these yourself, and make sure they are on path (see "startOxfordFace.m").

So far, I've implemented support for the basic face detection and registration ONLY.

Known bug:
- Landmarks aren't returned for some reason.

Patches and pull requests are welcome.

In the same spirit as outlined by the Project Oxford code of conduct, please
use these bindings only for good, not for evil.
