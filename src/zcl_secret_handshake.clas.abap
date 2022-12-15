CLASS zcl_secret_handshake DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_commands
      IMPORTING code            TYPE i
      RETURNING VALUE(commands) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: line TYPE string,
        lines TYPE string_table.
ENDCLASS.



CLASS zcl_secret_handshake IMPLEMENTATION.

  METHOD get_commands.
    " add solution here
    CHECK code IS NOT INITIAL.
    DATA(value) = code.

    WHILE value > 0.
      DATA(remainder) = value MOD 2.
      IF remainder IS NOT INITIAL.
        IF sy-index = 5.
          DATA(reverse) = abap_true.
        ELSE.
          line = SWITCH #( sy-index
                           WHEN 1 THEN `wink`
                           WHEN 2 THEN `double blink`
                           WHEN 3 THEN `close your eyes`
                           WHEN 4 THEN `jump` ).
          APPEND line TO lines.
        ENDIF.
      ENDIF.
      value /= 2 - remainder.
    ENDWHILE.

    IF reverse = abap_true.
      DATA(len) = lines( lines ).
      DO lines( lines ) TIMES.
        APPEND lines[ len ] TO commands.
        len -= 1.
      ENDDO.
    ELSE.
      commands = lines.
    ENDIF.
  ENDMETHOD.

ENDCLASS.