CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_phone_number IMPLEMENTATION.
  METHOD clean.
    " add your code here
    result = number.

    REPLACE ALL OCCURRENCES OF '+' IN result WITH space.
    REPLACE ALL OCCURRENCES OF '(' IN result WITH space.
    REPLACE ALL OCCURRENCES OF ')' IN result WITH space.
    REPLACE ALL OCCURRENCES OF '-' IN result WITH space.
    REPLACE ALL OCCURRENCES OF '.' IN result WITH space.

    CONDENSE result NO-GAPS.

    IF strlen( result ) > 11 OR strlen( result ) < 10.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF strlen( result ) > 10.
      IF result+0(1) <> '1'.
        RAISE EXCEPTION NEW cx_parameter_invalid( ).
      ENDIF.
    ENDIF.

    IF result CN '0123456789'.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF strlen( result ) = 11.
      result = result+1(10).
      CONDENSE result.
    ENDIF.

    DO strlen( result ) TIMES.
      DATA(offset) = sy-index - 1.

      IF offset = 0 OR offset = 3.
        IF result+offset(1) CN '23456789'.
          RAISE EXCEPTION NEW cx_parameter_invalid( ).
        ENDIF.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.