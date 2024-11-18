CREATE TABLE account (
    account_id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    cpf TEXT NOT NULL UNIQUE,
    car_plate TEXT NULL, -- Apenas motoristas terão placa de carro
    is_passenger BOOLEAN NOT NULL DEFAULT FALSE,
    is_driver BOOLEAN NOT NULL DEFAULT FALSE,
    password TEXT NOT NULL,
    CONSTRAINT chk_account_roles CHECK (NOT (is_passenger AND is_driver)) -- Garante que não seja ambos
);

CREATE TABLE ride (
    ride_id UUID PRIMARY KEY,
    passenger_id UUID NOT NULL,
    driver_id UUID NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'in-progress', 'completed', 'canceled')),
    fare NUMERIC NOT NULL CHECK (fare >= 0),
    distance NUMERIC NOT NULL CHECK (distance >= 0),
    from_lat NUMERIC NOT NULL,
    from_long NUMERIC NOT NULL,
    to_lat NUMERIC NOT NULL,
    to_long NUMERIC NOT NULL,
    date TIMESTAMP NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES account(account_id) ON DELETE SET NULL,
    FOREIGN KEY (driver_id) REFERENCES account(account_id) ON DELETE SET NULL
);

CREATE TABLE position (
    position_id UUID PRIMARY KEY,
    ride_id UUID NOT NULL,
    lat NUMERIC NOT NULL,
    long NUMERIC NOT NULL,
    date TIMESTAMP NOT NULL,
    FOREIGN KEY (ride_id) REFERENCES ride(ride_id) ON DELETE CASCADE -- Se a corrida for apagada, apaga as posições
);

CREATE TABLE transaction (
    transaction_id UUID PRIMARY KEY,
    ride_id UUID NOT NULL,
    amount NUMERIC NOT NULL CHECK (amount > 0),
    date TIMESTAMP NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'success', 'failed')),
    FOREIGN KEY (ride_id) REFERENCES ride(ride_id) ON DELETE SET NULL -- Se a corrida for apagada, desassocia a transação
);

-- INSERT CORRETO
INSERT INTO account (account_id, name, email, cpf, car_plate, is_passenger, is_driver, password) 
VALUES ('123e4567-e89b-12d3-a456-426614174000', 'John Doe', 'john.doe@example.com', '12345678900', NULL, TRUE, FALSE, 'securepassword');

-- INSERT INCORRETO (é passageiro e motorista)
-- "account" violates check constraint "chk_account_roles"
INSERT INTO account (account_id, name, email, cpf, car_plate, is_passenger, is_driver, password) 
VALUES ('123e4567-e89b-12d3-a456-426614174001', 'Jane Doe', 'jane.doe@example.com', '12345678901', 'ABC1234', TRUE, TRUE, 'securepassword');

--INSERT CORRETO
INSERT INTO ride (ride_id, passenger_id, driver_id, status, fare, distance, from_lat, from_long, to_lat, to_long, date)
VALUES ('456e7890-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174000', 'pending', 50.0, 10.0, -23.5505, -46.6333, -23.5675, -46.6412, NOW());

-- INSERT INCORRETO (id passageiro não existe)
-- invalid input syntax for type uuid: "nonexistent-id"
INSERT INTO ride (ride_id, passenger_id, driver_id, status, fare, distance, from_lat, from_long, to_lat, to_long, date)
VALUES ('456e7890-e89b-12d3-a456-426614174002', 'nonexistent-id', '123e4567-e89b-12d3-a456-426614174000', 'pending', 50.0, 10.0, -23.5505, -46.6333, -23.5675, -46.6412, NOW());

--INSERT CORRETO
INSERT INTO position (position_id, ride_id, lat, long, date)
VALUES ('789e0123-e89b-12d3-a456-426614174000', '456e7890-e89b-12d3-a456-426614174001', -23.5600, -46.6350, NOW());

--INSERT INCORRETO (id da corrida não existe)
-- invalid input syntax for type uuid: "nonexistent-ride-id"
INSERT INTO position (position_id, ride_id, lat, long, date)
VALUES ('789e0123-e89b-12d3-a456-426614174001', 'nonexistent-ride-id', -23.5600, -46.6350, NOW());

--INSERT CORRETO 
INSERT INTO transaction (transaction_id, ride_id, amount, date, status)
VALUES ('890e1234-e89b-12d3-a456-426614174000', '456e7890-e89b-12d3-a456-426614174001', 50.0, NOW(), 'pending');

-- INSERT INCORRETO
-- "transaction" violates check constraint "transaction_amount_check"
INSERT INTO transaction (transaction_id, ride_id, amount, date, status)
VALUES ('890e1234-e89b-12d3-a456-426614174001', '456e7890-e89b-12d3-a456-426614174001', -10.0, NOW(), 'pending');

select * from account;
select * from ride;
select * from position;
select * from transaction

ALTER TABLE ride
ADD CONSTRAINT chk_from_lat CHECK (from_lat BETWEEN -90 AND 90),
ADD CONSTRAINT chk_from_long CHECK (from_long BETWEEN -180 AND 180),
ADD CONSTRAINT chk_to_lat CHECK (to_lat BETWEEN -90 AND 90),
ADD CONSTRAINT chk_to_long CHECK (to_long BETWEEN -180 AND 180);

ALTER TABLE position
ADD CONSTRAINT chk_lat CHECK (lat BETWEEN -90 AND 90),
ADD CONSTRAINT chk_long CHECK (long BETWEEN -180 AND 180);

SELECT * FROM ride WHERE from_lat NOT BETWEEN -90 AND 90 OR from_long NOT BETWEEN -180 AND 180 OR to_lat NOT BETWEEN -90 AND 90 OR to_long NOT BETWEEN -180 AND 180;

SELECT * FROM position WHERE lat NOT BETWEEN -90 AND 90 OR long NOT BETWEEN -180 AND 180;

UPDATE ride SET from_lat = -90 WHERE from_lat < -90;
UPDATE ride SET from_lat = 90 WHERE from_lat > 90;


