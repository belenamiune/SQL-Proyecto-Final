-- Created by belenamiune (https://github.com/belenamiune)

USE library;

-- Insersción de datos:

-- Table: USERTYPES
INSERT INTO USERTYPES (User_Type_Name, Description) VALUES
('Admin', 'Administrator with full access'),
('Member', 'Regular library member'),
('Librarian', 'Library staff member'),
('Visitor', 'Non-member visitor');

-- Table: USER
INSERT INTO USER (User_Name, Address, Phone, Email, User_Type) VALUES
('Juan Pérez', 'Calle Falsa 123', '555-0123', 'juan@example.com', 2),
('Ana Gómez', 'Avenida Siempre Viva 742', '555-0456', 'ana@example.com', 2),
('Luis Martínez', 'Boulevard de los Sueños 456', '555-0789', 'luis@example.com', 3),
('Marta López', 'Calle del Sol 321', '555-0112', 'marta@example.com', 1),
('Carlos Ruiz', 'Calle del Mar 654', '555-0345', 'carlos@example.com', 2),
('Sofía Torres', 'Calle de la Luna 987', '555-0678', 'sofia@example.com', 4),
('Pedro Sánchez', 'Calle de la Esperanza 258', '555-0912', 'pedro@example.com', 2),
('Laura Jiménez', 'Avenida de la Paz 135', '555-0134', 'laura@example.com', 3),
('Diego Fernández', 'Calle de la Libertad 369', '555-0457', 'diego@example.com', 1),
('Carmen Castro', 'Calle del Amor 147', '555-0890', 'carmen@example.com', 4),
('Javier Morales', 'Calle de la Amistad 258', '555-0246', 'javier@example.com', 2),
('María González', 'Avenida de la Felicidad 753', '555-0690', 'maria@example.com', 3),
('Roberto Díaz', 'Calle del Valor 369', '555-0312', 'roberto@example.com', 2),
('Patricia Ruiz', 'Calle del Respeto 159', '555-0780', 'patricia@example.com', 4),
('Fernando Herrera', 'Calle de la Unidad 951', '555-1023', 'fernando@example.com', 1);

-- Table: LIBRARIAN
INSERT INTO LIBRARIAN (Librarian_Name, Shift) VALUES
('Clara Martínez', 'Morning'),
('Jorge López', 'Afternoon'),
('Elena García', 'Evening'),
('Ricardo Fernández', 'Night'); 


-- Table: CATEGORY 
INSERT INTO CATEGORY (Category_Name, Description) VALUES
('Fiction', 'Novels and stories of fiction'),
('Non-Fiction', 'Books based on real facts'),
('Science', 'Books about science and technology'),
('History', 'Works on historical events'),
('Biographies', 'Lives of notable people'),
('Children', 'Literature for children'),
('Reference', 'Consultation and reference material');


-- Table: EDITORY
INSERT INTO EDITORY (Editory_Name) VALUES
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Macmillan Publishers'),
('Hachette Book Group');


-- Table: AUTHOR
INSERT INTO AUTHOR (Author_Name) VALUES
('F. Scott Fitzgerald'), -- Author of "The Great Gatsby"
('Harper Lee'), -- Author of "To Kill a Mockingbird"
('George Orwell'),  -- Author of "1984"
('Yuval Noah Harari'),  -- Author of "Sapiens: A Brief History of Humankind"
('Tara Westover'),  -- Author of "Educated"
('Stephen Hawking'), -- Author of "A Brief History of Time"
('Rebecca Skloot'), -- Author of "The Immortal Life of Henrietta Lacks"
('Anne Frank'), -- Author of "The Diary of a Young Girl"
('Michelle Obama'),  -- Author of "Becoming"
('Alex Michaelides'), -- Author of "The Silent Patient"
('J.D. Salinger'),  -- Author of "The Catcher in the Rye"
('Markus Zusak'), -- Author of "The Book Thief"
('Charles Duhigg'), -- Author of "The Power of Habit"
('John Green'), -- Author of "The Fault in Our Stars"
('Paulo Coelho'), -- Author of "The Alchemist"
('J.K. Rowling'), -- Author of "Harry Potter and the Sorcerer's Stone"
('E.B. White'), -- Author of "Charlotte's Web"
('Eric Carle'), -- Author of "The Very Hungry Caterpillar"
('Maurice Sendak'), -- Author of "Where the Wild Things Are"
('William Strunk Jr.'); -- Author of "The Elements of Style"

-- Table: SHELF
INSERT INTO SHELF (Shelf_Number, Section) VALUES
(1, 'Fiction'),
(2, 'Non-Fiction'),
(3, 'Science'),
(4, 'History'),
(5, 'Biographies'),
(6, 'Children'),
(7, 'Reference');


-- Table: BOOK
INSERT INTO BOOK (Title, Year, Amount_of_copies, Category_ID, Editory_ID, Shelf_ID, Available) VALUES
('The Great Gatsby', 1925, 3, 1, 1, 1, TRUE),
('To Kill a Mockingbird', 1960, 5, 1, 2, 1, TRUE),
('1984', 1949, 4, 1, 3, 1, TRUE),
('Sapiens: A Brief History of Humankind', 2011, 2, 2, 1, 2, TRUE),
('Educated', 2018, 3, 2, 2, 2, TRUE),
('A Brief History of Time', 1988, 4, 3, 3, 2, TRUE),
('The Immortal Life of Henrietta Lacks', 2010, 5, 3, 4, 2, TRUE),
('The Diary of a Young Girl', 1947, 2, 4, 1, 3, TRUE),
('Becoming', 2018, 3, 4, 2, 3, TRUE),
('The Silent Patient', 2019, 4, 1, 5, 3, TRUE),
('The Catcher in the Rye', 1951, 3, 1, 1, 4, TRUE),
('The Book Thief', 2005, 5, 1, 2, 4, TRUE),
('The Power of Habit', 2012, 2, 2, 3, 4, TRUE),
('The Fault in Our Stars', 2012, 4, 1, 4, 4, TRUE),
('The Alchemist', 1988, 3, 1, 5, 5, TRUE),
('Harry Potter and the Sorcerer\'s Stone', 1997, 6, 6, 1, 5, TRUE),
('Charlottes Web', 1952, 5, 6, 2, 5, TRUE),
('The Very Hungry Caterpillar', 1969, 7, 6, 3, 5, TRUE),
('Where the Wild Things Are', 1963, 4, 6, 4, 5, TRUE),
('The Elements of Style', 1959, 2, 7, 5, 6, TRUE);

-- Table: BOOK_AUTHOR
INSERT INTO BOOK_AUTHOR (Book_ID, Author_ID) VALUES
(1, 1),  -- "The Great Gatsby" by F. Scott Fitzgerald
(2, 2),  -- "To Kill a Mockingbird" by Harper Lee
(3, 3),  -- "1984" by George Orwell
(4, 4),  -- "Sapiens: A Brief History of Humankind" by Yuval Noah Harari
(5, 5),  -- "Educated" by Tara Westover
(6, 6),  -- "A Brief History of Time" by Stephen Hawking
(7, 7),  -- "The Immortal Life of Henrietta Lacks" by Rebecca Skloot
(8, 8),  -- "The Diary of a Young Girl" by Anne Frank
(9, 9),  -- "Becoming" by Michelle Obama
(10, 10), -- "The Silent Patient" by Alex Michaelides
(11, 11), -- "The Catcher in the Rye" by J.D. Salinger
(12, 12), -- "The Book Thief" by Markus Zusak
(13, 13), -- "The Power of Habit" by Charles Duhigg
(14, 14), -- "The Fault in Our Stars" by John Green
(15, 15), -- "The Alchemist" by Paulo Coelho
(16, 16), -- "Harry Potter and the Sorcerer's Stone" by J.K. Rowling
(17, 17), -- "Charlotte's Web" by E.B. White
(18, 18), -- "The Very Hungry Caterpillar" by Eric Carle
(19, 19), -- "Where the Wild Things Are" by Maurice Sendak
(20, 20); -- "The Elements of Style" by William Strunk Jr.

-- Table: LOAN
INSERT INTO LOAN (Loan_Date, Return_Date, Status, User_ID, Librarian_ID, Book_ID) VALUES
('2024-01-10', '2024-01-17', 'Returned', 1, 1, 1),  -- Juan Pérez, Librarian Clara, "The Great Gatsby"
('2024-01-12', '2024-01-19', 'Returned', 2, 2, 2),  -- Ana Gómez, Librarian Jorge, "To Kill a Mockingbird"
('2024-01-15', NULL, 'Pending', 3, 3, 3),           -- Luis Martínez, Librarian Elena, "1984"
('2024-01-16', NULL, 'Pending', 4, 1, 4),           -- Marta López, Librarian Clara, "Sapiens"
('2024-01-20', '2024-01-27', 'Returned', 5, 2, 5),  -- Carlos Ruiz, Librarian Jorge, "Educated"
('2024-01-22', NULL, 'Pending', 6, 3, 6),           -- Sofía Torres, Librarian Elena, "A Brief History of Time"
('2024-01-25', '2024-02-01', 'Returned', 7, 1, 7),  -- Pedro Sánchez, Librarian Clara, "The Immortal Life of Henrietta Lacks"
('2024-01-28', NULL, 'Pending', 8, 2, 8);           -- Laura Jiménez, Librarian Jorge, "The Diary of a Young Girl"


-- Table: RESERVATION
INSERT INTO RESERVATION (Reservation_Date, Reservation_Status, User_ID) VALUES
('2024-01-05', 'Active', 1),  -- Juan Pérez
('2024-01-08', 'Active', 3),  -- Luis Martínez
('2024-01-12', 'Cancelled', 4); -- Marta López


-- Table: SANCTION
INSERT INTO SANCTION (Sanction_Date, Price, Description, Sanction_Status, User_ID, Loan_ID) VALUES
('2024-01-15', 10.00, 'Late return of "The Great Gatsby"', 'Pending', 1, 1),  -- Juan Pérez
('2024-01-20', 5.00, 'Late return of "1984"', 'Paid', 3, 3);  -- Luis Martínez

-- Table: FINE
INSERT INTO FINE (Price, Description, Sanction_ID) VALUES
(10.00, 'Fine for late return of "The Great Gatsby"', 1), -- Associated with the first sanction
(5.00, 'Fine for late return of "1984"', 2); -- Associated with the second sanction

