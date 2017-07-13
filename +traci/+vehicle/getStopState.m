function vehStopStatestate = getStopState(vehID)
%getStopState Returns information in regard to stopping.
%   vehStopStatestate = getStopState(VEHID) Returns information in regard
%   to stopping: The returned integer is defined as 1 * stopped + 2 *
%   parking + 4 * personTriggered + 8 * containerTriggered + 16 * isBusStop
%   + 32 * isContainerStop with each of these flags defined as 0 or 1.

%   Copyright 2016 Universidad Nacional de Colombia,
%   Politecnico Jaime Isaza Cadavid.
%   Authors: Andres Acosta, Jairo Espinosa, Jorge Espinosa.
%   $Id: getStopState.m 37 2017-07-07 16:23:05Z afacostag $

import traci.constants
vehStopStatestate = traci.vehicle.getUniversal(constants.VAR_STOPSTATE, vehID);