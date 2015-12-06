;;
;; tf-wotmud/score.tf
;;
/loaded __tf_wotmud_score__

/def -mregexp -t"You have \d+\(\d+\) hit and \d+\(\d+\) movement points.$" wot_score_beginCapture = \
    /echo Beginning score capture%;\
    /util_setVar capturing.score 1

/def -Evar_user_capturing_46_score -mregexp -t"^You have scored \d+ experience points and \d+ quest points\.$" wot_score_captureExp = \
    /test 1

/def -Evar_user_capturing_46_score -mregexp -t"^You need \d+ exp to reach the next level\.$" wot_score_captureTnl = \
    /test 1

/def -Evar_user_capturing_46_score -mregexp -t"^You have played \d+ days and \d+ hours \(real time\)\.$" wot_score_capturecePlayedTime = \
    /test 1

/def -Evar_user_capturing_46_score -mregexp -t"^This ranks you as (\w+) of (Illian|the Borderlands|Tarabon|Two Rivers) \(Level (\d+)\)\.$" wot_score_captureRankAndLevel = \
    /let _name=%{P1}%;\
    /let _homeland=%{P2}%;\
    /let _level=%{P3}%;\
    /util_setVar char.name %{_name}%;\
    /util_setVar char.homeland %{_homeland}%;\
    /util_setVar char.level %{_level}%;\
    /test 1

/def -Evar_user_capturing_46_score -mregexp -t"^You are (standing|resting|sleeping)\.$" wot_captureRestStanding = \
    /test 1

/def -Evar_user_capturing_46_score -mregexp -t"^$" wot_score_endCapture = \
    /echo Ending score capture%;\
    /util_setVar capturing.score 0

/def -Evar_user_capturing_46_score -p0 -mregexp -t"^.*$" wot_score_captureUnknown = \
    /echo -aCred Unknown score line. Please address this.

