/require tf-diku/main.tf

/require tf-wotmud/map-helper.tf
/require tf-wotmud/prompt.tf
/require tf-wotmud/chat.tf
/require tf-wotmud/channeling.tf
/require tf-wotmud/score.tf
/require tf-wotmud/stats.tf
/require tf-wotmud/inventory.tf
/require tf-wotmud/mount.tf
/require tf-wotmud/target.tf

/addworld -Tdiku WoTMUD game.wotmud.org 2224

/set wot_inv_food=meat

/alias food /wot_food %{*}
/def wot_food = \
    /if ({#}) \
	/set wot_inv_food=%{1}%;\
    /endif%;\
    /echo Default food is: %{wot_inv_food}

/def -F -mregexp -t"^You are hungry\.$" wot_t_hungry = \
    gc %{wot_inv_food}%;\
    eat %{wot_inv_food}%;\
    /test 1

/def -F -mregexp -t"^You are thirsty\.$" wot_t_thirsty = \
    /dws%;\
    look in $[util_getVar("inv.container.water")]%;\
    /test 1

