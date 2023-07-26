SCHEMA library

PUBLIC TYPE t_book RECORD LIKE book.*
PUBLIC TYPE t_book_array DYNAMIC ARRAY OF t_book

PRIVATE CONSTANT ID_UNKNOWN = 100

MAIN

    DEFINE books t_book_array
    DEFINE brec t_book
    DEFINE f_plot LIKE book.b_plot

    CONNECT TO "mylib"

    OPEN FORM f1 FROM "form"
    DISPLAY FORM f1

    CALL fill_book_array(books)

    DIALOG ATTRIBUTES(UNBUFFERED)

    DISPLAY ARRAY books TO sr1.*

        BEFORE ROW
            LET f_plot = books[ arr_curr() ].b_plot

        ON ACTION nbrows ATTRIBUTES(TEXT="Row count")
            MESSAGE SFMT("Number of books: %1",books.getLength())

        ON INSERT
            LET f_plot = NULL
            INITIALIZE brec.* TO NULL
            LET brec.b_author = ID_UNKNOWN
            LET brec.b_pub_date = TODAY
            LET brec.b_price = 0
            INPUT brec.* FROM sr1[ scr_line() ].*
                  ATTRIBUTES(WITHOUT DEFAULTS);
            IF NOT int_flag THEN
                TRY
                    INSERT INTO book VALUES brec.*
                    LET brec.book_id = sqlca.sqlerrd[2]
                    LET books[ DIALOG.getCurrentRow("sr1") ] = brec
                    MESSAGE SFMT("New book record created (id=%1)",brec.book_id)
                CATCH
                    ERROR "Could not insert new book row into database:", SQLERRMESSAGE
                END TRY
            END IF

        ON DELETE
            IF mbox_yn("Delete the current row?") THEN
                TRY
                    DELETE FROM book WHERE book_id = books[arr_curr()].book_id
                    MESSAGE "Book record was deleted"
                CATCH
                    ERROR "Could not delete the book row from database:", SQLERRMESSAGE
                END TRY
            END IF

    END DISPLAY

    INPUT BY NAME f_plot

        ON ACTION clear_plot ATTRIBUTES(TEXT="Clear")
            IF NOT mbox_yn("Are you sure you want to clear the plot summary?") THEN
                CONTINUE DIALOG
            END IF
            LET f_plot = NULL
            LET books[ arr_curr() ].b_plot = NULL
            UPDATE book SET b_plot = NULL
             WHERE book_id = books[ arr_curr() ].book_id

        ON ACTION update_plot ATTRIBUTES(TEXT="Save")
            LET books[ arr_curr() ].b_plot = f_plot
            UPDATE book SET b_plot = f_plot
             WHERE book_id = books[ arr_curr() ].book_id
            MESSAGE SFMT("Plot summary saved (%1)",CURRENT HOUR TO SECOND)

    END INPUT

    ON ACTION close
        ACCEPT DIALOG

    END DIALOG

END MAIN

PRIVATE FUNCTION mbox_yn(question STRING) RETURNS BOOLEAN
     DEFINE r BOOLEAN
     MENU "Books" ATTRIBUTES(STYLE="dialog", COMMENT=question)
         COMMAND "Yes" LET r = TRUE
         COMMAND "No"  LET r = FALSE
     END MENU
     RETURN r
END FUNCTION

FUNCTION fill_book_array(ba t_book_array)
    RETURNS ()

    DEFINE x INTEGER

    DECLARE c1 CURSOR FOR
      SELECT * FROM book ORDER BY b_title

    LET x = 1
    FOREACH c1 INTO ba[x].*
        LET x = x + 1
    END FOREACH
    CALL ba.deleteElement(x)

END FUNCTION

FUNCTION init_authors(e ui.ComboBox)
    RETURNS ()

    DEFINE id LIKE author.auth_id
    DEFINE name LIKE author.a_name

    DECLARE c2 CURSOR FOR
     SELECT auth_id, a_name FROM author ORDER BY a_name

    FOREACH c2 INTO id, name
        CALL e.addItem( id, name )
    END FOREACH

END FUNCTION
