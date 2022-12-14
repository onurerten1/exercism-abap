CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS word_to_table
      IMPORTING
        input TYPE string
      RETURNING
        VALUE(letters) TYPE string_table.
ENDCLASS.

CLASS zcl_anagram IMPLEMENTATION.
  METHOD anagram.
* add solution here
    DATA(input_word) = input.
    TRANSLATE input_word TO LOWER CASE.
    DATA(input_letters) = word_to_table( input_word ).

    LOOP AT candidates INTO DATA(candidate).
      DATA(candidate_word) = candidate.
      TRANSLATE candidate_word TO LOWER CASE.
      IF strlen( input ) <> strlen( candidate ).
        CONTINUE.
      ELSEIF candidate_word = input_word.
        CONTINUE.
      ELSE.
        DATA(candidate_letters) = word_to_table( candidate_word ).
        IF candidate_letters = input_letters.
          APPEND candidate TO result.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD word_to_table.
    DO strlen( input ) TIMES.
      DATA(offset) = sy-index - 1.

      APPEND input+offset(1) TO letters.
    ENDDO.
    SORT letters.
  ENDMETHOD.
ENDCLASS.