;;
;; WoTMUD Prompt Triggers and Variables
;;

/def setvar = \
    /let _varName=var_$[textencode({1})]%;\
;    /echo %{_varName} := %{2}%;\
    /test %{_varName} := {2}

/test wot_health_states := "Healthy|Scratched|Hurt|Wounded|Battered|Beaten|Critical|Incapacitated"
/test wot_movement_states := "Full|Fresh|Strong|Tiring|Winded|Weary|Haggard"
/test wot_spell_states := "Bursting|Full|Strong|Trickling"

/eval /def -mregexp -h'PROMPT ^([*o] HP:(%{wot_health_states})( SP:(%{wot_spell_states}))? MV:(%{wot_movement_states})( - (.*): (%{wot_health_states}))? > )' wot_prompt_trigger = \
    /wot_do_prompt

/def wot_do_prompt = \
    /let _charHealth=%{P2}%;\
    /let _charPower=%{P4}%;\
    /let _charMoves=%{P5}%;\
    /let _targetDesc=%{P7}%;\
    /let _targetHealth=%{P8}%;\
    /echo P - %{P0}%;\
    /test setvar("char.health", {_charHealth})%;\
    /test setvar("char.power", {_charPower})%;\
    /test setvar("char.moves", {_charMoves})%;\
    /test setvar("combat.target.desc", {_targetDesc})%;\
    /test setvar("combat.target.health", {_targetHealth})%;\
;    /echo %{P0}
    /test 1
