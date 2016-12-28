;;
;; tf-wotmud/map-helper.tf
;;
/loaded __TF_WOTMUD_MAP_HELPER__

/require tf-mapper/main.tf

/test map_mapFile := strcat(TF_NPM_ROOT, "/data/map.sqlite")

/test map_capturingItemsAndMobs := 0

/def -mregexp -t"^\[ obvious exits:( N)?( E)?( S)?( W)?( U)?( D)? \]$" wotmud_t_detectExits = \
    /test map_capturingItemsAndMobs := 1%;\
    /test map_unknownMobCount := 0%;\
    /test map_leatherleafCount := 0%;\
    /test map_cuteDeerCount := 0%;\
    /let _maxLines=40%;\
    /let _lineNo=1%;\
    /let _roomDescription=%;\
    /if (map_editMode) \
        /test redisDel("tempRoom:description")%;\
    /endif%;\
    /while (_lineNo < _maxLines) \
        /let _line=$(/recall - -%{_lineNo})%;\
        /let _encodedLine=$[encode_attr(_line)]%;\
        /test _lineNo := _lineNo + 1%;\
        /let _strstr=$[strstr(_encodedLine, "@{Ccyan}")]%;\
        /if (_strstr >= 0) \
            /let _roomName=$[substr(_line, _strstr)]%;\
            /if (map_editMode) \
                /test redisSet("currentRoom:name", _roomName)%;\
                /test redisRename("tempRoom:description", "currentRoom:description")%;\
            /endif%;\
            /test util_setVar("map.currentRoom.name", _roomName)%;\
            /test util_setVar("map.currentRoom.description", _roomDescription)%;\
            /test map_roomCaptured(_roomName, _roomDescription)%;\
            /if (map_editMode) \
                /test map_roomCapturedWithRedis()%;\
            /endif%;\
            /return%;\
        /else \
            /test _roomDescription := strcat(_line,"\10",_roomDescription)%;\
            /if (map_editMode) \
                /test redisLPush("tempRoom:description", _line)%;\
            /endif%;\
        /endif%;\
    /done%;\
    /echo Room description limit (%{_maxLines}) reached. Giving up on finding a room name.

/test util_setVar("char.need.food", 1)
/def tf = \
    /let _needFood=$[!util_getVar("char.need.food")]%;\
    /test util_setVar("char.need.food", _needFood)%;\
    /echo Need food: %_needFood

/def -Emap_capturingItemsAndMobs -mregexp -t"^$" -pmaxpri -F wotmud_t_doneDetectingItemsAndMobs = \
    /test map_capturingItemsAndMobs := 0%;\
    /event_fire wot_map_doneDetectingItemsAndMobs %{map_unknownMobCunt}%;\
    /event_fire entered_room%;\
    /if (car(getVar("map.moveQueue")) !~ "")\
        /echo Move queue: $[getVar("map.moveQueue")]%;\
    /endif

/def -Emap_capturingItemsAndMobs -mregexp -t"^(.*)$" -p(maxpri-1) -F wotmud_t_captureItemOrMob = \
    /let _attrLine=$[encode_attr({P0})]%;\
    /if (substr(_attrLine, 0, 10) =~ "@{Cyellow}") \
        /let _mob=$[substr(_attrLine, 10, strlen(_attrLine) - 14)]%;\
;        /echo '%_mob'%;\
        /wotmud_captureMob %{_mob}%;\
    /elseif (substr(_attrLine, 0, 9) =~ "@{Cgreen}") \
;        /echo Ignoring items.
    /else \
;        /echo Unknown capture type: %{_attrLine}%;\
    /endif

/def wotmud_captureMob = \
;    /echo Capturing mob: '%{*}'%;\
    /let _mob=$[textencode({*})]%;\
    /if (strstr(wotmud_known_mobs, _mob) == -1) \
;        /echo Unknown mob: %{*}%;\
        /test ++map_unknownMobCount%;\
    /elseif (_mob =~ textencode("A young leatherleaf begins to thicken with age.") | _mob =~ textencode("A stout young sapling is lying here, mortally wounded.")) \
        /test ++map_leatherleafCount%;\
    /elseif (_mob =~ textencode("A cute brown deer eyes you nervously.")) \
        /test ++map_cuteDeerCount%;\
    /else \
;        /echo Known.%;\
    /endif

/test wotmud_known_mobs := ""
/def wotmud_addKnownMob = \
    /let _mob=$[textencode({*})]%;\
    /set wotmud_known_mobs=%{wotmud_known_mobs} %{_mob}

/test wotmud_addKnownMob("A shapely young woman skillfully weaves amongst the chaos, taking orders.")
/test wotmud_addKnownMob("A handsome stag stands here, ready to run.")
/test wotmud_addKnownMob("A gopher pokes his head up, sniffing the air warily.")
/test wotmud_addKnownMob("A biteme is hovering here, looking for blood.")
/test wotmud_addKnownMob("A man is here.")
/test wotmud_addKnownMob("A raccoon sniffs the ground for food.")
/test wotmud_addKnownMob("A cute brown deer eyes you nervously.")
/test wotmud_addKnownMob("A young leatherleaf begins to thicken with age.")
/test wotmud_addKnownMob("Clive stands here, grinning mischievously.")
/test wotmud_addKnownMob("A bearded coachman stands here, waiting for passengers.")
/test wotmud_addKnownMob("A crow is visible flying high in the sky.")
/test wotmud_addKnownMob("A crow is here flying around.")
/test wotmud_addKnownMob("A black crow is here, watching.")
/test wotmud_addKnownMob("A wild goose struts and flaps its wings, angrily honking at your intrusion.")
/test wotmud_addKnownMob("A long-eared rabbit is here, looking quite sick.")
/test wotmud_addKnownMob("A wild goose is here flying around.")
/test wotmud_addKnownMob("A raven is here flying around.")
/test wotmud_addKnownMob("A lamb nibbles on some grass.")
/test wotmud_addKnownMob("A black dog is here, wagging its tail.")
/test wotmud_addKnownMob("A short man stands here, nervously eyeing everything in sight.")
/test wotmud_addKnownMob("A gray mouse is scuttling about here.")
/test wotmud_addKnownMob("A plodding ox wanders here.")
/test wotmud_addKnownMob("An Ogier stonemason strides by briskly.")
/test wotmud_addKnownMob("A lynx creeps low to the ground, hunting for food.")
/test wotmud_addKnownMob("A wild goat clambers over the rocks glaring at everything.")
/test wotmud_addKnownMob("A plump pheasant is visible flying high in the sky.")
/test wotmud_addKnownMob("An elk with massive antlers eyes you with curiosity.")
/test wotmud_addKnownMob("A villager woman performs her daily routine.")
/test wotmud_addKnownMob("An old woman smiles kindly.")
/test wotmud_addKnownMob("A long-billed crane is here flying around.")
/test wotmud_addKnownMob("A young and strong buck is here, munching some grass.")
/test wotmud_addKnownMob("A mangy cat scurries around trying not to get stepped on.")
/test wotmud_addKnownMob("A plump pheasant is here flying around.")
/test wotmud_addKnownMob("A long-billed crane is visible flying high in the sky.")
/test wotmud_addKnownMob("A timber wolf is here, snarling hungrily.")
/test wotmud_addKnownMob("A cunning coyote lurks here, looking suspicious and hungry.")
/test wotmud_addKnownMob("A long-billed crane with white plumage delicately wades through the water.")
/test wotmud_addKnownMob("A giant bee preys on small animals.")
/test wotmud_addKnownMob("A plump pheasant pecks at the ground.")
/test wotmud_addKnownMob("A huge hound is here, trained to kill.")
/test wotmud_addKnownMob("A gray palfrey prances skittishly nearby.")
/test wotmud_addKnownMob("A stout young sapling is lying here, mortally wounded.")
/test wotmud_addKnownMob("A Tairen bloodstock stallion stands here, tail swaying with the breeze.")
/test wotmud_addKnownMob("A brown cow is here, chewing thoughtfully.")
/test wotmud_addKnownMob("A sheep is here, bleating.")
/test wotmud_addKnownMob("A raven is here, watching.")
/test wotmud_addKnownMob("A shaggy brown mare stands here.")
/test wotmud_addKnownMob("A wild goose is visible flying high in the sky.")
/test wotmud_addKnownMob("A raven is visible flying high in the sky.")
/test wotmud_addKnownMob("A man looks at a nearby horse with greedy eyes, riding a black stallion.")
/test wotmud_addKnownMob("A figure stands here, ready to collect unwanted things.")
/test wotmud_addKnownMob("A fox is here, hunting for rabbits.")
/test wotmud_addKnownMob("A warhorse is here, stamping his feet impatiently.")
/test wotmud_addKnownMob("A timid fawn is ready to flee.")
/test wotmud_addKnownMob("A draft horse is here.")
/test wotmud_addKnownMob("A black stallion prances about.")
/test wotmud_addKnownMob("A chicken wanders around here, pecking at the ground.")
/test wotmud_addKnownMob("A dun mare is here, snorting angrily.")
/test wotmud_addKnownMob("")
/test wotmud_addKnownMob("")
