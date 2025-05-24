CREATE TABLE purchases (
  id SERIAL PRIMARY KEY,
  store_id INT,
  purchased_at DATE,
  ingredient TEXT,
  qty NUMERIC,
  unit_cost NUMERIC,
  total_cost NUMERIC
);
-- sales, fixed_costs も同様に
