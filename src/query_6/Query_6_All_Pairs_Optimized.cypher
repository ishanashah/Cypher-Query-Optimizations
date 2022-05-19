//Query 6 All-Pairs Optimized
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

MATCH (source:Location),
      (target:Location)
CALL {
  WITH source, target
  CALL gds.alpha.allShortestPaths.stream('myGraphRed', {
      relationshipWeightProperty: 'cost'
  })
  YIELD sourceNodeId, targetNodeId, distance
  RETURN sourceNodeId, targetNodeId, distance
  UNION
  WITH source, target
  CALL gds.alpha.allShortestPaths.stream('myGraphBlue', {
      relationshipWeightProperty: 'cost'
  })
  YIELD sourceNodeId, targetNodeId, distance
  RETURN sourceNodeId, targetNodeId, distance
}
return gds.util.asNode(sourceNodeId).name AS source, gds.util.asNode(targetNodeId).name AS target, min(distance);


CALL gds.graph.drop('myGraphRed', false) YIELD graphName;

CALL gds.graph.drop('myGraphBlue', false) YIELD graphName;
