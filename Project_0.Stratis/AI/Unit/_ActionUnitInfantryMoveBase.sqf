#define OOP_ERROR
#define OOP_WARNING
#define OOP_INFO
#include "..\..\OOP_Light\OOP_Light.h"
#include "..\..\Message\Message.hpp"
#include "..\Action\Action.hpp"
#include "..\..\MessageTypes.hpp"
#include "..\..\GlobalAssert.hpp"
#include "..\Stimulus\Stimulus.hpp"
#include "..\WorldFact\WorldFact.hpp"
#include "..\stimulusTypes.hpp"
#include "..\worldFactTypes.hpp"

/*
Class: ActionUnit.ActionUnitInfantryMoveBase
Base action for movement. Has only activate, terminate, process implemented.
*/

#define pr private

#define TOLERANCE 1.0

CLASS("ActionUnitInfantryMoveBase", "ActionUnit")
	
	VARIABLE("pos");
	VARIABLE("ETA");
	
	// ------------ N E W ------------
	/*
	METHOD("new") {
		params [["_thisObject", "", [""]], ["_AI", "", [""]], ["_parameters", [], [[]]] ];
		
	} ENDMETHOD;
	*/
	
	// logic to run when the goal is activated
	METHOD("activate") {
		params [["_to", "", [""]]];		
		
		pr _hO = T_GETV("hO");
		pr _pos = T_GETV("pos");
		_hO doMove _pos;
		
		// Set ETA
		// Use manhattan distance
		pr _posStart = ASLTOAGL (getPosASL _hO);
		pr _dist = (abs ((_pos select 0) - (_posStart select 0)) ) + (abs ((_pos select 1) - (_posStart select 1))) + (abs ((_pos select 2) - (_posStart select 2)));
		pr _ETA = time + (_dist/1.4 + 40);
		T_SETV("ETA", _ETA);
		
		// Set state
		SETV(_thisObject, "state", ACTION_STATE_ACTIVE);
		
		// Return ACTIVE state
		ACTION_STATE_ACTIVE
		
	} ENDMETHOD;
	
	// logic to run each update-step
	METHOD("process") {
		params [["_thisObject", "", [""]]];
		
		pr _state = CALLM(_thisObject, "activateIfInactive", []);
		
		if (_state == ACTION_STATE_ACTIVE) then {
		
			// Check if we have arrived
			pr _hO = T_GETV("hO");
			pr _pos = T_GETV("pos");
			
			if ((_hO distance _pos) < TOLERANCE) then {
				OOP_INFO_1("MOVE COMPLETED for infantry: %1", _thisObject);
			
				doStop _hO;
				
				T_SETV("state", ACTION_STATE_COMPLETED);
				ACTION_STATE_COMPLETED
			} else {
				// Check ETA
				pr _ETA = T_GETV("ETA");
				if (time > _ETA) then {
					OOP_INFO_2("MOVE FAILED for infantry unit: %1, position: %2", _thisObject, _pos);
				
					// Should we teleport him or someone will blame AI for cheating??
					_ho setPos _pos;
					doStop _hO;
					
					ACTION_STATE_ACTIVE
				} else {
					ACTION_STATE_ACTIVE
				};
			};
			
		};
	} ENDMETHOD;
	
	// logic to run when the action is satisfied
	METHOD("terminate") {
		params [["_thisObject", "", [""]]];
	} ENDMETHOD;

ENDCLASS;