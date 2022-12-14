CLASS zcl_rle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

ENDCLASS.

CLASS zcl_rle IMPLEMENTATION.
  METHOD encode.

    "Add solution here
    DATA: letter       TYPE c,
          occurence    TYPE i,
          offset_value TYPE c.

    DO strlen( input ) TIMES.
      DATA(offset) = sy-index - 1.
      offset_value = input+offset(1).

      IF offset_value <> letter.
        IF occurence = 1.
          IF letter IS INITIAL.
            result = |{ result } |.
          ELSE.
            result = |{ result }{ letter }|.
          ENDIF.
        ELSEIF occurence <> 0.
          IF letter IS INITIAL.
            result = |{ result }{ occurence } |.
          ELSE.
            result = |{ result }{ occurence }{ letter }|.
          ENDIF.
        ENDIF.
        CLEAR: letter, occurence.
      ENDIF.

      occurence += 1.
      letter = offset_value.
    ENDDO.
    IF sy-subrc = 0.
      IF occurence = 1.
        result = |{ result }{ letter }|.
      ELSEIF occurence <> 0.
        result = |{ result }{ occurence }{ letter }|.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD decode.
    "Add solution here
    DATA: letter    TYPE c,
          occurence TYPE string.

    DO strlen( input ) TIMES.
      DATA(offset) = sy-index - 1.

      IF input+offset(1) CO '0123456789'.
        occurence = |{ occurence }{ input+offset(1) }|.
      ELSE.
        IF CONV i( occurence ) = 0.
          result = |{ result }{ input+offset(1) }|.
        ELSE.
          DO CONV i( occurence ) TIMES.
            result = |{ result }{ input+offset(1) }|.
          ENDDO.
        ENDIF.

        CLEAR occurence.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.