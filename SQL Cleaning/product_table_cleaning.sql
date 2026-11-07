USE ecommerce_analystics;

-- Initial inspection

SELECT * FROM products;

SELECT COUNT(*) FROM products;

SELECT COUNT(DISTINCT product_id) FROM products;

SELECT * FROM products
WHERE product_category_name IS NULL;

SELECT * FROM products
WHERE product_category_name = '';

SELECT product_category_name, COUNT(*)
FROM products
GROUP BY product_category_name
ORDER BY COUNT(*) DESC;


-- Checking missing / zero values

SELECT *
FROM products
WHERE product_weight_g = 0
   OR product_length_cm = 0
   OR product_height_cm = 0
   OR product_width_cm = 0;


-- Category-wise median checks

-- bebes

SELECT AVG(product_weight_g)
FROM (
    SELECT product_weight_g,
           ROW_NUMBER() OVER (ORDER BY product_weight_g) AS rn,
           COUNT(*) OVER () AS total_rows
    FROM products
    WHERE product_category_name = 'bebes'
      AND product_weight_g > 0
) AS t
WHERE rn IN (FLOOR((total_rows + 1) / 2),
             FLOOR((total_rows + 2) / 2));


-- cama_mesa_banho

SELECT AVG(product_weight_g)
FROM (
    SELECT product_weight_g,
           ROW_NUMBER() OVER (ORDER BY product_weight_g) AS rn,
           COUNT(*) OVER () AS total_rows
    FROM products
    WHERE product_category_name = 'cama_mesa_banho'
      AND product_weight_g > 0
) AS t
WHERE rn IN (FLOOR((total_rows + 1) / 2),
             FLOOR((total_rows + 2) / 2));


-- N/A category

SELECT AVG(product_weight_g)
FROM (
    SELECT product_weight_g,
           ROW_NUMBER() OVER (ORDER BY product_weight_g) AS rn,
           COUNT(*) OVER () AS total_rows
    FROM products
    WHERE product_category_name = 'N/A'
      AND product_weight_g > 0
) AS t
WHERE rn IN (FLOOR((total_rows + 1) / 2),
             FLOOR((total_rows + 2) / 2));


-- Category name cleaning

UPDATE products
SET product_category_name = 'N/A'
WHERE product_category_name = '';


-- bebes category cleaning

SET SQL_SAFE_UPDATES = 0;

UPDATE products
SET product_weight_g = 850
WHERE product_id = '09ff539a621711667c43eba6a3bd8466';

UPDATE products
SET product_length_cm = 33
WHERE product_id = '09ff539a621711667c43eba6a3bd8466';

UPDATE products
SET product_height_cm = 16
WHERE product_id = '09ff539a621711667c43eba6a3bd8466';

UPDATE products
SET product_width_cm = 25
WHERE product_id = '09ff539a621711667c43eba6a3bd8466';


-- cama_mesa_banho cleaning

UPDATE products
SET product_weight_g = 1250
WHERE product_weight_g = 0
  AND product_category_name = 'cama_mesa_banho';


-- N/A category cleaning

UPDATE products
SET product_weight_g = 700
WHERE product_weight_g = 0
  AND product_category_name = 'N/A';

UPDATE products
SET product_length_cm = 25
WHERE product_weight_g = 0
  AND product_category_name = 'N/A';

UPDATE products
SET product_height_cm = 12
WHERE product_weight_g = 0
  AND product_category_name = 'N/A';

UPDATE products
SET product_width_cm = 20
WHERE product_weight_g = 0
  AND product_category_name = 'N/A';