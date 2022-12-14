CLASS zcl_prime_factors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_prime_factors IMPLEMENTATION.
  METHOD factors.
    " add solution here
    DATA(factor) = 2.
    DATA(value) = input.
    DO.
      IF value = 1.
        EXIT.
      ENDIF.
      IF value MOD factor = 0.
        APPEND factor TO result.
        value /= factor.
      ELSE.
        factor += 1.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.