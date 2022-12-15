CLASS zcl_crypto_square DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS encode IMPORTING plain_text         TYPE string
                   RETURNING VALUE(crypto_text) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_crypto_square IMPLEMENTATION.
  METHOD encode.
    "Implement Solution
    DATA: c TYPE i,
          r TYPE i,
          rectangle TYPE STANDARD TABLE OF string,
          word      TYPE string,
          row       TYPE string.

    DATA(new_text) = replace( val = to_lower( plain_text ) sub = space with = `` occ = 0 ).
    new_text = replace( val = new_text regex = `[^a-z0-9 ]` with = ``  occ = 0 ).
    CONDENSE new_text NO-GAPS.
    DATA(len) = strlen( new_text ).
    CHECK len > 0.

    WHILE c * r < len.
      IF r < c.
        r += 1.
      ELSE.
        c += 1.
      ENDIF.
    ENDWHILE.

    DO c TIMES.
      DATA(col) = sy-index - 1.
      DO r TIMES.
        DATA(offset) = ( sy-index - 1 ) * c + col.
        IF offset < len.
          crypto_text = |{ crypto_text }{ new_text+offset(1) }|.
        ELSE.
          crypto_text = |{ crypto_text } |.
        ENDIF.
      ENDDO.
      IF offset + 1 < c * r.
        crypto_text = |{ crypto_text } |.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.