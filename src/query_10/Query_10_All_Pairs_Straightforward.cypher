//Query 10 All-Pairs Straightforward
MATCH (a:Location),
      (b:Location)
OPTIONAL MATCH p = (a)-[*0..]-(b)
WHERE reduce(predicate = false, i IN range(0, length(p)-1) | predicate OR (nodes(p)[i].color <> nodes(p)[i+1].color))
RETURN a.name, b.name, min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
