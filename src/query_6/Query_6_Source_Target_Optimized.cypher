//Query 6 Source-Target Optimized
CALL gds.graph.project.cypher(
  'myGraphRed',
  'MATCH (n:Location) RETURN id(n) AS id',
  'MATCH (n:Location)-[r:ROAD {color: "RED"}]-(m:Location) RETURN id(n) AS source, id(m) AS target, r.cost AS cost')
YIELD graphName as graphRed, nodeCount AS nodesRed, relationshipCount AS relsRed
CALL gds.graph.project.cypher(
  'myGraphBlue',
  'MATCH (n:Location) RETURN id(n) AS id',
  'MATCH (n:Location)-[r:ROAD {color: "BLUE"}]-(m:Location) RETURN id(n) AS source, id(m) AS target, r.cost AS cost')
YIELD graphName as graphBlue, nodeCount AS nodesBlue, relationshipCount AS relsBlue
RETURN graphRed, nodesRed, relsRed, graphBlue, nodesBlue, relsBlue;

MATCH (source:Location {name: 'A'}),
      (target:Location {name: 'B'})
CALL {
  WITH source, target
  CALL gds.shortestPath.dijkstra.stream('myGraphRed', {
      sourceNode: source,
      targetNode: target,
      relationshipWeightProperty: 'cost'
  })
  YIELD totalCost
  RETURN totalCost
  UNION
  WITH source, target
  CALL gds.shortestPath.dijkstra.stream('myGraphBlue', {
      sourceNode: source,
      targetNode: target,
      relationshipWeightProperty: 'cost'
  })
  YIELD totalCost
  RETURN totalCost
}
return min(totalCost);

CALL gds.graph.drop('myGraphRed', false) YIELD graphName;

CALL gds.graph.drop('myGraphBlue', false) YIELD graphName;
