## Exercícios da aula

### Exercício 1

Encontre o número total de pedidos realizados por clientes que compraram o produto 957.

```sql
SELECT COUNT(DISTINCT o.order_id) AS total_pedidos
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.product_id = 957;
```

### Exercício 2

Exiba o nome completo e o valor total dos pedidos feitos por cada cliente, formatado como dinheiro. Ordene em ordem alfabética.

```sql
SELECT
    c.first_name || ' ' || c.last_name AS nome_completo,
    CAST(SUM(o.total_amount) AS MONEY) AS valor_total_pedidos
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY nome_completo;
```

### Exercício 3

Encontre e exiba todas as informações dos produtos e do fornecedor cujo id do fornecedor seja o número 9.

```sql
SELECT p.*, s.*
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.supplier_id = 9;
```

### Exercício 4

Encontre e exiba o nome do produto e a quantidade de produtos comprados por cada cliente cujo nome inicie por "AN", ordenado pelo sobrenome. Informe o nome completo do cliente. Desconsidere letras maiúsculas ou minúsculas ao procurar o cliente.

```sql
SELECT
    c.first_name || ' ' || c.last_name AS nome_completo,
    p.product_name,
    SUM(oi.quantity) AS quantidade_comprada
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE UPPER(c.first_name) LIKE 'AN%'
GROUP BY c.customer_id, p.product_id
ORDER BY c.last_name;
```

### Exercício 5

Exiba o total gasto por cada cliente que gastou mais de 1000000 em pedidos. Informe o nome completo do cliente, e os valores formatados como dinheiro, ordenados por valor decrescente.

```sql
SELECT
    c.first_name || ' ' || c.last_name AS nome_completo,
    CAST(SUM(o.total_amount) AS MONEY) AS total_gasto
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING SUM(o.total_amount) > 1000000
ORDER BY total_gasto DESC;
```

### Exercício 6

Encontre e informe o nome e a quantidade de pedidos dos 5 produtos mais comprados, ordenados por quantidade decrescente.

```sql
SELECT
    p.product_name,
    SUM(oi.quantity) AS quantidade_pedidos
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY quantidade_pedidos DESC
LIMIT 5;
```

## Exercícios Adicionais

### Exercício 1

Encontre o preço médio arredondado com 2 casas decimais dos produtos em cada uma das categorias.

```sql
SELECT
    c.category_name,
    ROUND(AVG(p.price), 2) AS preco_medio
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id;
```

### Exercício 2

Busque todas as informações sobre os produtos que nunca foram comprados (inclusive a descrição da categoria e todos os dados do fornecedor).

```sql
SELECT
    p.*,
    c.category_name,
    s.*
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;
```

### Exercício 3

Encontre os top 5 clientes que mais gastaram dinheiro em compras, exibindo o nome completo e o valor gasto formatado como dinheiro.

```sql
SELECT
    c.first_name || ' ' || c.last_name AS nome_completo,
    CAST(SUM(o.total_amount) AS MONEY) AS valor_gasto
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY valor_gasto DESC
LIMIT 5;
```
