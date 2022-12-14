CLASS zcl_acronym DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS parse IMPORTING phrase         TYPE string
                  RETURNING VALUE(acronym) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_acronym IMPLEMENTATION.
  METHOD parse.
    "Implement solution
    DATA(phrase_converted) = replace( val = to_upper( phrase ) sub = `'` with = `` occ = 0 ).
    phrase_converted = replace( val = phrase_converted regex = `[^A-Z0-9 ]` with = ` ` occ = 0 ).
    SPLIT condense( phrase_converted ) AT ` ` INTO TABLE DATA(words).

    acronym = REDUCE #( INIT val TYPE string
                      FOR word IN words
                      NEXT val = |{ val }{ word(1) }| ).
    acronym = condense( val = acronym del = ` ` ).
  ENDMETHOD.
ENDCLASS.