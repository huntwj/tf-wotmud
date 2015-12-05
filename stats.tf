;;
;; tf-wotmud/stats.tf
;;
/loaded __tf_wotmud_stats__

/def -mregexp -t"You are a \d+ year old (male|female) (human) (rogue)\.$" wot_stats_beginCapture = \
    /echo Beginning stats capture%;\
    /util_setVar capturing.stats 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your height is \d+ feet, \d+ inches, and you weigh \d+\.\d+ lbs\.$" wot_stats_captureVitals = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^You are carrying \d+\.\d+ lbs and wearing \d+\.\d+ lbs, (very light)\.$" wot_stats_captureLoad = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your base abilities are: Str:(\d+) Int:(\d+) Wil:(\d+) Dex:(\d+) Con:(\d+)\.$" wot_stats_captureStats = \
    /let _str=%{P1}%;\
    /let _int=%{P2}%;\
    /let _wil=%{P3}%;\
    /let _dex=%{P4}%;\
    /let _con=%{P5}%;\
    /util_setVar char.stats.str %{_str}%;\
    /util_setVar char.stats.int %{_int}%;\
    /util_setVar char.stats.wil %{_wil}%;\
    /util_setVar char.stats.dex %{_dex}%;\
    /util_setVar char.stats.con %{_con}

/def -Evar_user_capturing_46_stats -mregexp -t"^Offensive bonus: \d+, Dodging bonus: \d+, Parrying bonus: \d+$" wot_stats_captureObDbPb = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your mood is: (Wimpy|Brave|Berserk)\. You will flee below: \d+ Hit Points$" wot_stats_captureFleeMood = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your armor absorbs about\s+\d+% on average\.$" wot__stats_captureAbs = \
    /echo Ending stats capture%;\
    /util_setVar capturing.stats 0

/def -Evar_user_capturing_46_stats -p0 -mregexp -t"^.*$" wot_stats_captureUnknown = \
    /echo Unknown stats line. Please address this.

