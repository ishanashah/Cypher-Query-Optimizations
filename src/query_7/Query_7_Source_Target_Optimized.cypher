//Query 7 Source-Target Optimized
CALL gds.graph.project.cypher(
  'myGraphAlternate',
  'MATCH (n:Location) RETURN id(n) AS id',
  'MATCH (n:Location)-[r:ROAD]-(m:Location)
  WHERE n.color <> m.color
  RETURN id(n) AS source, id(m) AS target, r.cost AS cost')
YIELD nodeCount AS nodes, relationshipCount AS rels
RETURN nodes, rels;

MATCH (source:Location {name: 'A'}),
      (target:Location {name: 'B'})
CALL gds.shortestPath.dijkstra.stream('myGraphAlternate', {
    sourceNode: source,
    targetNode: target,
    relationshipWeightProperty: 'cost'
})
YIELD totalCost
RETURN totalCost;

CALL gds.graph.drop('myGraphAlternate', false) YIELD graphName;
