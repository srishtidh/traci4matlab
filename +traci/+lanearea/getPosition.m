function position = getPosition(detID)
%getPosition Get the position of the detector.
%   position = getPosition(DETID) Returns the starting position of the
%   detector measured from the beginning of the lane in meters.

%   Copyright 2019 Universidad Nacional de Colombia,
%   Politecnico Jaime Isaza Cadavid.
%   Authors: Andres Acosta, Jairo Espinosa, Jorge Espinosa.
%   $Id$

import traci.constants
position = traci.lanearea.getUniversal(constants.VAR_POSITION, detID);