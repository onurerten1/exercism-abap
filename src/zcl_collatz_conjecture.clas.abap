CLASS zcl_collatz_conjecture DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS ret_steps IMPORTING num          TYPE i
                      RETURNING VALUE(steps) TYPE i
                      RAISING   cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_collatz_conjecture IMPLEMENTATION.
  METHOD ret_steps.
    "Implement Solution
    DATA(active_value) = num.

    IF active_value <= 0.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ELSE.
      WHILE active_value <> 1.
        IF active_value MOD 2 = 0.
          active_value /= 2.
        ELSE.
          active_value *= 3 + 1.
        ENDIF.
        steps += 1.
      ENDWHILE.
    ENDIF.
  ENDMETHOD.
ENDCLASS.