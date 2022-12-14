CLASS zcl_minesweeper DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS
        annotate
          IMPORTING
            !input        TYPE string_table
          RETURNING
            VALUE(result) TYPE string_table.

  PRIVATE SECTION.
    TYPES ty_blank TYPE c LENGTH 1.
ENDCLASS.

CLASS zcl_minesweeper IMPLEMENTATION.
  METHOD annotate.
      " add solution here
    DATA: new_line         TYPE c LENGTH 255,
          new_line_string  TYPE string.

    LOOP AT input INTO DATA(line).
      CLEAR new_line.
      DATA(table_line) = sy-tabix.
      DO strlen( line ) TIMES.
        DATA(offset) = sy-index - 1.
        IF line+offset(1) = '*'.

          CONCATENATE new_line_string '*' INTO new_line_string RESPECTING BLANKS.
        ELSE.
          DATA(table_line_read) = table_line - 2.
          DO 3 TIMES.
            table_line_read += 1.
            IF table_line_read < 1.
              CONTINUE.
            ENDIF.
            DATA(line_offset) = offset - 2.
            DO 3 TIMES.
              line_offset += 1.
              IF line_offset >= 0 AND line_offset < strlen( line ).
                READ TABLE input INTO DATA(read_line) INDEX table_line_read.
                IF sy-subrc = 0 AND read_line+line_offset(1) = '*'.
                  DATA(count) += 1.
                ENDIF.
              ENDIF.
            ENDDO.
          ENDDO.
          new_line+offset(1) = SWITCH ty_blank( count
                                                WHEN 0 THEN ` `
                                                ELSE count ).
          CONCATENATE new_line_string new_line+offset(1) INTO new_line_string RESPECTING BLANKS.
          CLEAR count.
        ENDIF.
      ENDDO.

      APPEND new_line_string TO result.
      CLEAR new_line_string.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.