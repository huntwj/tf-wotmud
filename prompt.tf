;;
;; WoTMUD Prompt Triggers and Variables
;;
/loaded __tf_wotmud_prompt__

/test wot_health_states := "Healthy|Scratched|Hurt|Wounded|Battered|Beaten|Critical|Incapacitated"
/test wot_movement_states := "Full|Fresh|Strong|Tiring|Winded|Weary|Haggard"
/test wot_spell_states := "Bursting|Full|Strong|Trickling"

/eval /def -mregexp -h'PROMPT ^([*o] HP:(%{wot_health_states})( SP:(%{wot_spell_states}))? MV:(%{wot_movement_states})(( - (.*): (%{wot_health_states}))? - (.*): (%{wot_health_states}))? > )' wot_prompt_trigger = \
    /wot_do_prompt

/def wot_do_prompt = \
    /let _promptLine=%{P0}%;\
    /let _charHealth=%{P2}%;\
    /let _charPower=%{P4}%;\
    /let _charMoves=%{P5}%;\
    /let _tankDesc=%{P8}%;\
    /let _tankHealth=%{P9}%;\
    /let _targetDesc=%{P10}%;\
    /let _targetHealth=%{P11}%;\
    /test util_setVar("char.health", {_charHealth})%;\
    /test util_setVar("char.power", {_charPower})%;\
    /test util_setVar("char.moves", {_charMoves})%;\
    /test util_setVar("combat.tank.desc", _tankDesc)%;\
    /test util_setVar("combat.tank.health", _tankHealth)%;\
    /test util_setVar("combat.target.desc", {_targetDesc})%;\
    /test util_setVar("combat.target.health", {_targetHealth})%;\
    /let _prefix=>%;\
    /if (_tankDesc !~ "") \
        /test _prefix := "T"%;\
    /elseif (_targetDesc !~ "") \
        /test _prefix := "C"%;\
    /endif%;\
    /echo %{_prefix} %{_promptLine}
