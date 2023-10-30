CLASS zcl_triangle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS is_equilateral
      IMPORTING side_a        TYPE f
                side_b        TYPE f
                side_c        TYPE f
      RETURNING VALUE(result) TYPE abap_bool
      RAISING   cx_parameter_invalid.

    METHODS is_isosceles
      IMPORTING side_a        TYPE f
                side_b        TYPE f
                side_c        TYPE f
      RETURNING VALUE(result) TYPE abap_bool
      RAISING   cx_parameter_invalid.

    METHODS is_scalene
      IMPORTING side_a        TYPE f
                side_b        TYPE f
                side_c        TYPE f
      RETURNING VALUE(result) TYPE abap_bool
      RAISING   cx_parameter_invalid.

    METHODS is_triangle_vaild
      IMPORTING side_a        TYPE f
                side_b        TYPE f
                side_c        TYPE f
      RETURNING VALUE(result) TYPE abap_bool.

ENDCLASS.


CLASS zcl_triangle IMPLEMENTATION.
  METHOD is_equilateral.
    FINAL(valid) = is_triangle_vaild( side_a = side_a
                                      side_b = side_b
                                      side_c = side_c ).

    IF valid = abap_false.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF ( side_a = side_b ) AND ( side_a = side_c ) AND ( side_b = side_c ).
      result = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_isosceles.
    FINAL(valid) = is_triangle_vaild( side_a = side_a
                                      side_b = side_b
                                      side_c = side_c ).

    IF valid = abap_false.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF ( side_a = side_b ) OR ( side_a = side_c ) OR ( side_b = side_c ).
      result = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_scalene.
    FINAL(valid) = is_triangle_vaild( side_a = side_a
                                      side_b = side_b
                                      side_c = side_c ).

    IF valid = abap_false.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF ( side_a <> side_b ) AND ( side_a <> side_c ) AND ( side_b <> side_c ).
      result = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_triangle_vaild.
    IF side_a <= 0 OR side_b <= 0 OR side_c <= 0.
      result = abap_false.
    ELSEIF ( side_a + side_b >= side_c ) AND ( side_a + side_c >= side_b ) AND ( side_b + side_c >= side_a ).
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.