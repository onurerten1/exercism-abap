CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: group_data_type TYPE STANDARD TABLE OF group WITH EMPTY KEY.
    DATA: group_data TYPE group_data_type.
ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    " add solution here
    DATA: count    TYPE i,
          sum      TYPE i,
          min      TYPE i,
          max      TYPE i,
          average  TYPE f.

    group_data = VALUE #( FOR initial IN initial_numbers
                          ( initial-group ) ).
    SORT group_data.
    DELETE ADJACENT DUPLICATES FROM group_data.

    LOOP AT group_data INTO DATA(group).
      CLEAR: count,
           sum,
           min,
           max,
           average.

      LOOP AT initial_numbers INTO DATA(initial_number) WHERE group = group.
        count += 1.
        sum += initial_number-number.
        min = COND #( WHEN min = 0  THEN initial_number-number
                    WHEN initial_number-number < min THEN initial_number-number
                    ELSE min ).
        max = COND #( WHEN initial_number-number > max THEN initial_number-number
                    ELSE max ).
      ENDLOOP.
      average = sum / count.

      APPEND VALUE #( group     = group
                      count     = count
                      sum       = sum
                      min       = min
                      max       = max
                      average   = average ) TO aggregated_data.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.