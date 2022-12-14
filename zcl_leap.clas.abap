CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
        IMPORTING
          year          TYPE i
        RETURNING
          VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.
    " add solution here
    DATA(mod) = year MOD 4.
    IF mod = 0.
      mod = year MOD 100.
      IF mod = 0.
        mod = year MOD 400.
        IF mod = 0.
          result = abap_true.
        ELSE.
          result = abap_false.
        ENDIF.
      ELSE.
        result = abap_true.
      ENDIF.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.