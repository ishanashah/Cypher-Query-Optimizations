//Query 7 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      (b:Location {name: 'B'}),
      p = (a)-[*0..]-(b)
WHERE reduce(predicate = true, i IN range(0, length(p)-1) | predicate AND (nodes(p)[i].color <> nodes(p)[i+1].color))
RETURN min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
