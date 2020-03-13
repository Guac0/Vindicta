#include "defineCommon.inc"


params ["_namespace","_jump_to_new",["_event_node",false]];

//used when a node is called by an event.
_namespace setVariable ["_event_node",_event_node];

private _dataSets = _namespace getVariable ["_dataSets",[]];
private _unit_1 = _namespace getVariable ["_unit_1",objNull];
private _unit_2 = _namespace getVariable ["_unit_2",objNull];
private _conversation_args = _namespace getVariable ["_conversation_args",[]];
private _events = _namespace getVariable ["_events",[]];

//this array countains the new node_id, and the script and args from the previouse answer/jump_to action
_jump_to_new params [["_node_id","",[""]],["_previous_script",{},[{}]],["_previous_arg",[]]];

//run code from previouse node
_previous_arg call _previous_script;

diag_log str ["main",_node_id];
if(_node_id isEqualTo "#end")exitWith{
	_namespace call pr0_fnc_dialogue_mainLoop_end;
};

if(_node_id isEqualTo "")exitWith{
	[_namespace,"no node_id given"] call pr0_fnc_dialogue_mainLoop_error;
};

//-----------------------------------------------------------
//				Find all nodes with same id					|
//-----------------------------------------------------------



//find all nodes with given node_id
private _noded_arrays = [];
{	
	private _dataSet = _x;
	{

		_x params [["_node_id_x","",[""]],["_node_type",TYPE_CREATE,[TYPE_CREATE,{}]],["_script",{},[{}]]];

		if (tolower _node_id_x isEqualTo tolower _node_id)exitWith{

			if(_node_type isEqualType {})then{
				_script = _node_type;
				_node_type = TYPE_CREATE;
			};

			private _node_array = [_unit_1, _unit_2, _conversation_args] call _script;
			if(isNil "_node_array" || {!(_node_array isEqualType [])})exitWith{
				[_namespace,"node didnt return array"] call pr0_fnc_dialogue_mainLoop_error;
			};
			_noded_arrays pushBack [_node_type, _node_array];
		};
	}forEach _dataSet;
}forEach _dataSets;

if(count _noded_arrays == 0)exitWith{
	[_namespace,"node is empty"] call pr0_fnc_dialogue_mainLoop_error;
};

//we can skip if it if it will be overwriten
private _overwrite_found = 0;
{
	_x params ["_node_type"];
	if(_node_type in [TYPE_OVERWRITE,TYPE_CREATE])then{
		if(_node_type == TYPE_OVERWRITE && _forEachIndex == 0)then{
			[_namespace,"node type is TYPE_OVERWRITE but nothing was overwriten"] call pr0_fnc_dialogue_mainLoop_error;
		};
		_overwrite_found = _forEachIndex;
	};
}forEach _noded_arrays;

//-----------------------------------------------------------
//				Format conversation into arrays				|
//-----------------------------------------------------------

private _sentences = [];
private _question = [];
private _answers = [];
private _answer_ai = ["#end",{},[]];
private _jump_to = ["#end",{},[]];
private _events = [];	{_events set [_x, [{},[]]];}forEach EVENT_TYPES;

//loop the nodes
for "_i" from _overwrite_found to count _noded_arrays -1 do{
	(_noded_arrays#_i) params ["_node_type","_node_array"];
	
	//loop the node and fill the arrays defined above
	{
		_x params [["_type",-1,[0]]];
		_x deleteAt 0;//remove _type because we declared it above and we dont need it in the array

		if(_node_type == TYPE_INHERIT && !(_type in INHERIT_TYPES))exitWith{
			[_namespace, format["inheritence not supported for node_type: %1" ,_node_type]] call pr0_fnc_dialogue_mainLoop_error;
		};

		private _silence = _type == TYPE_SENTENCE_SILENECE;

		switch (_type) do {
			case TYPE_SENTENCE;
			case TYPE_SENTENCE_SILENECE;
			case TYPE_QUESTION;
			case TYPE_QUESTION_SILENECE:{
				_x params [
					["_text","",["",[]]], 
					["_int_speaker",0,[0]],
					["_loudness",1,[0]],
					["_script",{},[{}]],
					["_args",[]]
				];
				

				if!(_int_speaker in [1,2])exitWith{
					[_namespace,"wrong speaker nr given"] call pr0_fnc_dialogue_mainLoop_error;
				};

				private _speaker = [_unit_1, _unit_2] select (_int_speaker-1);
				private _listener = [_unit_2, _unit_1] select (_int_speaker-1);

				
				if(_text isEqualType [])then{_text = selectRandom _text};
				
				if(_type in [TYPE_SENTENCE_SILENECE,TYPE_SENTENCE])then{
					_sentences pushBack [_text,_silence,_speaker,_listener,_loudness,_script,_args];
				}else{
					_question = [_text,_silence,_speaker,_listener,_loudness,_script,_args];
				};
				
			};
			case TYPE_ANSWER:{
				_x params [
					["_text","",[""]],
					["_jump","",["",[]]],
					["_script",{},[{}]],
					["_args",[]]
				];
				_answers pushBack [_jump,_script,_args,_text];//same structure as event
			};
			case TYPE_REMOVE_ANSWER:{
				_x params [["_jump","",[""]]];
				private _a = (count _answers -1);
				for "_i" from _a to 0 step -1do{
					private _answer = (_answers#_i);
					private _jump_i = _answer#INDEX_ANSWER_SCRIPT;
					if(_jump isEqualto _jump_i)then{_answers deleteAt _i}
				};
			};
			case TYPE_JUMP_TO: {
				_x params [
					["_jump","",["",[]]],
					["_script",{},[{}]],
					["_args",[]]
				];
				_jump_to = [_jump,_script,_args];
			};
			case TYPE_ANSWER_AI: {
				_x params [
					["_jump","",["",[]]],
					["_script",{},[{}]],
					["_args",[]]
				];
				_answer_ai = [_jump,_script,_args];
			};
			case TYPE_ON_WALKED_AWAY;
			case TYPE_ON_OUT_OF_TIME;
			case TYPE_ON_DEATH;
			case TYPE_ON_UNEXPECTED_END: {
				_x params [
					["_script",{},[{}]],
					["_args",[]]
				];
				
				private _event_type = [TYPE_EVENT_WALKED_AWAY,TYPE_EVENT_OUT_OF_TIME,
									TYPE_EVENT_DEATH,TYPE_EVENT_UNEXPECTED_END] #
									([TYPE_ON_WALKED_AWAY,TYPE_ON_OUT_OF_TIME,
									TYPE_ON_DEATH,TYPE_ON_UNEXPECTED_END] find _type);

				_events set [_event_type,[_script,_args]];
			};
			case TYPE_ON_END: {
				_x params [
					["_script",{},[{}]],
					["_args",[]]
				];
				_events pushBack [_script,_args];
			};
			default {
				[_namespace,"undefined type"] call pr0_fnc_dialogue_mainLoop_error;
			};
		};
	}forEach _node_array;

}; 

_namespace setVariable ["_sentences",_sentences];
_namespace setVariable ["_question",_question];
_namespace setVariable ["_answers",_answers];
_namespace setVariable ["_answer_ai",_answer_ai];
_namespace setVariable ["_jump_to",_jump_to];
_namespace setVariable ["_events",_events];
_namespace setVariable ["_node_id",_node_id];//used only for error message

if(count _sentences > 0)exitWith{
	_namespace call pr0_fnc_dialogue_mainLoop_sentence;
};

if(count _question > 0)exitWith{
	_namespace call pr0_fnc_dialogue_mainLoop_question;
};

//node without sentence or question was given
[_namespace,TYPE_EVENT_ERROR] call pr0_fnc_dialogue_mainLoop_end;
