CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
        IMPORTING
          input         TYPE string OPTIONAL
        RETURNING
          VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
      " add solution here
    DATA: pos TYPE i.

    DATA(input_value) = input.
    TRANSLATE input_value TO UPPER CASE.

    DATA(lv_length) = strlen( input ).

    pos = -1.

    DO lv_length TIMES.
      pos += 1.
      CASE input_value+pos(1).
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
          result += 1.
        WHEN 'D' OR 'G'.
          result += 2.
        WHEN 'B' OR'C' OR'M' OR'P'.
          result += 3.
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
          result += 4.
        WHEN 'K'.
          result += 5.
        WHEN 'J' OR 'X'.
          result += 8.
        WHEN 'Q' OR 'Z'.
          result += 10.
      ENDCASE.
    ENDDO.
  ENDMETHOD.

ENDCLASS.