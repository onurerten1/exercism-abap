CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.

CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    " add solution here

    result = scores_list.
  ENDMETHOD.

  METHOD latest.
    " add solution here

    result = scores_list[ lines( scores_list ) ].
  ENDMETHOD.

  METHOD personalbest.
    " add solution here

    SORT scores_list DESCENDING.

    IF lines( scores_list ) <> 0.
      result = scores_list[ 1 ].
    ENDIF.
  ENDMETHOD.

  METHOD personaltopthree.
    " add solution here
    DATA: tab_line TYPE i.

    SORT scores_list DESCENDING.

    LOOP AT scores_list ASSIGNING FIELD-SYMBOL(<fs_score>).
      tab_line += 1.
      IF tab_line > 3.
        EXIT.
      ENDIF.
      APPEND <fs_score> TO result.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.