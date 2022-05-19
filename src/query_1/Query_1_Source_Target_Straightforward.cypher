//Query 1 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      (b:Location {name: 'B'}),
      p1 = (a)-[*0..]-(b)
MATCH (c:Location {name: 'C'}),
      p2 = (b)-[*0..]-(c)
RETURN min(reduce(total = 0, tot IN relationships(p1) | total + tot.cost) +
           reduce(total = 0, tot IN relationships(p2) | total + tot.cost));
