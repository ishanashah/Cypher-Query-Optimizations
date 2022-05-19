//Query 8 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      (b:Location {name: 'B'}),
      p = (a)-[*0..]-(b)
WHERE reduce(predicate = true, i IN range(0, length(p)-2) | predicate AND NOT (relationships(p)[i].color = 'BLUE' AND relationships(p)[i+1].color = 'RED'))
RETURN min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
