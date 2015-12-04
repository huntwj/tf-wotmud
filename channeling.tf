;;
;; tf-wotmud/channeling.tf
;;
/loaded __tf_wotmud_channeling__

/def -mregexp -t"(You feel the flows of saidar coursing through your body\.|You are already in touch with saidar, can't you feel it\?)$" wot_channeling_detect_embrace = \
    /test wot_channeling_embraced := 1

/def -Ewot_channeling_embraced -mregexp -t"You aren't in touch with saidar to release anything\.$" wot_channeling_detect_already_released = \
    /test wot_channeling_embraced := 0

/def -Ewot_channeling_embraced -mregexp -h'SEND ^rel(e(a(s(e?)?)?)?)?' wot_channeling_detect_release = \
    /test wot_channeling_embraced := 0%;\
    /send - %{P0}%{PR}

/alias c /wot_channeling_channel %{*}
/def wot_channeling_channel = \
    /let _weave=%{1}%;\
    /let _rest=%{-1}%;\
    /let _fullWeave=$[wot_channeling_getWeave(_weave)]%;\
    /if (_fullWeave =~ "") \
        /echo Unknown weave '%{_weave}'.%;\
        /return%;\
    /endif%;\
    /if (_rest =~ "") \
        /test _rest := wot_channeling_getDefaultTarget(_weave)%;\
    /endif%;\
    /if (!wot_channeling_embraced) \
        embrace%;\
    /endif%;\
    channel '%{_fullWeave}' %{_rest}


/def wot_channeling_defineWeave = \
    /let _abbr=$[textencode({1})]%;\
    /let _fullWeave=%{2}%;\
    /test wotmud_channeling_weaves_%{_abbr} := _fullWeave%;\
    /if ({#} == 3) \
        /let _defaultTarget=%{3}%;\
        /test wotmud_channeling_weaves_default_%{_abbr} := _defaultTarget%;\
    /endif

/def wot_channeling_getWeave = \
    /let _abbr=$[textencode({1})]%;\
    /return wotmud_channeling_weaves_%{_abbr}

/def wot_channeling_getDefaultTarget = \
    /let _abbr=$[textencode({1})]%;\
    /return wotmud_channeling_weaves_default_%{_abbr}

/test wot_channeling_defineWeave("arm", "armor", "info.char.name")
/test wot_channeling_defineWeave("b", "blind", "info.target.name")
/test wot_channeling_defineWeave("cb", "cure blindness", "info.tank.name")
/test wot_channeling_defineWeave("ccw", "cure critical wounds", "info.tank.name")
/test wot_channeling_defineWeave("clw", "cure light wounds", "info.tank.name")
/test wot_channeling_defineWeave("csw", "cure serious wounds", "info.tank.name")
/test wot_channeling_defineWeave("food", "create food")
/test wot_channeling_defineWeave("h", "heal", "info.tank.name")
/test wot_channeling_defineWeave("is", "ice spikes", "info.target.name")
/test wot_channeling_defineWeave("light", "light ball", "info.tank.name")
/test wot_channeling_defineWeave("rcon", "remove contagion", "info.tank.name")
/test wot_channeling_defineWeave("ref", "refresh", "info.mount")
/test wot_channeling_defineWeave("s", "strength", "info.tank.name")
/test wot_channeling_defineWeave("water", "armor", "info.char.name")

