;;
;; tf-wotmud/stats.tf
;;
/loaded __tf_wotmud_stats__

/require tf-util/events.tf

/def -mregexp -t"You are a \d+ year old (male|female) (human) (rogue|hunter|warrior|channeler)\.(  It's your birthday today!)?$" wot_stats_beginCapture = \
    /let _sex=%{P1}%;\
    /let _class=%{P3}%;\
    /echo Beginning stats capture%;\
    /util_setVar char.sex %{_sex}%;\
    /util_setVar char.class %{_class}%;\
    /util_setVar capturing.stats 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your height is \d+ feet, \d+ inches, and you weigh \d+\.\d+ lbs\.$" wot_stats_captureVitals = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^You are carrying \d+\.\d+ lbs and wearing \d+\.\d+ lbs, (very light|fairly light|light|peanuts|somewhat heavy|heavy)\.$" wot_stats_captureLoad = \
    /test 1

/def -Evar_user_capturing_46_stats -ag -mregexp -t"^Your base abilities are: Str:(\d+) Int:(\d+) Wil:(\d+) Dex:(\d+) Con:(\d+)\.$" wot_stats_captureStats = \
    /let _line=%{P0}%;\
    /let _str=%{P1}%;\
    /let _int=%{P2}%;\
    /let _wil=%{P3}%;\
    /let _dex=%{P4}%;\
    /let _con=%{P5}%;\
    /let _sum=$[_str + _int + _wil + _dex + _con]%;\
    /util_setVar char.stats.str %{_str}%;\
    /util_setVar char.stats.int %{_int}%;\
    /util_setVar char.stats.wil %{_wil}%;\
    /util_setVar char.stats.dex %{_dex}%;\
    /util_setVar char.stats.con %{_con}%;\
    /util_setVar char.stats.sum %{_sum}%;\
    /if (util_getVar("char.level") == 3) \
        /echo -aCyellow %{_line} (Stat Sum: %{_sum})%;\
    /else \
        /echo %{_line} (Stat Sum: %{_sum})%;\
    /endif%;\
    /util_fireEvent captured.abilities %{_str} %{_int} %{_wil} %{_dex} %{_con} %{_sum}

/def -Evar_user_capturing_46_stats -mregexp -t"^Offensive bonus: \d+, Dodging bonus: \d+, Parrying bonus: \d+$" wot_stats_captureObDbPb = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your mood is: (Wimpy|Brave|Berserk|Normal)\. You will flee below: \d+ Hit Points$" wot_stats_captureFleeMood = \
    /test 1

/def -Evar_user_capturing_46_stats -mregexp -t"^Your armor absorbs about\s+\d+% on average\.$" wot__stats_captureAbs = \
    /echo Ending stats capture%;\
    /util_setVar capturing.stats 0

/def -Evar_user_capturing_46_stats -p0 -mregexp -t"^.*$" wot_stats_captureUnknown = \
    /echo -aCred Unknown stats line. Please address this.

