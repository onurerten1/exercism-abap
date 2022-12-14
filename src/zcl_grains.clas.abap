CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
    " add solution here
    IF input <= 0 OR input > 64.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.
    result = ipow( base = 2
                   exp  = input - 1 ).
  ENDMETHOD.

  METHOD total.
    " add solution here
    result = ipow( base = 2
                   exp = REDUCE i( INIT s = 0
                                    FOR i = 0 UNTIL i > 63
                                    NEXT s += 1 ) ).
  ENDMETHOD.


ENDCLASS.