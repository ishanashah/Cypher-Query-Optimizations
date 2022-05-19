//Query 4 All-Pairs Straightforward
MATCH p1 = (a)-[*0..]-()-[x:ROAD]-(b)
MATCH p2 = (b)-[*0..]-(c)
WHERE x.color = 'RED'
RETURN a.name, c.name, min(reduce(total = 0, tot IN relationships(p1) | total + tot.cost) + reduce(total = 0, tot IN relationships(p2) | total + tot.cost));
