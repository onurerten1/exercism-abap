CLASS zcl_armstrong_numbers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS is_armstrong_number IMPORTING num           TYPE i
                                RETURNING VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_armstrong_numbers IMPLEMENTATION.
  METHOD is_armstrong_number.
    "Implement solution
    DATA: total TYPE i.

    DATA(num_string) = CONV string( num ).
    num_string = replace( val = condense( num_string ) sub = space with = `` occ = 0 ).
    DATA(len) = strlen( num_string ).

    DO len TIMES.
      DATA(offset) = sy-index - 1.
      DATA(digit) = CONV i( num_string+offset(1) ).
      total += ipow( base = digit exp = len ).
    ENDDO.

    result = COND #( WHEN total = num THEN abap_true
                     ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.