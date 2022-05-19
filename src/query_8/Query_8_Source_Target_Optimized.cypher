//Query 8 Source-Target Optimized
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
CALL gds.allShortestPaths.dijkstra.stream('myGraphRed', {
    sourceNode: source,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t1, totalCost as totalCost1
CALL gds.allShortestPaths.dijkstra.stream('myGraphBlue', {
    sourceNode: target,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t2, totalCost as totalCost2
WHERE gds.util.asNode(t1) = gds.util.asNode(t2)
RETURN min(totalCost1 + totalCost2);

CALL gds.graph.drop('myGraphRed', false) YIELD graphName;

CALL gds.graph.drop('myGraphBlue', false) YIELD graphName;
