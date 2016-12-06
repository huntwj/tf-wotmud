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


/def reconnect = \
    /if ({#}) \
	/for i 15 1 /repeat -$[i*60] 1 /echo %%i minutes to connect...%;\
	/repeat -900 1 /echo /connect%;\
    /else \
	/for i 5 1 /repeat -$[i*60] 1 /echo %%i minutes to connect...%;\
	/repeat -300 1 /echo /connect%;\
    /endif

/def wot = \
    /load tf-wotmud/main.tf

