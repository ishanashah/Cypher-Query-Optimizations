//Graph Initialization
MATCH (n)
DETACH DELETE n;

CREATE (a:Location {name: 'A', color: 'RED'}),
       (b:Location {name: 'B', color: 'BLUE'}),
       (c:Location {name: 'C', color: 'RED'}),
       (d:Location {name: 'D', color: 'BLUE'}),
       (e:Location {name: 'E', color: 'RED'}),
       (f:Location {name: 'F', color: 'BLUE'}),
       (a)-[:ROAD {cost: 50, color: 'RED'}]->(b),
       (a)-[:ROAD {cost: 50, color: 'BLUE'}]->(c),
       (a)-[:ROAD {cost: 100, color: 'RED'}]->(d),
       (a)-[:ROAD {cost: 200, color: 'BLUE'}]->(e),
       (a)-[:ROAD {cost: 150, color: 'RED'}]->(f),
       (b)-[:ROAD {cost: 140, color: 'BLUE'}]->(c),
       (b)-[:ROAD {cost: 40, color: 'RED'}]->(d),
       (b)-[:ROAD {cost: 80, color: 'BLUE'}]->(e),
       (b)-[:ROAD {cost: 170, color: 'RED'}]->(f),
       (c)-[:ROAD {cost: 40, color: 'BLUE'}]->(d),
       (c)-[:ROAD {cost: 80, color: 'RED'}]->(e),
       (c)-[:ROAD {cost: 130, color: 'BLUE'}]->(f),
       (d)-[:ROAD {cost: 30, color: 'RED'}]->(e),
       (d)-[:ROAD {cost: 80, color: 'BLUE'}]->(f),
       (e)-[:ROAD {cost: 40, color: 'RED'}]->(f);

//Optionally Delete Node F
//MATCH (n {name: 'F'})
//DETACH DELETE n;
