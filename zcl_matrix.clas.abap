CLASS zcl_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS matrix_row
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
    METHODS matrix_column
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_matrix IMPLEMENTATION.
  METHOD matrix_row.
    " add solution here
    SPLIT string AT '\n' INTO TABLE DATA(lt_string).
    DATA(ls_row) = lt_string[ index ].
    SPLIT ls_row AT ' ' INTO TABLE DATA(lt_row).
    LOOP AT lt_row ASSIGNING FIELD-SYMBOL(<fs_row>).
      APPEND <fs_row> TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD matrix_column.
    " add solution here
    SPLIT string AT '\n' INTO TABLE DATA(lt_string).
    LOOP AT lt_string INTO DATA(ls_string).
      SPLIT ls_string AT ' ' INTO TABLE DATA(lt_row).
      APPEND lt_row[ index ] TO result.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.