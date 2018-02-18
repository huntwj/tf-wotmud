/alias mount /wot_mount_setMount %{*}
/def wot_mount_setMount = \
    /if ({#}) \
        /util_setVar mount %{1}%;\
    /endif%;\
    /echo Current mount is $[util_getVar("mount")]

/alias rh /wot_mount_rideHorse %{*}
/def wot_mount_rideHorse = \
    /if ({#} > 1) \
        /wot_mount %{2}%;\
    /endif%;\
    ride %{1-1}.$[util_getVar("mount")]

/alias lh /wot_mount_leadHorse %{*}
/def wot_mount_leadHorse = \
    /wot_mount_autoLeadHorse %{1-1} $[util_getVar("mount")]

/alias alh /wot_mount_autoLeadHorse %{*}
/def wot_mount_autoLeadHorse = \
    /let _idx=%{1}%;\
    /let _mount=%{2}%;\
    /test _wot_mount_autoLead_idx := _idx%;\
    /test _wot_mount_autoLead_mount := _mount%;\
    /test _wot_mount_autoLead := 1%;\
    lead %{_idx}.%{_mount}

/def -mregexp -t" has an indifferent look\.$" wot_mount_autoLeadHorse_t = \
    /test _wot_mount_autoLead := 0%;\
    lead %{_wot_mount_autoLead_idx}.%{_wot_mount_autoLead_mount}

/alias dh /wot_mount_diagHorse %{*}
/def wot_mount_diagHorse = \
    diagnose %{1-1}.$[util_getVar("mount")]

/alias dl dismount%;alh %{1-1} $[util_getVar("mount")]

/alias eh equip %{2-1}.$[util_getVar("mount")] %{1-saddlebag}
/alias ehs eh saddlebag
/alias remh remove %{1-saddlebag} %{2-1}.$[util_getVar("mount")]
/alias rhs remh saddlebag

/alias bard /wot_mount_bard saddle shoes bridle saddlebag donning
/def wot_mount_bard = \
    /if ({#}) \
        gc %{1}%;\
        equip $[util_getVar("mount")] %{1}%;\
        /shift%;\
        /wot_mount_bard %{*}%;\
    /endif

/alias unbard /wot_mount_unbard shoes bridle saddlebag saddle
/def wot_mount_unbard = \
    /if ({#}) \
        remove %{1} $[util_getVar("mount")]%;\
        pc %{1}%;\
        /shift%;\
        /wot_mount_unbard %{*}%;\
    /endif

