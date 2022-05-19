//Query 6 All-Pairs Straightforward
MATCH (a:Location),
      (b:Location)
OPTIONAL MATCH p = (a)-[*0..]-(b)
WHERE reduce(uniform = true, tot IN relationships(p) | uniform AND (tot.color = 'RED')) OR
      reduce(uniform = true, tot IN relationships(p) | uniform AND (tot.color = 'BLUE'))
RETURN a.name, b.name, min(reduce(total = 0, tot IN relationships(p) | total + tot.cost));
