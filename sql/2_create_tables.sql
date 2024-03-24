USE stock_data;

CREATE TABLE stock_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stock_symbol VARCHAR(4) NOT NULL,
    stock_date DATE NOT NULL,
    stock_price_open DECIMAL(8, 2) NULL,
    stock_price_high DECIMAL(8, 2) NULL,
    stock_price_low DECIMAL(8, 2) NULL,
    stock_price_close DECIMAL(8, 2) NULL,
    stock_volume INT NULL
);

