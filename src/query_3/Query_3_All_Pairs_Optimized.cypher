//Query 3 All-Pairs Optimized
CALL gds.graph.project(
    'myGraph',
    'Location',
    {ROAD: {orientation: 'UNDIRECTED'}},
    { relationshipProperties: 'cost' }
);

MATCH (source:Location),
	  (inter:Location {color: 'RED'}),
      (target:Location)
CALL gds.allShortestPaths.dijkstra.stream('myGraph', {
    sourceNode: inter,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t1, totalCost as totalCost1
CALL gds.allShortestPaths.dijkstra.stream('myGraph', {
    sourceNode: inter,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t2, totalCost as totalCost2
RETURN gds.util.asNode(t1).name AS source, gds.util.asNode(t2).name AS target, min(totalCost1 + totalCost2) as totalCost;


CALL gds.graph.drop('myGraph', false) YIELD graphName;
