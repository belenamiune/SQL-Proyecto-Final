-- Created by belenamiune (https://github.com/belenamiune)

USE library;

DROP PROCEDURE IF EXISTS sp_AddNewBook;
DROP PROCEDURE IF EXISTS sp_LoanBook;
DROP PROCEDURE IF EXISTS sp_ReturnBook;
DROP PROCEDURE IF EXISTS sp_GetUserLoans;
DROP PROCEDURE IF EXISTS sp_GetPopularBooks;

USE library;


-- Store procedures:

DELIMITER //

-- Stored Procedure: sp_AddNewBook
-- Objetivo: Agregar un nuevo libro a la base de datos, asegurando que se proporciona toda la información necesaria.
CALL sp_AddNewBook('Nuevo Libro', 1, 2, 1);
CREATE PROCEDURE sp_AddNewBook(
    IN bookTitle VARCHAR(255),
    IN categoryID INT,
    IN editoryID INT,
    IN available TINYINT(1)
)
BEGIN
    INSERT INTO BOOK (Title, Category_ID, Editory_ID, Available)
    VALUES (bookTitle, categoryID, editoryID, available);
END//

DELIMITER ;

DELIMITER //


-- Stored Procedure: sp_LoanBook
-- Objetivo: Procesar un nuevo préstamo de libro, verificando la disponibilidad y registrando la fecha de préstamo.
-- Ejemplo: CALL sp_LoanBook(2,2);
CREATE PROCEDURE sp_LoanBook(
    IN userID INT,
    IN bookID INT
)
BEGIN
    DECLARE loanDate DATE;
    DECLARE isAvailable TINYINT(1);  -- Variable para almacenar la disponibilidad

    -- Verificar disponibilidad usando fn_IsBookAvailable
    SET isAvailable = fn_IsBookAvailable(bookID);
    
    IF isAvailable THEN
        SET loanDate = CURDATE();
        INSERT INTO LOAN (User_ID, Book_ID, Loan_Date, Return_Date)
        VALUES (userID, bookID, loanDate, NULL);
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El libro no está disponible para préstamo';
    END IF;
END//

DELIMITER ;

DELIMITER //



-- Stored Procedure: sp_ReturnBook
-- Objetivo: Procesar la devolución de un libro, actualizando la fecha de devolución en la tabla de préstamos.
-- Ejemplo: CALL sp_ReturnBook(5);
CREATE PROCEDURE sp_ReturnBook(
 IN loanID INT
)
BEGIN
    DECLARE loanDate DATE;

    -- Obtener la fecha de préstamo
    SELECT Loan_Date INTO loanDate
    FROM LOAN
    WHERE Loan_ID = loanID;

    -- Validar que la fecha de devolución no sea anterior a la de préstamo
    IF CURDATE() < loanDate THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La fecha de devolución no puede ser anterior a la fecha de préstamo';
    ELSE
        UPDATE LOAN
        SET Return_Date = CURDATE()
        WHERE Loan_ID = loanID AND Return_Date IS NULL;
    END IF;
END//

DELIMITER ;


DELIMITER //
-- Stored Procedure: sp_GetUserLoans
-- Objetivo: Obtener todos los préstamos de un usuario específico, devolviendo resultados en un conjunto de resultados.
-- Ejemplo: CALL sp_GetUserLoans(2);
CREATE PROCEDURE sp_GetUserLoans(
    IN userID INT
)
BEGIN
    SELECT 
        u.User_Name, 
        b.Title, 
        l.Loan_Date, 
        l.Return_Date
    FROM 
        LOAN l
    JOIN 
        USER u ON l.User_ID = u.User_ID
    JOIN 
        BOOK b ON l.Book_ID = b.Book_ID
    WHERE 
        u.User_ID = userID;
END//

DELIMITER ;



-- Stored Procedure: sp_GetPopularBooks
-- Objetivo: Obtener los libros más prestados, utilizando un parámetro para limitar la cantidad de resultados.
-- Ejemplo: CALL sp_GetPopularBooks(2);
DELIMITER //

CREATE PROCEDURE sp_GetPopularBooks(
    IN resultLimit INT
)
BEGIN
    SELECT 
        b.Title, 
        COUNT(l.Loan_ID) AS Times_Loaned
    FROM 
        BOOK b
    LEFT JOIN 
        LOAN l ON b.Book_ID = l.Book_ID
    GROUP BY 
        b.Book_ID
    ORDER BY 
        Times_Loaned DESC
    LIMIT resultLimit;
END//

DELIMITER ;
