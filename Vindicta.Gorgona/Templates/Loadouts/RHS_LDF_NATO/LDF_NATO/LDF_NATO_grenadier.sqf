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
this forceaddUniform "rhsgref_uniform_para_ttsko_urban";
this addVest "rhssaf_vest_md12_digital";

this addWeapon "rhs_weap_g36kv_ag36";
this addPrimaryWeaponItem "rhsusf_acc_eotech_552";
this addPrimaryWeaponItem "rhssaf_30rnd_556x45_EPR_G36";
this addPrimaryWeaponItem "rhs_mag_M441_HE";

this addItemToUniform "FirstAidKit";
for "_i" from 1 to 7 do {this addItemToVest "rhs_mag_M441_HE";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_M433_HEDP";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_M397_HET";};
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_m713_Red";};
for "_i" from 1 to 5 do {this addItemToVest "rhssaf_30rnd_556x45_EPR_G36";};
this linkItem "ItemWatch";

