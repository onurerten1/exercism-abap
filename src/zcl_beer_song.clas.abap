CLASS zcl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_beer_song IMPLEMENTATION.

  METHOD recite.
    " add solution here
    DATA(lv_bottles) = CONV i( initial_bottles_count ).

    DO take_down_count TIMES.
      DATA(line) = COND #( WHEN lv_bottles > 1 THEN |{ lv_bottles } bottles of beer on the wall, { lv_bottles } bottles of beer.|
                           WHEN lv_bottles = 1 THEN |{ lv_bottles } bottle of beer on the wall, { lv_bottles } bottle of beer.|
                           ELSE |No more bottles of beer on the wall, no more bottles of beer.| ).
      APPEND line TO result.
      lv_bottles -= 1.
      line =  COND #( WHEN lv_bottles > 1 THEN |Take one down and pass it around, { lv_bottles } bottles of beer on the wall.|
                      WHEN lv_bottles = 1 THEN |Take one down and pass it around, { lv_bottles } bottle of beer on the wall.|
                      WHEN lv_bottles = 0 THEN |Take it down and pass it around, no more bottles of beer on the wall.|
                      ELSE |Go to the store and buy some more, 99 bottles of beer on the wall.| ).
      APPEND line TO result.
      IF sy-index <> take_down_count.
        APPEND space TO result.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.