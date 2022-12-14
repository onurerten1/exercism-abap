CLASS zcl_darts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA area TYPE f.
ENDCLASS.


CLASS zcl_darts IMPLEMENTATION.
  METHOD score.
    " add solution here
    area = x ** 2 + y ** 2.

    result = COND #( WHEN area <= 100 AND area > 25 THEN 1
                     WHEN area <= 25 AND area > 1 THEN 5
                     WHEN area <= 1 AND area >= 0 THEN 10
                     ELSE 0 ).
  ENDMETHOD.
ENDCLASS.