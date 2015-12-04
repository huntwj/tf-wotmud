;
; WoTMUD Chat Helpers.
;


/def key_f1 = /toggleChat

/def toggleChat = \
    /if (isLimited) \
        /unlimit%;\
        /test isLimited := 0%;\
    /else \
        /let _success=%;\
        /test _success := limit("-mregexp (tells you|chats|yells|speaks from the light|says|narrates)")%;\
        /test isLimited := _success%;\
    /endif

