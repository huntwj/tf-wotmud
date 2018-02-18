;;
;; WoTMUD Prompt Triggers and Variables
;;
/loaded __tf_wotmud_prompt__

/test wot_health_states := "Healthy|Scratched|Hurt|Wounded|Battered|Beaten|Critical|Incapacitated|Dead\?"
/test wot_movement_states := "Full|Fresh|Strong|Tiring|Winded|Weary|Haggard"
/test wot_spell_states := "Bursting|Full|Strong|Good|Fading|Trickling"

/eval /def -mregexp -h'PROMPT ^([*o]? ((R|S) )?HP:(%{wot_health_states})( SP:(%{wot_spell_states}))? MV:(%{wot_movement_states})(( - (.*): (%{wot_health_states}))? - (.*): (%{wot_health_states}))? > )' wot_prompt_trigger = \
    /wot_do_prompt

/def wot_do_prompt = \
    /let _promptLine=%{P0}%;\
    /let _charHealth=%{P4}%;\
    /let _charPower=%{P6}%;\
    /let _charMoves=%{P7}%;\
    /let _tankDesc=%{P10}%;\
    /let _tankHealth=%{P11}%;\
    /let _targetDesc=%{P12}%;\
    /let _targetHealth=%{P13}%;\
    /test util_setVar("char.health", {_charHealth})%;\
    /test util_setVar("char.power", {_charPower})%;\
    /test util_setVar("char.moves", {_charMoves})%;\
    /test util_setVar("combat.tank.desc", _tankDesc)%;\
    /test util_setVar("combat.tank.health", _tankHealth)%;\
    /test util_setVar("combat.target.desc", {_targetDesc})%;\
    /test util_setVar("combat.target.health", {_targetHealth})%;\
    /let _level=$[util_getVar("char.level")]%;\
    /if (_level <= 3) \
        /let _prefix=%{_level}%;\
;        /test _prefix := strcat(_level, " ", _prefix)%;\
;        /test _prefix := _level%;\
    /else \
        /let _prefix=>%;\
    /endif%;\
    /if (_tankDesc !~ "") \
        /test _prefix := "T"%;\
    /elseif (_targetDesc !~ "") \
        /event_fire combat_detected%;\
        /test _prefix := "C"%;\
    /endif%;\
    /test util_setVar("mending", 0)%;\
    /echo %{_prefix} %{_promptLine}
