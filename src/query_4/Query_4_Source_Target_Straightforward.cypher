//Query 4 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      p1 = (a)-[*0..]-()-[x:ROAD]-(b)
MATCH (c:Location {name: 'B'}),
      p2 = (b)-[*0..]-(c)
WHERE x.color = 'RED'
RETURN min(reduce(total = 0, tot IN relationships(p1) | total + tot.cost) +
           reduce(total = 0, tot IN relationships(p2) | total + tot.cost));
