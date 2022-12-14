CLASS zcl_word_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure,
      return_table TYPE STANDARD TABLE OF return_structure WITH KEY word.
    METHODS count_words
      IMPORTING
        !phrase       TYPE string
      RETURNING
        VALUE(result) TYPE return_table .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_word_count IMPLEMENTATION.

  METHOD count_words.
    "Add solution here
    DATA(new_phrase) = replace( val = to_lower( phrase ) sub = `'` with = `` occ = 0 ).
    new_phrase = replace( val = new_phrase sub = `\n` with = ` ` occ = 0 ).
    new_phrase = replace( val = new_phrase sub = `\t` with = ` ` occ = 0 ).
    new_phrase = replace( val = new_phrase regex = `[^a-z0-9]` with = ` ` occ = 0 ).
    SPLIT condense( new_phrase ) AT ` ` INTO TABLE DATA(words).

    LOOP AT words INTO DATA(word).
      READ TABLE result ASSIGNING FIELD-SYMBOL(<result>) WITH TABLE KEY word = word.
      IF sy-subrc = 0.
        <result>-count += 1.
      ELSE.
        APPEND VALUE #( word  = word
                        count = 1 ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.