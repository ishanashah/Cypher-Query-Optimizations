//Query 6 Source-Target Straightforward
MATCH (a:Location {name: 'A'}),
      (b:Location {name: 'B'}),
      p = (a)-[*0..]-(b)
WHERE reduce(uniform = true, tot IN relationships(p) | uniform AND (tot.color = 'RED')) OR
      reduce(uniform = true, tot IN relationships(p) | uniform AND (tot.color = 'BLUE'))
RETURN min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
