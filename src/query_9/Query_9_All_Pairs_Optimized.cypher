//Query 9 All-Pairs Optimized
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
CALL gds.alpha.allShortestPaths.stream('myGraphRed', {
  relationshipWeightProperty: 'cost'
})
YIELD sourceNodeId AS source_red, targetNodeId AS target_red, distance AS distance_red
CALL gds.alpha.allShortestPaths.stream('myGraphBlue', {
  relationshipWeightProperty: 'cost'
})
YIELD sourceNodeId AS source_blue, targetNodeId AS target_blue, distance AS distance_blue
WHERE target_red = source_blue AND gds.util.asNode(source_red) = source AND gds.util.asNode(target_blue) = target
WITH source, target, collect(distance_red + distance_blue) AS distance_array
CALL gds.alpha.allShortestPaths.stream('myGraphBlue', {
  relationshipWeightProperty: 'cost'
})
YIELD sourceNodeId AS source_red, targetNodeId AS target_red, distance AS distance_red
CALL gds.alpha.allShortestPaths.stream('myGraphRed', {
  relationshipWeightProperty: 'cost'
})
YIELD sourceNodeId AS source_blue, targetNodeId AS target_blue, distance AS distance_blue
WHERE target_red = source_blue AND gds.util.asNode(source_red) = source AND gds.util.asNode(target_blue) = target
WITH source, target, distance_array + collect(distance_red + distance_blue) AS distance_array
UNWIND distance_array AS distance
RETURN source.name, target.name, min(distance);

CALL gds.graph.drop('myGraphRed', false) YIELD graphName;

CALL gds.graph.drop('myGraphBlue', false) YIELD graphName;
