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

/alias water /wot_setWaterContainer %{*}
/def wot_setWaterContainer = \
    /if ({#}) \
        /test util_setVar('inv.container.water', {1})%;\
    /endif%;\
    /echo Water container is now [$[wot_getWaterContainer()]]

/def wot_getWaterContainer = \
    /let _container=$[util_getVar('inv.container.water')]%;\
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

/set wot_inv_primaryWeapon=dagger
/set wot_inv_primarySheaths=0
/alias weapon /wot_inv_setWeapon %{*}
/def wot_inv_setWeapon = \
    /if ({#}) \
        /set wot_inv_primaryWeapon=%{1}%;\
    /endif%;\
    /echo Weapon is set to '%{wot_inv_primaryWeapon}'

/set wot_inv_utilityWeapon=dagger
/set wot_inv_utilitySheaths=0

/def wot_inv_wieldPrimary = \
    /if (wot_inv_primaryWeapon =~ "dagger") \
        /return%;\
    /endif%;\
    /if (wot_inv_primarySheaths) \
        draw %{wot_inv_primaryWeapon}%;\
    /else \
        wield %{wot_inv_primaryWeapon}%;\
    /endif

/def wot_inv_removePrimary = \
    /if (wot_inv_primaryWeapon =~ "dagger") \
        /return%;\
    /endif%;\
    /if (wot_inv_primarySheaths) \
        sheath%;\
    /else \
        rem %{wot_inv_primaryWeapon}%;\
    /endif

/def wot_inv_wieldUtility = \
    /if (wot_inv_primaryWeapon =~ "dagger") \
        /return%;\
    /endif%;\
    /if (wot_inv_utilitySheaths) \
        draw %{wot_inv_utilityWeapon}%;\
    /else \
        gc %{wot_inv_utilityWeapon}%;\
        wield %{wot_inv_utilityWeapon}%;\
    /endif

/def wot_inv_removeUtility = \
    /if (wot_inv_primaryWeapon =~ "dagger") \
        /return%;\
    /endif%;\
    /if (wot_inv_utilitySheaths) \
        sheath%;\
    /else \
        rem %{wot_inv_utilityWeapon}%;\
        pc %{wot_inv_utilityWeapon}%;\
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

