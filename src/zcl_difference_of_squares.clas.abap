CLASS zcl_difference_of_squares DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      ret_difference_of_squares IMPORTING num         TYPE i
                                RETURNING VALUE(diff) TYPE i,
      ret_sum_of_squares        IMPORTING num                   TYPE i
                                RETURNING VALUE(sum_of_squares) TYPE i,
      ret_square_of_sum         IMPORTING num                  TYPE i
                                RETURNING VALUE(square_of_sum) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_difference_of_squares IMPLEMENTATION.
  METHOD ret_difference_of_squares.
    "Implement solution
    diff = ret_square_of_sum( num ) - ret_sum_of_squares( num ).
  ENDMETHOD.

  METHOD ret_sum_of_squares.
    "Implement solution
    sum_of_squares = REDUCE i( INIT s = 0
                               FOR i = 1 UNTIL i > num
                               NEXT s += i ** 2 ).
  ENDMETHOD.

  METHOD ret_square_of_sum.
    "Implement solution
    square_of_sum = REDUCE i( INIT s = 0
                              FOR i = 1 UNTIL i > num
                              NEXT s += i ) ** 2.
  ENDMETHOD.
ENDCLASS.