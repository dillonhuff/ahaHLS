#include "rams.h"

void sssp(ram<int, 128>* vertices, ram<int, 128>* dist, ram<int, 128>* newdist) {
  for (int i = 0; i < NUM_VERTS; i++) {
    int v = vertices[i];
    int tmp = dist[i];

    for (int e = v.edge; e; e = e->next) {
      j = e.target_vertex_id;
      if (dist[j] + e.weight < tmp) {
        tmp = dist[j] + e.weight;
      }
    }

    newdist[i] = tmp;
  }
}
