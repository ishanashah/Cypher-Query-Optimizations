//Query 8 All-Pairs Straightforward
MATCH (a:Location),
      (b:Location)
OPTIONAL MATCH p = (a)-[*0..]-(b)
WHERE reduce(predicate = true, i IN range(0, length(p)-2) | predicate AND NOT (relationships(p)[i].color = 'BLUE' AND relationships(p)[i+1].color = 'RED'))
RETURN a.name, b.name, min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
