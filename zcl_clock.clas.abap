CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.

* add solution here
    DATA: hour_comp TYPE i,
        minute_comp TYPE i.
    DATA: hour_string TYPE c LENGTH 2,
        minute_string TYPE c LENGTH 2.
ENDCLASS.



CLASS zcl_clock IMPLEMENTATION.

  METHOD add.
* add solution here
    IF minutes < 0.
      sub( abs( minutes ) ).
    ELSE.
      minute_comp += minutes.

      WHILE minute_comp > 60.
        minute_comp -= 60.
        hour_comp += 1.
      ENDWHILE.

      WHILE hour_comp > 24.
        hour_comp = hour_comp MOD 24.
      ENDWHILE.

      IF hour_comp = 24.
        hour_comp = 0.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.
* add solution here
    DATA(hour_process) = hours.
    DATA(minute_process) = minutes.

    WHILE minute_process < 0.
      minute_process += 60.
      hour_process -= 1.
    ENDWHILE.

    WHILE hour_process < 0.
      hour_process += 24.
    ENDWHILE.

    IF minutes IS NOT INITIAL.
      WHILE minute_process > 60.
        minute_process -= 60.
        hour_process += 1.
      ENDWHILE.
      minute_comp = minute_process.
    ENDIF.

    IF minute_comp = 60.
      minute_comp = 0.
      hour_process += 1.
    ENDIF.

    WHILE hour_process > 24.
      hour_process -= 24.
    ENDWHILE.
    hour_comp = hour_process.

    IF hour_comp = 24.
      hour_comp = 0.
    ENDIF.

  ENDMETHOD.


  METHOD get.
* add solution here
    hour_comp = hour_comp MOD 24.

    IF hour_comp < 10.
      hour_string = |0{ hour_comp }|.
    ELSE.
      hour_string = hour_comp.
    ENDIF.

    IF minute_comp < 10.
      minute_string = |0{ minute_comp }|.
    ELSE.
      minute_string = minute_comp.
    ENDIF.

    result = |{ hour_string }:{ minute_string }|.
  ENDMETHOD.


  METHOD sub.
* add solution here
    IF minutes < 0.
      add( abs( minutes ) ).
    ELSE.
      DATA(minute_process) = minutes.

      WHILE minute_process > 60.
        minute_process -= 60.
        IF hour_comp = 0.
          hour_comp = 24.
        ENDIF.
        hour_comp -= 1.
      ENDWHILE.

      IF minute_process < minute_comp.
        minute_comp -= minute_process.
      ELSE.
        IF minute_comp = 0.
          minute_comp = 60.
          minute_comp -= minute_process.
          IF hour_comp = 0.
            hour_comp = 24.
          ENDIF.
          hour_comp -= 1.
        ELSE.
          IF hour_comp = 0.
            hour_comp = 24.
          ENDIF.
          hour_comp -= 1.
          minute_comp = 60 - ( minute_process - minute_comp ).
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.