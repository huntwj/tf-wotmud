;;
;; tf-wotmud/target.tf
;;
/loaded __tf_wotmud_target__

/alias ki /wot_target_ki %{*}
/alias k ki %{*}
/def wot_target_ki = \
    /if ({#}) \
        /wot_target_setTarget %{*}%;\
    /endif%;\
    /let _target=%{wot_target_target}%;\
    /if (_target =~ "") \
        /test _target := "ancient"%;\
    /endif%;\
    kill %{wot_target_target}

/alias t /wot_target_tellOrTarget %{*}
/def wot_target_tellOrTarget = \
    /if ({#} > 1) \
        tell %{*}%;\
    /else \
        /wot_target_setTarget %{*}%;\
    /endif
/def wot_target_setTarget = \
    /let _t=%{1}%;\
    /if (_t =~ "a") \
        /test _t := "ancient"%;\
    /endif%;\
    /let _echo=$[{#} == 0 | ({#} & _t !~ wot_target_target)]%;\
    /if ({#} & _t !~ wot_target_target) \
        /set wot_target_target=%{_t}%;\
    /endif%;\
    /if (_echo) \
        /echo Target set to '%{wot_target_target}'%;\
    /endif

/alias kt ki tree
/alias kat ki angry
/alias kg ki grass
/alias ka ki ancient
/alias kaa ki aiel
/alias kz ki lizard
/alias ks ki scorpion

/def key_f2 = k

/alias kc /wot_target_kc %{*}
/def wot_target_kc = \
    /if (util_getVar("char.level") > 5) \
        ki cat%;\
    /else \
;        ki 2.leatherleaf%;\
        ki cute%;\
    /endif

/alias kp ki pig

/alias tank /wot_target_setTank %{*}
/def wot_target_setTank = \
    /let _tank=%{wot_target_tank}%;\
    /if ({#}) \
        /test _tank := {1}%;\
    /endif%;\
    /set wot_target_tank=%{_tank}%;\
    /echo Tank is set to '%{wot_target_tank}'

/alias at /wot_target_assistTank %{*}
/def wot_target_assistTank = \
    /if ({#}) \
        /wot_target_setTank %{1}%;\
    /endif%;\
    assist %{wot_target_tank}

/alias dt diagnose %{wot_target_tank}
/alias tt tell %{wot_target_tank %{*}

/alias b backstab %{wot_target_target}

