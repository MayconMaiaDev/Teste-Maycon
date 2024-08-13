-- Listar todos os Clientes que não tenham realizado uma compra:
SELECT c.*
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Listar os Produtos que não tenham sido comprados
SELECT p.*
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL;

-- Listar os Produtos sem Estoque;
SELECT 
    p.*
FROM
    Products p
        LEFT JOIN
    Stocks s ON p.product_id = s.product_id
GROUP BY p.product_id
HAVING COALESCE(SUM(s.quantity), 0) = 0;

-- Agrupar a quantidade de vendas de uma determinada Marca por Loja.
SELECT 
    s.store_id,
    s.store_name,
    b.brand_name,
    COUNT(oi.item_id) AS total_sales
FROM 
    Stores s
INNER JOIN Orders o ON s.store_id = o.store_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
INNER JOIN Brands b ON p.brand_id = b.brand_id
GROUP BY 
    s.store_id, s.store_name, b.brand_name;

-- Listar os Funcionarios que não estejam relacionados a um Pedido.
SELECT s.*
FROM Staffs s
LEFT JOIN Orders o ON s.staff_id = o.staff_id
WHERE o.order_id IS NULL;