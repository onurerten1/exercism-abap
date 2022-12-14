CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.
ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.


  METHOD plants.
    " add solution here
    DATA: order TYPE i,
          order_1 TYPE i,
          order_2 TYPE i.
    DATA: row_1 TYPE string,
          row_2 TYPE string.

    students = VALUE #( ( |Alice| )
                    ( |Bob| )
                    ( |Charlie| )
                    ( |David| )
                    ( |Eve| )
                    ( |Fred| )
                    ( |Ginny| )
                    ( |Harriet| )
                    ( |Ileana| )
                    ( |Joseph| )
                    ( |Kincaid| )
                    ( |Larry| ) ).

    READ TABLE students TRANSPORTING NO FIELDS WITH KEY table_line = student.
    order = sy-tabix.

    SPLIT diagram AT '\' INTO row_1 row_2.
    row_2(1) = ' '.
    CONDENSE row_2.

    order -= 1.
    order *= 2.
    order_1 = order.
    order_2 = order.

    DO 2 TIMES.
      APPEND SWITCH #( row_1+order_1(1)
                   WHEN 'V' THEN 'violets'
                   WHEN 'C' THEN 'clover'
                   WHEN 'G' THEN 'grass'
                   WHEN 'R' THEN 'radishes' ) TO results.
      order_1 += 1.
    ENDDO.

    DO 2 TIMES.
      APPEND SWITCH #( row_2+order_2(1)
                   WHEN 'V' THEN 'violets'
                   WHEN 'C' THEN 'clover'
                   WHEN 'G' THEN 'grass'
                   WHEN 'R' THEN 'radishes' ) TO results.
      order_2 += 1.
    ENDDO.

  ENDMETHOD.


ENDCLASS.