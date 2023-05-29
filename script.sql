CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(256) NOT NULL
);

CREATE TABLE Cryptocurrencies (
    CryptoID INT PRIMARY KEY,
    CryptoName VARCHAR(100) NOT NULL,
    CryptoSymbol VARCHAR(10) NOT NULL UNIQUE,
    CurrentPrice DECIMAL(19, 8) NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT NOT NULL,
    CryptoID INT NOT NULL,
    OrderType VARCHAR(20) CHECK(OrderType IN ('BUY', 'SELL')),
    Quantity DECIMAL(19, 8) NOT NULL,
    Price DECIMAL(19, 8) NOT NULL,
    Status VARCHAR(20) CHECK(Status IN ('OPEN', 'COMPLETED', 'CANCELLED')),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(UserID) REFERENCES Users(UserID),
    FOREIGN KEY(CryptoID) REFERENCES Cryptocurrencies(CryptoID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Quantity DECIMAL(19, 8) NOT NULL,
    Price DECIMAL(19, 8) NOT NULL,
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Users (UserID, UserName, Email, PasswordHash)
VALUES (1, 'JohnDoe', 'johndoe@example.com', 'password123'),
       (2, 'JaneSmith', 'janesmith@example.com', 'password456'),
       (3, 'MikeJohnson', 'mikejohnson@example.com', 'password789');

INSERT INTO Cryptocurrencies (CryptoID, CryptoName, CryptoSymbol, CurrentPrice)
VALUES (1, 'Bitcoin', 'BTC', 40000.12345678),
       (2, 'Ethereum', 'ETH', 2500.98765432),
       (3, 'Litecoin', 'LTC', 150.56789012);
