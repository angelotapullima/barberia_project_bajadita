ALTER TABLE sale_items ADD COLUMN is_courtesy BOOLEAN DEFAULT FALSE;
ALTER TABLE sale_items ADD COLUMN courtesy_reason TEXT;
ALTER TABLE sale_items ADD COLUMN original_unit_price REAL NOT NULL DEFAULT 0;