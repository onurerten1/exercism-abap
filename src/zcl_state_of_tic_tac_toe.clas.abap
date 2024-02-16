CLASS zcl_state_of_tic_tac_toe DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES player_type TYPE c LENGTH 1.
    "! E.g., ( ( `XOO` ) ( ` X ` ) ( `  X` ) )
    TYPES board_type  TYPE TABLE OF string INITIAL SIZE 3.

    CONSTANTS: BEGIN OF player_enum,
                 one TYPE player_type VALUE 'X',
                 two TYPE player_type VALUE 'O',
               END OF player_enum.

    CONSTANTS: BEGIN OF state_enum,
                 ongoing_game TYPE string VALUE `Ongoing game`,
                 draw         TYPE string VALUE `Draw`,
                 win          TYPE string VALUE `Win`,
               END OF state_enum.
    "! @parameter board |

    "! @parameter state                | Possible values are enumerated in state_enum
    "! @raising   cx_parameter_invalid | Board is invalid
    METHODS get_state
      IMPORTING board        TYPE board_type
      RETURNING VALUE(state) TYPE string
      RAISING   cx_parameter_invalid.
ENDCLASS.


CLASS zcl_state_of_tic_tac_toe IMPLEMENTATION.
  METHOD get_state.
    DATA(final_board) = concat_lines_of( board ).
    DATA(player_one) = count( val = final_board
                              sub = player_enum-one ).
    DATA(player_two) = count( val = final_board
                              sub = player_enum-two ).

    IF strlen( final_board ) <> 9.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF final_board NA 'XO '.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF player_one - player_two > 1 OR player_two - player_one > 1.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    DATA(total_wins) = VALUE i( ).

    DO 2 TIMES.
      DATA(win) = VALUE abap_bool( ).
      DATA(player) = COND player_type( WHEN sy-index = 1 THEN player_enum-one ELSE player_enum-two ).

      DO 3 TIMES.
        IF count( val = board[ sy-index ]
                  sub = player ) = 3.
          win = abap_true.
        ENDIF.
      ENDDO.

      DO 3 TIMES.
        IF count( val = CONV string( |{ substring( val = board[ 1 ]
                                                   off = sy-index - 1
                                                   len = 1 ) }| &&
                                     |{ substring( val = board[ 2 ]
                                                   off = sy-index - 1
                                                   len = 1 ) }| &&
                                     |{ substring( val = board[ 3 ]
                                                   off = sy-index - 1
                                                   len = 1 ) }| )
                  sub = player ) = 3.
          win = abap_true.
        ENDIF.
      ENDDO.

      IF count( val = CONV string( |{ substring( val = board[ 1 ]
                                                 off = 0
                                                 len = 1 ) }| &&
                                    |{ substring( val = board[ 2 ]
                                                  off = 1
                                                  len = 1 ) }| &&
                                    |{ substring( val = board[ 3 ]
                                                  off = 2
                                                  len = 1 ) }| )
                sub = player ) = 3.
        win = abap_true.
      ENDIF.

      IF count( val = CONV string( |{ substring( val = board[ 1 ]
                                                 off = 2
                                                 len = 1 ) }| &&
                                    |{ substring( val = board[ 2 ]
                                                  off = 1
                                                  len = 1 ) }| &&
                                    |{ substring( val = board[ 3 ]
                                                  off = 0
                                                  len = 1 ) }| )
                sub = player ) = 3.
        win = abap_true.
      ENDIF.

      IF win = abap_true.
        total_wins += 1.
      ENDIF.
    ENDDO.

    IF total_wins > 1.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ENDIF.

    IF total_wins = 1.
      state = state_enum-win.
      RETURN.
    ENDIF.

    IF player_one + player_two = 9.
      state = state_enum-draw.
    ELSEIF player_one < player_two.
      RAISE EXCEPTION NEW cx_parameter_invalid( ).
    ELSE.
      state = state_enum-ongoing_game.
    ENDIF.
  ENDMETHOD.
ENDCLASS.