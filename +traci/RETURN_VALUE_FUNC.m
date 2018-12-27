classdef RETURN_VALUE_FUNC
    %RETURN_VALUE_FUNC A class to store the functions to read the TraCI
    %results for each SUMO object.
    
    %   Copyright 2019 Universidad Nacional de Colombia,
    %   Politecnico Jaime Isaza Cadavid.
    %   Authors: Andres Acosta, Jairo Espinosa, Jorge Espinosa.
	%   $Id: RETURN_VALUE_FUNC.m 49 2018-12-27 14:08:44Z afacostag $

    properties (Constant)
        edge = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.ID_COUNT,...
            traci.constants.VAR_EDGE_TRAVELTIME,...
            traci.constants.VAR_WAITING_TIME,...
            traci.constants.VAR_EDGE_EFFORT,...
            traci.constants.VAR_CO2EMISSION,...
            traci.constants.VAR_COEMISSION,...
            traci.constants.VAR_HCEMISSION,...
            traci.constants.VAR_PMXEMISSION,...
            traci.constants.VAR_NOXEMISSION,...
            traci.constants.VAR_FUELCONSUMPTION,...
            traci.constants.VAR_NOISEEMISSION,...
            traci.constants.VAR_ELECTRICITYCONSUMPTION,...
            traci.constants.LAST_STEP_MEAN_SPEED,...
            traci.constants.LAST_STEP_OCCUPANCY,...
            traci.constants.LAST_STEP_LENGTH,...
            traci.constants.VAR_LANE_INDEX,...
            traci.constants.VAR_NAME,...
            traci.constants.VAR_CURRENT_TRAVELTIME,...
            traci.constants.LAST_STEP_VEHICLE_NUMBER,...
            traci.constants.LAST_STEP_VEHICLE_HALTING_NUMBER,...
            traci.constants.LAST_STEP_VEHICLE_ID_LIST,...
            traci.constants.LAST_STEP_PERSON_ID_LIST},...
            {'readStringList','readInt','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readDouble',...
            'readDouble','readInt','readString','readDouble','readInt','readInt','readStringList','readStringList'});
        gui = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.VAR_VIEW_ZOOM,...
            traci.constants.VAR_VIEW_OFFSET,...
            traci.constants.VAR_VIEW_SCHEMA,...
            traci.constants.VAR_VIEW_BOUNDARY,...
            traci.constants.VAR_HAS_VIEW},...
            {'readStringList','readDouble','@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8))],''double'')',...
            'readString','readShape', '@(result) typecast(fliplr(result.read(4)), ''int32'')'});
        inductionloop = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.VAR_POSITION,...
            traci.constants.VAR_LANE_ID,...
            traci.constants.LAST_STEP_VEHICLE_NUMBER,...
            traci.constants.LAST_STEP_MEAN_SPEED,...
            traci.constants.LAST_STEP_VEHICLE_ID_LIST,...
            traci.constants.LAST_STEP_OCCUPANCY,...
            traci.constants.LAST_STEP_LENGTH,...
            traci.constants.LAST_STEP_TIME_SINCE_DETECTION,...
            traci.constants.LAST_STEP_VEHICLE_DATA},...
            {'readStringList','readDouble','readString',...
            'readInt','readDouble','readStringList',...
            'readDouble','readDouble','readDouble',...
            'traci.inductionloop.readVehicleData'});
        junction = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.VAR_POSITION,...
            traci.constants.VAR_SHAPE},...
            {'readStringList','@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8))],''double'')',...
            'readShape'});
        lane = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.ID_COUNT,...
            traci.constants.VAR_LENGTH,...
            traci.constants.VAR_MAXSPEED,...
            traci.constants.VAR_WIDTH,...
            traci.constants.LANE_ALLOWED,...
            traci.constants.LANE_DISALLOWED,...
            traci.constants.LANE_LINK_NUMBER,...
            traci.constants.LANE_LINKS,...
            traci.constants.VAR_SHAPE,...
            traci.constants.LANE_EDGE_ID,...
            traci.constants.VAR_CO2EMISSION,...
            traci.constants.VAR_COEMISSION,...
            traci.constants.VAR_HCEMISSION,...
            traci.constants.VAR_PMXEMISSION,...
            traci.constants.VAR_NOXEMISSION,...
            traci.constants.VAR_FUELCONSUMPTION,...
            traci.constants.VAR_NOISEEMISSION,...
            traci.constants.VAR_ELECTRICITYCONSUMPTION,...
            traci.constants.LAST_STEP_MEAN_SPEED,...
            traci.constants.LAST_STEP_OCCUPANCY,...
            traci.constants.LAST_STEP_LENGTH,...
            traci.constants.VAR_WAITING_TIME,...
            traci.constants.VAR_CURRENT_TRAVELTIME,...
            traci.constants.LAST_STEP_VEHICLE_NUMBER,...
            traci.constants.LAST_STEP_VEHICLE_HALTING_NUMBER,...
            traci.constants.VAR_FOES,...
            traci.constants.LAST_STEP_VEHICLE_ID_LIST},...
            {'readStringList','readInt','readDouble','readDouble','readDouble',...
            'readStringList','readStringList','@(result) result.read(1)',...
            'traci.lane.readLinks','readShape','readString','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readInt','readInt','readStringList',...
            'readStringList'});
        lanearea = containers.Map({...
			traci.constants.ID_LIST...
			traci.constants.ID_COUNT,...
			traci.constants.JAM_LENGTH_VEHICLE,...
            traci.constants.JAM_LENGTH_METERS,...
			traci.constants.LAST_STEP_MEAN_SPEED,...
            traci.constants.VAR_POSITION,...
            traci.constants.VAR_LENGTH,...
            traci.constants.VAR_LANE_ID,...
            traci.constants.LAST_STEP_VEHICLE_ID_LIST,...
            traci.constants.LAST_STEP_VEHICLE_NUMBER,...
			traci.constants.LAST_STEP_OCCUPANCY,...
            traci.constants.LAST_STEP_VEHICLE_HALTING_NUMBER},...
			{'readStringList','readInt','readInt','readDouble',...
            'readDouble','readDouble','readDouble','readString',...
            'readStringList','readInt','readDouble','readInt'});
        multientryexit = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.LAST_STEP_VEHICLE_NUMBER,...
            traci.constants.LAST_STEP_MEAN_SPEED,...
            traci.constants.LAST_STEP_VEHICLE_ID_LIST,...
            traci.constants.LAST_STEP_VEHICLE_HALTING_NUMBER},...
            {'readStringList','readInt','readDouble','readStringList','readInt'});
        person = containers.Map({traci.constants.ID_LIST,...
            traci.constants.ID_COUNT,...
            traci.constants.VAR_SPEED,...
            traci.constants.VAR_POSITION,...
            traci.constants.VAR_ANGLE,...
            traci.constants.VAR_ROAD_ID,...
            traci.constants.VAR_TYPE,...
            traci.constants.VAR_ROUTE_ID,...
            traci.constants.VAR_COLOR,...
            traci.constants.VAR_LANEPOSITION,...
            traci.constants.VAR_LENGTH,...
            traci.constants.VAR_WAITING_TIME,...
            traci.constants.VAR_WIDTH,...
            traci.constants.VAR_MINGAP,...
            traci.constants.VAR_NEXT_EDGE},...
            {'readStringList','readInt','readDouble',...
            '@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8))],''double'')',...
            'readDouble','readString','readString','readString',...
            '@(result) result.read(4)','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readString'});           
        poi = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.VAR_TYPE,...
            traci.constants.VAR_POSITION,...
            traci.constants.VAR_COLOR},...
            {'readStringList','readString','@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8))],''double'')',...
            '@(result) result.read(4)'});
        polygon = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.VAR_TYPE,...
            traci.constants.VAR_SHAPE,...
            traci.constants.VAR_FILL,...
            traci.constants.VAR_WIDTH,...
            traci.constants.VAR_COLOR},...
            {'readStringList','readString','readShape','readInt',...
            'readDouble','@(result) result.read(4)'});
        route = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.VAR_EDGES},...
            {'readStringList','readStringList'});
        simulation = containers.Map({...
            traci.constants.VAR_TIME_STEP,...
            traci.constants.VAR_LOADED_VEHICLES_NUMBER,...
            traci.constants.VAR_LOADED_VEHICLES_IDS,...
            traci.constants.VAR_DEPARTED_VEHICLES_NUMBER,...
            traci.constants.VAR_DEPARTED_VEHICLES_IDS,...
            traci.constants.VAR_ARRIVED_VEHICLES_NUMBER,...
            traci.constants.VAR_ARRIVED_VEHICLES_IDS,...
            traci.constants.VAR_MIN_EXPECTED_VEHICLES,...
            traci.constants.VAR_TELEPORT_STARTING_VEHICLES_NUMBER,...
            traci.constants.VAR_TELEPORT_STARTING_VEHICLES_IDS,...
            traci.constants.VAR_TELEPORT_ENDING_VEHICLES_NUMBER,...
            traci.constants.VAR_TELEPORT_ENDING_VEHICLES_IDS,...
            traci.constants.VAR_DELTA_T,...
            traci.constants.VAR_NET_BOUNDING_BOX},...
            {'readInt','readInt','readStringList','readInt',...
            'readStringList','readInt','readStringList','readInt',...
            'readInt','readStringList','readInt','readStringList',...
            'readInt','@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8)) fliplr(result.read(8)) fliplr(result.read(8))],''double'')'});
        trafficlights = containers.Map({...
            traci.constants.ID_LIST,...
            traci.constants.TL_RED_YELLOW_GREEN_STATE,...
            traci.constants.TL_COMPLETE_DEFINITION_RYG,...
            traci.constants.TL_CONTROLLED_LANES,...
            traci.constants.TL_CONTROLLED_LINKS,...
            traci.constants.TL_CURRENT_PROGRAM,...
            traci.constants.TL_CURRENT_PHASE,...
            traci.constants.TL_NEXT_SWITCH,...
            traci.constants.TL_PHASE_DURATION},...
            {'readStringList','readString','traci.trafficlights.readLogics',...
            'readStringList','traci.trafficlights.readLinks','readString',...
            'readInt','readInt','readInt'});
        vehicle = containers.Map({...
            traci.constants.ID_LIST,...
			traci.constants.ID_COUNT,...
			traci.constants.VAR_SPEED,...
            traci.constants.VAR_SPEED_WITHOUT_TRACI,...
            traci.constants.VAR_POSITION,...
            traci.constants.VAR_POSITION3D,...
            traci.constants.VAR_ANGLE,...
            traci.constants.VAR_ROAD_ID,...
            traci.constants.VAR_LANE_ID,...
            traci.constants.VAR_LANE_INDEX,...
            traci.constants.VAR_TYPE,...
            traci.constants.VAR_ROUTE_ID,...
            traci.constants.VAR_ROUTE_INDEX,...
            traci.constants.VAR_COLOR,...
            traci.constants.VAR_LANEPOSITION,...
            traci.constants.VAR_CO2EMISSION,...
            traci.constants.VAR_COEMISSION,...
            traci.constants.VAR_HCEMISSION,...
            traci.constants.VAR_PMXEMISSION,...
            traci.constants.VAR_NOXEMISSION,...
            traci.constants.VAR_FUELCONSUMPTION,...
            traci.constants.VAR_NOISEEMISSION,...
            traci.constants.VAR_ELECTRICITYCONSUMPTION,...
            traci.constants.VAR_PERSON_NUMBER,...
            traci.constants.VAR_EDGE_TRAVELTIME,...
            traci.constants.VAR_EDGE_EFFORT,...
            traci.constants.VAR_ROUTE_VALID,...
            traci.constants.VAR_EDGES,...
            traci.constants.VAR_SIGNALS,...
            traci.constants.VAR_LENGTH,...
            traci.constants.VAR_MAXSPEED,...
			traci.constants.VAR_ALLOWED_SPEED,...
            traci.constants.VAR_VEHICLECLASS,...
            traci.constants.VAR_SPEED_FACTOR,...
            traci.constants.VAR_SPEED_DEVIATION,...
            traci.constants.VAR_EMISSIONCLASS,...
			traci.constants.VAR_WAITING_TIME,...
            traci.constants.VAR_ACCUMULATED_WAITING_TIME,...
            traci.constants.VAR_SPEEDSETMODE,...
            traci.constants.VAR_SLOPE,...
            traci.constants.VAR_WIDTH,...
            traci.constants.VAR_HEIGHT,...
            traci.constants.VAR_LINE,...
            traci.constants.VAR_VIA,...
            traci.constants.VAR_MINGAP,...
            traci.constants.VAR_SHAPECLASS,...
            traci.constants.VAR_ACCEL,...
            traci.constants.VAR_DECEL,...
            traci.constants.VAR_EMERGENCY_DECEL,...
            traci.constants.VAR_APPARENT_DECEL,...
            traci.constants.VAR_IMPERFECTION,...
            traci.constants.VAR_TAU,...
            traci.constants.VAR_BEST_LANES,...
			traci.constants.VAR_LEADER,...
            traci.constants.VAR_NEXT_TLS,...
            traci.constants.VAR_LANEPOSITION_LAT,...
            traci.constants.VAR_MAXSPEED_LAT,...
            traci.constants.VAR_MINGAP_LAT,...
            traci.constants.VAR_LATALIGNMENT,...
            traci.constants.DISTANCE_REQUEST,...
			traci.constants.VAR_STOPSTATE,...
            traci.constants.VAR_DISTANCE},...
            {'readStringList','readInt','readDouble','readDouble','@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8))],''double'')',...
            '@(result) typecast([fliplr(result.read(8)) fliplr(result.read(8)) fliplr(result.read(8))],''double'')',...
            'readDouble','readString','readString','readInt','readString',...
            'readString','readInt','@(result) result.read(4)','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readDouble',...
            'readDouble','readInt','readDouble','readDouble','@(result) result.read(1)','readStringList',...
            'readInt','readDouble','readDouble','readDouble','readString','readDouble','readDouble',...
            'readString','readDouble','readDouble','readInt','readDouble','readDouble','readDouble','readString',...
            'readStringList','readDouble','readString','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readDouble',...
            'traci.vehicle.readBestLanes','traci.vehicle.readLeader',...
			'traci.vehicle.readNextTLS','readDouble','readDouble','readDouble',...
            'readString','readDouble','@(result) result.read(1)','readDouble'});
        vehicletype = containers.Map({...
            traci.constants.ID_LIST,...
			traci.constants.ID_COUNT,...
            traci.constants.VAR_LENGTH,...
            traci.constants.VAR_MAXSPEED,...
            traci.constants.VAR_SPEED_FACTOR,...
            traci.constants.VAR_SPEED_DEVIATION,...
            traci.constants.VAR_ACCEL,...
            traci.constants.VAR_DECEL,...
            traci.constants.VAR_IMPERFECTION,...
            traci.constants.VAR_TAU,...
            traci.constants.VAR_VEHICLECLASS,...
            traci.constants.VAR_EMISSIONCLASS,...
            traci.constants.VAR_SHAPECLASS,...
            traci.constants.VAR_MINGAP,...
            traci.constants.VAR_WIDTH,...
            traci.constants.VAR_COLOR},...
            {'readStringList','readInt','readDouble','readDouble','readDouble','readDouble',...
            'readDouble','readDouble','readDouble','readDouble','readString',...
            'readString','readString','readDouble','readDouble','@(result) result.read(4)'});
    end    
end