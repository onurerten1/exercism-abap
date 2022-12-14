CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS decode
        IMPORTING
          cipher_text TYPE string
        RETURNING
          VALUE(plain_text)  TYPE string .
    METHODS encode
        IMPORTING
          plain_text        TYPE string
        RETURNING
          VALUE(cipher_text) TYPE string.
    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: plains      TYPE string_table,
          ciphers     TYPE string_table,
          text_length TYPE i.
ENDCLASS.

CLASS zcl_atbash_cipher IMPLEMENTATION.
  METHOD constructor.
    DATA(plain) = to_lower( sy-abcde ).
    DATA(cipher) = reverse( to_lower( sy-abcde ) ).

    DO strlen( plain ) TIMES.
      DATA(offset) = sy-index - 1.
      APPEND plain+offset(1) TO plains.
    ENDDO.

    DO strlen( cipher ) TIMES.
      offset = sy-index - 1.
      APPEND cipher+offset(1) TO ciphers.
    ENDDO.
  ENDMETHOD.

  METHOD decode.
    "todo
    DATA(text) = to_lower( cipher_text ).
    CONDENSE text NO-GAPS.

    DO strlen( text ) TIMES.
      DATA(offset) = sy-index - 1.
      READ TABLE ciphers TRANSPORTING NO FIELDS WITH KEY table_line = text+offset(1).
      IF sy-subrc = 0.
        READ TABLE plains INTO DATA(plain) INDEX sy-tabix.
        plain_text = |{ plain_text }{ plain }|.
        text_length += 1.
      ELSEIF text+offset(1) CO '0123456789'.
        plain_text = |{ plain_text }{ text+offset(1) }|.
      ENDIF.
    ENDDO.
    CONDENSE plain_text.
  ENDMETHOD.

  METHOD encode.
    "todo
    DATA(text) = to_lower( plain_text ).
    CONDENSE text NO-GAPS.

    DO strlen( text ) TIMES.
      IF text_length >= 5 AND text_length MOD 5 = 0.
        cipher_text = |{ cipher_text } |.
      ENDIF.
      DATA(offset) = sy-index - 1.
      READ TABLE plains TRANSPORTING NO FIELDS WITH KEY table_line = text+offset(1).
      IF sy-subrc = 0.
        READ TABLE ciphers INTO DATA(cipher) INDEX sy-tabix.
        cipher_text = |{ cipher_text }{ cipher }|.
        text_length += 1.
      ELSEIF text+offset(1) CO '0123456789'.
        cipher_text = |{ cipher_text }{ text+offset(1) }|.
        text_length += 1.
      ENDIF.
    ENDDO.
    CONDENSE cipher_text.
  ENDMETHOD.
ENDCLASS.