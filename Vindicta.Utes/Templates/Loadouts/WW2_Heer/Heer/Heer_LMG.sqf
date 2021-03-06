comment "Exported from Arsenal by MatrikSky";

removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

/*Helmet*/
_RandomHeadgear = selectRandom ["H_LIB_GER_Helmet", "H_LIB_GER_Helmet_ns", "H_LIB_GER_Helmet_os", "H_LIB_GER_Helmet", "H_LIB_GER_Helmet_ns", "H_LIB_GER_Helmet_os", "H_LIB_GER_Helmet", "H_LIB_GER_Helmet_ns", "H_LIB_GER_Helmet_os", "H_LIB_GER_Helmet_net", "H_LIB_GER_HelmetUtility", "H_LIB_GER_Helmet_Glasses", "H_LIB_GER_Cap"];
this addHeadgear _RandomHeadgear;
/*Uniform*/
_RandomUniform = selectRandom ["U_LIB_GER_Recruit", "U_LIB_GER_Schutze", "U_LIB_GER_Soldier2", "U_LIB_GER_Schutze_HBT", "U_LIB_GER_MG_schutze_HBT", "U_LIB_GER_MG_schutze"];
this forceAddUniform _RandomUniform;
/*Vest*/
this addVest "V_LIB_GER_VestMG";
/*Backpack*/
_RandomBackpack = selectRandom ["B_LIB_GER_A_frame", "B_LIB_GER_A_frame_kit", "B_LIB_GER_A_frame_zeltbahn", "fow_b_ammoboxes", ""];
this addBackpack _RandomBackpack;

/*Weapon*/
this addWeapon "LIB_MG34";
/*WeaponItem*/
this addPrimaryWeaponItem "LIB_50Rnd_792x57";

/*Items*/
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {this addItemToVest "LIB_50Rnd_792x57";};
for "_i" from 1 to 2 do {this addItemToVest "LIB_Shg24";};
this addItemToVest "LIB_Shg24x7";
this addItemToVest "LIB_NB39";

/*Items*/
this linkItem "ItemMap";
this linkItem "LIB_GER_ItemCompass_deg";
this linkItem "LIB_GER_ItemWatch";
_RandomlinkItem = selectRandom ["fow_i_nvg_GER_ammoboxes_mg34", "fow_i_nvg_GER_ammo_belt", ""];
this linkItem _RandomlinkItem;

[this,"Default","male05ger"] call BIS_fnc_setIdentity;
