//Query 10 All-Pairs Optimized
CALL gds.graph.project(
    'myGraph',
    'Location',
    {ROAD: {orientation: 'UNDIRECTED'}},
    { relationshipProperties: 'cost' }
);

MATCH (source:Location),
      (target:Location),
      (u)-[r:ROAD]-(v)
WHERE u.color <> v.color
CALL gds.allShortestPaths.dijkstra.stream('myGraph', {
    sourceNode: u,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t1, totalCost as totalCost1
CALL gds.allShortestPaths.dijkstra.stream('myGraph', {
    sourceNode: v,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t2, totalCost as totalCost2
RETURN gds.util.asNode(t1).name AS source, gds.util.asNode(t2).name AS target, r.cost + min(totalCost1 + totalCost2) as totalCost;

CALL gds.graph.drop('myGraph', false) YIELD graphName;
