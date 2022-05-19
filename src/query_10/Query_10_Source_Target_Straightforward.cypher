//Query 10 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      (b:Location {name: 'C'}),
      p = (a)-[*0..]-(b)
WHERE reduce(predicate = false, i IN range(0, length(p)-1) | predicate OR (nodes(p)[i].color <> nodes(p)[i+1].color))
RETURN min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
