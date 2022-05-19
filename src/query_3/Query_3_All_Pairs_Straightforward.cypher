//Query 3 All-Pairs Straightforward
MATCH (a:Location),
      (b:Location {color: 'RED'}),
      p1 = (a)-[*0..]-(b)
MATCH (c:Location),
      p2 = (b)-[*0..]-(c)
RETURN a.name, c.name, min(reduce(total = 0, tot IN relationships(p1) | total + tot.cost) + reduce(total = 0, tot IN relationships(p2) | total + tot.cost));
