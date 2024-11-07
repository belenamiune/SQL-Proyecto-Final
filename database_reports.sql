-- Created by belenamiune (https://github.com/belenamiune)

USE library;

-- Reports

-- Report: User by type
SELECT ut.User_Type_Name AS User_Type,
       COUNT(u.User_ID) AS Users_Amount
FROM USER u
JOIN USERTYPES ut ON u.User_Type = ut.User_Type
GROUP BY ut.User_Type_Name
ORDER BY Users_Amount DESC;

-- Report: Book inventory
SELECT b.Title AS Title, 
       b.Year AS Year, 
       c.Category_Name AS Category
FROM BOOK b
LEFT JOIN CATEGORY c ON b.Category_ID = c.Category_ID
ORDER BY b.Year DESC;

-- Report: Loan and service registration
SELECT u.User_Name AS User,
       b.Title AS Book,
       br.Loan_Date AS Loan_Date,
       s.Sanction_Date AS Sanction_Date,
       s.Sanction_Status AS Sanction_Status
FROM LOAN br
JOIN USER u ON br.User_ID = u.User_ID
JOIN BOOK b ON br.Book_ID = b.Book_ID
LEFT JOIN SANCTION s ON u.User_ID = s.User_ID
WHERE br.Return_Date IS NULL  -- solo prestamos activos
ORDER BY u.User_Name;


-- Report: Users by Type with User Details
SELECT ut.User_Type_Name AS User_Type,
       COUNT(u.User_ID) AS Amount_Users,
       GROUP_CONCAT(u.User_Name ORDER BY u.User_Name SEPARATOR ', ') AS User_Name
FROM USER u
JOIN USERTYPES ut ON u.User_Type = ut.User_Type
GROUP BY ut.User_Type_Name
ORDER BY Amount_Users DESC;

-- Report: Complete Inventory of Books and Categories
SELECT b.Title AS Title, 
       b.Year AS Year, 
       c.Category_Name AS Category, 
       c.Description AS Category_Description
FROM BOOK b
LEFT JOIN CATEGORY c ON b.Category_ID = c.Category_ID
ORDER BY c.Category_Name, b.Year DESC;

-- Report: Detailed Loan and Sanctions with Librarians
SELECT u.User_Name AS User,
       u.Address AS Address,
       b.Title AS Book,
       br.Loan_Date AS Loan_Date,
       br.Return_Date AS Return_Date,
       l.Librarian_Name AS Librarian,
       s.Sanction_Date AS Sanction_Date,
       s.Sanction_Status AS Sanction_Status
FROM LOAN br
JOIN USER u ON br.User_ID = u.User_ID
JOIN BOOK b ON br.Book_ID = b.Book_ID
JOIN LIBRARIAN l ON br.Librarian_ID = l.Librarian_ID
LEFT JOIN SANCTION s ON u.User_ID = s.User_ID
ORDER BY u.User_Name, s.Sanction_Date DESC;

-- Report: Librarians shifts
SELECT Librarian_Name AS Librarian,
       Shift AS Shifts
FROM LIBRARIAN
ORDER BY Shift;

-- Report: Categories and Books Summary
SELECT c.Category_Name AS Category,
       COUNT(b.Book_ID) AS Books_Category
FROM CATEGORY c
LEFT JOIN BOOK b ON c.Category_ID = b.Category_ID
GROUP BY c.Category_Name
ORDER BY Books_Category  DESC;