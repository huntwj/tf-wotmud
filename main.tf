/require tf-diku/main.tf

/require tf-wotmud/map-helper.tf
/require tf-wotmud/prompt.tf
/require tf-wotmud/chat.tf
/require tf-wotmud/channeling.tf
/require tf-wotmud/score.tf
/require tf-wotmud/stats.tf
/require tf-wotmud/inventory.tf
/require tf-wotmud/mount.tf

/addworld -Tdiku WoTMUD game.wotmud.org 2224

/def -mregexp -t"^You are hungry\.$" wot_t_hungry = \
    /test 1

/def -mregexp -t"^You are thirsty\.$" wot_t_thirsty = \
    /test 1

