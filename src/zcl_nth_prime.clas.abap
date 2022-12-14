CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA prime_count TYPE i.
ENDCLASS.

CLASS zcl_nth_prime IMPLEMENTATION.
  METHOD prime.
    " add solution here
    IF input = 0.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    CLEAR prime_count.

    DATA(prime) = 1.

    DO.
      DATA(divisor) = prime - 1.
      DO.
        IF divisor = 0.
          EXIT.
        ELSEIF divisor = 1.
          prime_count += 1.
          EXIT.
        ELSE.
          IF prime MOD divisor = 0.
            EXIT.
          ELSE.
            divisor -= 1.
          ENDIF.
        ENDIF.
      ENDDO.

      IF prime_count = input.
        EXIT.
      ENDIF.
      prime += 1.
    ENDDO.

    result = prime.
  ENDMETHOD.
ENDCLASS.