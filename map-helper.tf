;;
;; tf-wotmud/map-helper.tf
;;
/loaded __TF_WOTMUD_MAP_HELPER__

/require tf-mapper/main.tf

/test mapper_mapFile := strcat(TF_NPM_ROOT, "/data/map.sqlite")

/def -mregexp -t"^\[ obvious exits:( N)?( E)?( S)?( W)?( U)?( D)? \]$" wotmud_t_detectExits = \
    /let _maxLines=10%;\
    /let _lineNo=1%;\
    /let _roomDescription=%;\
    /while (_lineNo < _maxLines) \
        /let _line=$(/recall - -%{_lineNo})%;\
        /let _encodedLine=$[encode_attr(_line)]%;\
        /test _lineNo := _lineNo + 1%;\
        /if (strstr(_encodedLine, "@{Ccyan}") == 0) \
            /let _roomName=%{_line}%;\
            /test util_setVar("mapper.currentRoom.name", _roomName)%;\
            /test util_setVar("mapper.currentRoom.description", _roomDescription)%;\
            /test mapper_roomCaptured(_roomName, _roomDescription)%;\
            /return%;\
        /else \
            /test _roomDescription := strcat(_line,"\10",_roomDescription)%;\
        /endif%;\
    /done%;\
    /echo Room description limit (%{_maxLines}) reached. Giving up on finding a room name.

