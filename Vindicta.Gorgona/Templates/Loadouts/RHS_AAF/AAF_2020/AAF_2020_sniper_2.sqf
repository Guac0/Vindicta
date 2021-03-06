removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

_RandomGoggles = selectRandom ["FGN_AAF_Shemag_tan","FGN_AAF_Shemag","rhs_scarf","","",""];
this addGoggles _RandomGoggles;
_RandomHeadgear = selectRandom ["FGN_AAF_Boonie_Type07","FGN_AAF_Boonie_Type07","rhsusf_bowman_cap"];
this addHeadgear _RandomHeadgear;
this forceaddUniform "FGN_AAF_M10_Type07_Summer";
this addVest "FGN_AAF_CIRAS_MM";

this addWeapon "rhs_weap_m24sws";
this addPrimaryWeaponItem "rhsusf_acc_m24_silencer_black";
this addPrimaryWeaponItem "rhsusf_acc_M8541";
this addPrimaryWeaponItem "rhsusf_5Rnd_762x51_m118_special_Mag";
this addPrimaryWeaponItem "rhsusf_acc_harris_swivel";
this addWeapon "rhsusf_weap_glock17g4";
this addHandgunItem "acc_flashlight_pistol";
this addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";
this addWeapon "Binocular";

this addItemToUniform "FirstAidKit";
this addItemToUniform "I_IR_Grenade";
for "_i" from 1 to 2 do {this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
for "_i" from 1 to 6 do {this addItemToVest "rhsusf_5Rnd_762x51_m118_special_Mag";};
for "_i" from 1 to 4 do {this addItemToVest "rhsusf_5Rnd_762x51_m62_Mag";};
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "NVGoggles_OPFOR";