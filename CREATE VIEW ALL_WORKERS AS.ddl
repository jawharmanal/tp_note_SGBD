CREATE VIEW ALL_WORKERS AS
SELECT
    last_name AS lastname,
    first_name AS firstname,
    age,
    COALESCE(first_day, start_date) AS start_date
FROM
    (SELECT * FROM WORKERS_FACTORY_1
     UNION
     SELECT worker_id, first_name, last_name, age, start_date, end_date FROM WORKERS_FACTORY_2)
WHERE
    (last_day IS NULL OR end_date IS NULL)
ORDER BY
    start_date DESC;
CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT
    lastname,
    firstname,
    TRUNC(SYSDATE) - TRUNC(start_date) AS days_elapsed
FROM
    ALL_WORKERS;
CREATE VIEW BEST_SUPPLIERS AS
SELECT
    name,
    SUM(quantity) AS total_quantity
FROM
    SUPPLIERS
JOIN
    SUPPLIERS_BRING_TO_FACTORY_1 ON SUPPLIERS.supplier_id = SUPPLIERS_BRING_TO_FACTORY_1.supplier_id
GROUP BY
    name
HAVING
    SUM(quantity) > 1000
ORDER BY
    total_quantity DESC;
CREATE VIEW ROBOTS_FACTORIES AS
SELECT
    ROBOTS.model,
    FACTORIES.main_location AS factory_location
FROM
    ROBOTS
JOIN
    ROBOTS_FROM_FACTORY ON ROBOTS.id = ROBOTS_FROM_FACTORY.robot_id
JOIN
    FACTORIES ON ROBOTS_FROM_FACTORY.factory_id = FACTORIES.id;
