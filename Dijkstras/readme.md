## Dijkstras Algorithm
### Novelty:
- Capable of storing/outputting direction information at each node (North/East/South/West) when traversing the map.
### File structure
1. Dijkstras.v: Dijkstras algorithm implemented in verilog
2. RAM.v: Single Port Read/Write SDRAM module to store node/dirction information
3. map_data.txt: Contains node and direction information
4. map_create.py: Helps to automatically initialize RAM.v in verilog. Copy pasting output of this file into RAM.v will initialize the direction in, direction out and adjacent matrices used in djikstras algorithm. 

