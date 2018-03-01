;
; WoTMUD Chat Helpers.
;
/undef key_f1
/def key_f1 = /toggleChat

/def toggleChat = \
    /if (isLimited) \
        /unlimit%;\
        /test isLimited := 0%;\
    /else \
        /let _success=%;\
        /test _success := limit("-mregexp \\w+ (((tell|reply to) \\w+)|tells you|chat|yell|speaks from the light|say|narrate|bellow)s?\\b")%;\
        /test isLimited := _success%;\
    /endif

