//Query 7 All-Pairs Straightforward
MATCH (a:Location),
      (b:Location)
OPTIONAL MATCH p = (a)-[*0..]-(b)
WHERE reduce(predicate = true, i IN range(0, length(p)-1) | predicate AND (nodes(p)[i].color <> nodes(p)[i+1]))
RETURN a.name, b.name, min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
