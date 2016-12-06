;;
;; tf-wotmud/inventory.tf
;;
/loaded __tf_wotmud_inventory__

/alias rlight /wotmud_rotateLightSource
/def wotmud_rotateLightSource = \
    remove light%;\
    drop light%;\
    gc light%;\
    hold light

/declareVar inv.food meat
/alias food /wot_setFood %{*}
/def wot_setFood = \
    /if ({#}) \
        /test setVar("inv.food", {1})%;\
    /endif%;\
    /echo Default food is: $[getVar("inv.food")]

/def -F -mregexp -t"^You are hungry\.$" wot_t_hungry = \
    /wot_eatFood

/def wot_eatFood = \
    gc $[getVar("inv.food")]%;\
    eat $[getVar("inv.food")]

/def -F -mregexp -t"^You are thirsty\.$" wot_t_thirsty = \
    /dws%;\
    look in $[wot_getWaterContainer()]%;\

/alias water /wot_setWaterContainer %{*}
/def wot_setWaterContainer = \
    /if ({#}) \
        /test setVar('inv.container.water', {1})%;\
    /endif%;\
    /echo Water container is now [$[wot_getWaterContainer()]]

/def wot_getWaterContainer = \
    /let _container=$[getVar('inv.container.water')]%;\
    /if (_container =~ "") \
        /test _container := "waterskin"%;\
    /endif%;\
    /return _container
/alias lwc look in $[wot_getWaterContainer()]

/def fws = /wot_fillWaterSkin %{*}
/def wot_fillWaterSkin = \
    /let _source=%{1-fountain}%;\
    /let _container=$[wot_getWaterContainer()]%;\
    /if ({2} !~ "") \
        /test _container := {2}%;\
    /endif%;\
    remove %{_container}%;\
    fill %{_container} %{_source}%;\
    wear %{_container}

/def dws = /wot_drinkWaterSkin %{*}
/def wot_drinkWaterSkin = \
    /let _container=$[wot_getWaterContainer()]%;\
    /if ({1} !~ "") \
        /test _container := {1}%;\
    /endif%;\
    remove %{_container}%;\
    /repeat -S 2 drink %{_container}%;\
    wear %{_container}

/declareVar inv.weapon staff
/declareVar inv.weapon.sheaths 0
/alias weapon /wot_inv_setWeapon %{*}
/def wot_inv_setWeapon = \
    /if ({#}) \
        /test setVar("inv.weapon", {1})%;\
    /endif%;\
    /echo Weapon is set to <$[getVar("inv.weapon")]>

/declareVar inv.utility dagger
/declareVar inv.utility.sheaths 1

/def wot_inv_wieldPrimary = \
    /let _weapon=$[getVar("inv.weapon")]%;\
    /if (_weapon =~ "dagger") \
        /return%;\
    /endif%;\
    /if (getVar("inv.weapon.sheaths")) \
        draw %{_weapon}%;\
    /else \
        wield %{_weapon}%;\
    /endif

/def wot_inv_removePrimary = \
    /let _weapon=$[getVar("inv.weapon")]%;\
    /if (_weapon =~ "dagger") \
        /return%;\
    /endif%;\
    /if (getVar("inv.weapon.sheaths")) \
        sheath%;\
    /else \
        rem %{_weapon}%;\
    /endif

/def wot_inv_wieldUtility = \
    /let _utility=$[getVar("inv.utility")]%;\
    /if (getVar("inv.weapon") =~ "dagger") \
        /return%;\
    /endif%;\
    /if (getVar("inv.utility.sheaths")) \
        draw %{_utility}%;\
    /else \
        gc %{_utility}%;\
        wield %{_utility}%;\
    /endif

/def wot_inv_removeUtility = \
    /if (getVar("inv.weapon") =~ "dagger") \
        /return%;\
    /endif%;\
    /if (getVar("inv.utility.sheaths")) \
        sheath%;\
    /else \
        /let _utility=$[getVar("inv.utility")]%;\
        rem %{_utility}%;\
        pc %{_utility}%;\
    /endif

/def sc = \
    /wot_inv_removePrimary%;\
    /wot_inv_wieldUtility%;\
    /let _start=%{1-1}%;\
    /let _end=%{2-%{_start}}%;\
    /for i %{_start} %{_end} scalp %%i.corpse%;\
    /wot_inv_removeUtility%;\
    /wot_inv_wieldPrimary%;\
    /let _count=$[_end-_start+1]%;\
    /repeat -S %{_count} pc scalp

/def bc = \
    /wot_inv_removePrimary%;\
    /wot_inv_wieldUtility%;\
    /repeat -S %{1-4} butcher %{2-1}.corpse%;\
    /wot_inv_removeUtility%;\
    /wot_inv_wieldPrimary%;\
;    pc all.meat%;\
    /test 1

