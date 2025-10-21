-- Elimina el valor por defecto para la columna created_at en la tabla reservations
ALTER TABLE reservations ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE persons ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE users ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE stations ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE barbers ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE services ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE sales ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE inventory_items ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE menu_products ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE reservation_products ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE barber_commissions ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE sale_items ALTER COLUMN created_at DROP DEFAULT;
ALTER TABLE barber_advances ALTER COLUMN created_at DROP DEFAULT;

-- Elimina el valor por defecto para la columna updated_at en la tabla reservations
ALTER TABLE reservations ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE persons ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE users ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE stations ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE barbers ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE services ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE sales ALTER COLUMN sale_date DROP DEFAULT;
ALTER TABLE inventory_items ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE menu_products ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE barber_commissions ALTER COLUMN updated_at DROP DEFAULT;
ALTER TABLE inventory_movements ALTER COLUMN movement_date DROP DEFAULT;