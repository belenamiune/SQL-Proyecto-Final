-- Created by belenamiune (https://github.com/belenamiune)

USE library;

DROP FUNCTION IF EXISTS fn_GetUserLoanCount;
DROP FUNCTION IF EXISTS fn_IsBookAvailable;
DROP FUNCTION IF EXISTS fn_GetLateFees;
DROP FUNCTION IF EXISTS fn_GetTotalBooksInCategory;
DROP FUNCTION IF EXISTS fn_GetPopularBooks;

-- Functions:

DELIMITER //

-- Function: fn_GetUserLoanCount
CREATE FUNCTION fn_GetUserLoanCount(userID INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE loanCount INT DEFAULT 0; -- Valor por defecto
    SELECT COUNT(*) INTO loanCount
    FROM LOAN
    WHERE User_ID = userID;
    RETURN loanCount;
END//

DELIMITER ;

DELIMITER //

-- Function: fn_IsBookAvailable
-- Objetivo: Devuelve un valor booleano indicando si un libro específico está disponible para préstamo.
CREATE FUNCTION fn_IsBookAvailable(bookID INT)
RETURNS TINYINT(1)  -- Cambiado BOOLEAN a TINYINT(1)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE available TINYINT(1);  -- Cambiado BOOLEAN a TINYINT(1)
    SELECT COUNT(*) = 0 INTO available
    FROM LOAN
    WHERE Book_ID = bookID AND Return_Date IS NULL; 
    RETURN available;
END//

DELIMITER ;

DELIMITER //

-- Function: fn_GetLateFees
-- Objetivo: Calcula y devuelve las tarifas por atraso para un préstamo específico.
CREATE FUNCTION fn_GetLateFees(loanID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE lateFee DECIMAL(10,2) DEFAULT 0;  -- Inicializa lateFee
    DECLARE daysLate INT DEFAULT 0;  -- Inicializa daysLate
    DECLARE returnDate DATE;

    SELECT Return_Date INTO returnDate
    FROM LOAN
    WHERE Loan_ID = loanID;

    -- Verifica que Return_Date no sea nulo
    IF returnDate IS NOT NULL THEN
        SET daysLate = DATEDIFF(CURDATE(), returnDate);
        IF daysLate > 0 THEN
            SET lateFee = daysLate * 0.50; 
        END IF;
    END IF;

    RETURN lateFee;
END//

DELIMITER ;

DELIMITER //
-- Function: fn_GetTotalBooksInCategory
-- Objetivo: Devuelve el total de libros en una categoría específica.
CREATE FUNCTION fn_GetTotalBooksInCategory(categoryID INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalBooks INT DEFAULT 0; -- Valor por defecto
    SELECT COUNT(*) INTO totalBooks
    FROM BOOK
    WHERE Category_ID = categoryID;
    RETURN totalBooks;
END//
DELIMITER ; 


DELIMITER //
-- Function: fn_GetPopularBooks
-- Objetivo: Devuelve los libros más prestados hasta la fecha, limitados a un número específico de resultados.
CREATE FUNCTION fn_GetPopularBooks(categoryID INT, limitCount INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE bookIDs VARCHAR(255) DEFAULT '';
    
    SELECT GROUP_CONCAT(Book_ID ORDER BY COUNT(Loan_ID) DESC SEPARATOR ', ')
    INTO bookIDs
    FROM LOAN
    JOIN BOOK ON LOAN.Book_ID = BOOK.Book_ID
    WHERE BOOK.Category_ID = categoryID
    GROUP BY BOOK.Book_ID
    LIMIT limitCount;

    RETURN bookIDs;
END//
DELIMITER ; 


