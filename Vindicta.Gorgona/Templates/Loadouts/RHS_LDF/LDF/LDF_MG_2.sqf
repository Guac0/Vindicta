removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

_RandomHeadgear = selectRandom ["rhssaf_helmet_m97_veil_digital","rhssaf_helmet_m97_digital","rhssaf_helmet_m97_digital_black_ess","rhssaf_helmet_m97_digital_black_ess_bare","rhssaf_helmet_m97_olive_nocamo","rhssaf_helmet_m97_olive_nocamo_black_ess","rhssaf_helmet_m97_olive_nocamo_black_ess_bare"];
this addHeadgear _RandomHeadgear;
_RandomGoggles = selectRandom ["G_Bandanna_oli","G_Balaclava_oli","rhsusf_shemagh_od","rhsusf_shemagh2_od","","",""];
this addGoggles _RandomGoggles;
this forceaddUniform "rhssaf_uniform_m10_digital_summer";
this addVest "rhssaf_vest_md99_digital_rifleman";
this addBackpack "rhssaf_kitbag_digital";

this addWeapon "rhs_weap_aks74_2";
this addPrimaryWeaponItem "rhs_acc_dtk1983";
this addPrimaryWeaponItem "rhs_acc_2dpZenit";

this addPrimaryWeaponItem "rhs_30Rnd_545x39_7N10_plum_AK";
this addWeapon "Binocular";

this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_f1";};
for "_i" from 1 to 4 do {this addItemToVest "rhs_30Rnd_545x39_7N10_plum_AK";};
for "_i" from 1 to 2 do {this addItemToBackpack "rhs_100Rnd_762x54mmR_green";};
for "_i" from 1 to 2 do {this addItemToBackpack "rhs_100Rnd_762x54mmR_7BZ3";};
this linkItem "ItemWatch";
