CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
        IMPORTING
          first_strand  TYPE string
          second_strand TYPE string
        RETURNING
          VALUE(result) TYPE i
        RAISING
          cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
      " add solution here
    IF strlen( first_strand ) <> strlen( second_strand ).
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ELSEIF first_strand IS INITIAL AND second_strand IS INITIAL.
      result = 0.
    ELSE.
      DATA(length) = strlen( first_strand ).
      DO length TIMES.
        DATA(offset) = sy-index - 1.
        IF first_strand+offset(1) <> second_strand+offset(1).
          result += 1.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.

ENDCLASS.