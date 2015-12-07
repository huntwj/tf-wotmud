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

/alias fws /wot_fillWaterSkin
/def wot_fillWaterSkin = \
    /let _source=%{1-waterskin}%;\
    /let _container=%{2-waterskin}%;\
    fill %{_container} %{_source}

/def dws = /wot_drinkWaterSkin
/def wot_drinkWaterSkin = \
    /let _container=%{2-waterskin}%;\
    remove %{_container}%;\
    /repeat -S 2 drink %{_container}%;\
    wear %{_container}

