//Query 7 All-Pairs Optimized
CALL gds.graph.project.cypher(
  'myGraphAlternate',
  'MATCH (n:Location) RETURN id(n) AS id',
  'MATCH (n:Location)-[r:ROAD]-(m:Location)
  WHERE n.color <> m.color
  RETURN id(n) AS source, id(m) AS target, r.cost AS cost')
YIELD nodeCount AS nodes, relationshipCount AS rels
RETURN nodes, rels;

CALL gds.alpha.allShortestPaths.stream('myGraphAlternate', {
  relationshipWeightProperty: 'cost'
})
YIELD sourceNodeId, targetNodeId, distance
RETURN gds.util.asNode(sourceNodeId).name AS source, gds.util.asNode(targetNodeId).name AS target, distance;

CALL gds.graph.drop('myGraphAlternate', false) YIELD graphName;
