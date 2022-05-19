//Query 9 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      (b:Location {name: 'B'}),
      p = (a)-[*0..]-(b)
WHERE reduce(transitions = 0, i IN range(0, length(p)-2) | transitions + CASE WHEN (relationships(p)[i].color <> relationships(p)[i+1].color) THEN 1 ELSE 0 END) < 2
RETURN min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
