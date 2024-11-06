-- Created by belenamiune (https://github.com/belenamiune)

USE library;

-- Triggers:

DELIMITER //


-- Trigger: BeforeInsertLoan
-- Objetivo: Asegurarse de que un libro esté disponible antes de permitir un nuevo préstamo. Si el libro no está disponible, se puede cancelar la inserción.
CREATE TRIGGER BeforeInsertLoan
BEFORE INSERT ON LOAN
FOR EACH ROW
BEGIN
    DECLARE isAvailable TINYINT(1);
    -- Verificar la disponibilidad del libro usando la función
    SET isAvailable = IsBookAvailable(NEW.Book_ID);
    IF isAvailable = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El libro no está disponible para préstamo';
    END IF;
END//

DELIMITER ;


DELIMITER //

-- Trigger: AfterUpdateUser
-- Objetivo: Registrar cada vez que se actualiza el nombre de un usuario en una tabla de auditoría.
CREATE TRIGGER AfterUpdateUser
AFTER UPDATE ON USER
FOR EACH ROW
BEGIN
    INSERT INTO USER_AUDIT (User_ID, Old_Name, New_Name, Change_Date)
    VALUES (OLD.User_ID, OLD.User_Name, NEW.User_Name, NOW());
END//

DELIMITER ;

DELIMITER //


-- Trigger: BeforeDeleteBook
-- Objetivo: Prohibir la eliminación de un libro que todavía está prestado, asegurando que no se puedan borrar libros que estén en uso.
CREATE TRIGGER BeforeDeleteBook
BEFORE DELETE ON BOOK
FOR EACH ROW
BEGIN
    DECLARE loanCount INT;
    -- Contar los préstamos activos para el libro
    SELECT COUNT(*) INTO loanCount
    FROM LOAN
    WHERE Book_ID = OLD.Book_ID AND Return_Date IS NULL;
    
    -- Manejo de errores: Si hay préstamos activos
    IF loanCount > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el libro porque está prestado';
    END IF;
END//

DELIMITER ;


DELIMITER //

-- Trigger: AfterInsertLoan
-- Objetivo: Actualizar la fecha de devolución automáticamente al insertar un nuevo préstamo, por ejemplo, si los préstamos son de 14 días.
CREATE TRIGGER AfterInsertLoan
AFTER INSERT ON LOAN
FOR EACH ROW
BEGIN
    UPDATE LOAN
    SET Return_Date = DATE_ADD(NEW.Loan_Date, INTERVAL 14 DAY)
    WHERE Loan_ID = NEW.Loan_ID;
END//

DELIMITER ;


DELIMITER //


-- Trigger: BeforeUpdateLoan
-- Objetivo: Asegurarse de que la fecha de devolución no se actualice a una fecha anterior a la fecha de préstamo.
CREATE TRIGGER BeforeUpdateLoan
BEFORE UPDATE ON LOAN
FOR EACH ROW
BEGIN
    IF NEW.Return_Date < NEW.Loan_Date THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La fecha de devolución no puede ser anterior a la fecha de préstamo';
    END IF;
END//

DELIMITER ;