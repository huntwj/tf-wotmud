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

