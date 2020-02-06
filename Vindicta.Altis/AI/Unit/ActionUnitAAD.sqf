#include "common.hpp"

/*
Author: Marvis 06.02.2020
*/

#define pr private

CLASS("ActionUnitAAD", "ActionUnit")
	
	// ------------ N E W ------------
	
	// logic to run when the goal is activated
	METHOD("activate") {
		params [["_thisObject", "", [""]]];
		
		// Handle AI just spawned state
		pr _AI = T_GETV("AI");
		if (GETV(_AI, "new")) then {
			SETV(_AI, "new", false);
		};
		
		T_SETV("state", ACTION_STATE_COMPLETED);
		ACTION_STATE_COMPLETED
	} ENDMETHOD;
	
	// logic to run each update-step
	METHOD("process") {
		params [["_thisObject", "", [""]]];
		
		pr _state = CALLM0(_thisObject, "activateIfInactive");

		T_SETV("state", _state);
		_state
	} ENDMETHOD;
	
	// logic to run when the goal is about to be terminated
	/*
	METHOD("terminate") {
		params [["_thisObject", "", [""]]];
		
	} ENDMETHOD; 
	*/

ENDCLASS;