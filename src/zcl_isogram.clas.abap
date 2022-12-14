CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
        IMPORTING
          VALUE(phrase)        TYPE string
        RETURNING
          VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_isogram IMPLEMENTATION.
  METHOD is_isogram.
    " add solution here
    DATA: letters TYPE TABLE OF string.

    DATA(length) = strlen( phrase ).

    DATA(word) = to_upper( phrase ).

    result = abap_true.

    DO length TIMES.
      DATA(offset) = sy-index - 1.
      IF word+offset(1) CO sy-abcde.
        IF line_exists( letters[ table_line = word+offset(1)  ] ).
          result = abap_false.
          EXIT.
        ELSE.
          APPEND word+offset(1) TO letters.
        ENDIF.
      ELSE.
        CONTINUE.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.