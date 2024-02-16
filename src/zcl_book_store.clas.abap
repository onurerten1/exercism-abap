CLASS zcl_book_store DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! ID of book to buy from 1 to 5
    TYPES book_id     TYPE i.

    TYPES basket_type TYPE SORTED TABLE OF book_id WITH NON-UNIQUE KEY table_line.

    TYPES total       TYPE p LENGTH 3 DECIMALS 2.

    "! @parameter basket | E.g., buying two copies of the first book and one copy of the second book
    "!                     is equivalent to ( ( 1 ) ( 1 ) ( 2 ) )
    "! @parameter total |
    METHODS calculate_total
      IMPORTING basket       TYPE basket_type
      RETURNING VALUE(total) TYPE total.

  PRIVATE SECTION.
    CONSTANTS book_price TYPE total VALUE 8.

    TYPES: BEGIN OF book_count_type,
             book  TYPE book_id,
             count TYPE i,
           END OF book_count_type.
    TYPES: BEGIN OF book_discount_type,
             books  TYPE i,
             amount TYPE total,
           END OF book_discount_type.

    DATA book_count    TYPE TABLE OF book_count_type.
    DATA book_discount TYPE TABLE OF book_discount_type.
ENDCLASS.


CLASS zcl_book_store IMPLEMENTATION.
  METHOD calculate_total.
    DATA costs TYPE total.

    book_count = VALUE #( ( book = 1 )
                          ( book = 2 )
                          ( book = 3 )
                          ( book = 4 )
                          ( book = 5 ) ).

    book_discount = VALUE #( ( books = 1 amount = 1 - 0 )
                             ( books = 2 amount = 1 - ( 5 / 100 ) )
                             ( books = 3 amount = 1 - ( 10 / 100 ) )
                             ( books = 4 amount = 1 - ( 20 / 100 ) )
                             ( books = 5 amount = 1 - ( 25 / 100 ) ) ).
    SORT book_discount BY books DESCENDING.

    total = 999.

    LOOP AT basket INTO DATA(book_id).
      book_count[ book = book_id ]-count += 1.
    ENDLOOP.

    DATA(group_size) = 5.

    WHILE group_size > 0.
      DATA(volumes) = book_count.
      costs = 0.

      LOOP AT book_discount INTO DATA(discount) WHERE books <= group_size.
        DO.
          DATA(remaining_books) = 0.
          LOOP AT volumes TRANSPORTING NO FIELDS WHERE count > 0.
            remaining_books += 1.
          ENDLOOP.
          IF remaining_books < discount-books.
            EXIT.
          ENDIF.

          SORT volumes BY count DESCENDING.
          DO discount-books TIMES.
            volumes[ sy-index ]-count -= 1.
          ENDDO.
          costs += book_price * discount-books * discount-amount.
        ENDDO.
      ENDLOOP.

      total = nmin( val1 = total
                    val2 = costs ).
      group_size -= 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.