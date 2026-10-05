/*
 * MCSP 0.9 bootstrap closure evaluator.
 *
 * Canonical bootstrap evaluator after the 0.8 JavaScript experiment.
 * No JSON parser or external dependency is required: the admitted graph is
 * compiled from the same 0.8 foundation model into explicit C data.
 *
 * C is an implementation carrier only. It does not define MCSP semantics.
 */

#include <stdio.h>
#include <string.h>

#define MAX_NODES 64
#define MAX_DEPS 12

typedef struct {
    const char *name;
    const char *deps[MAX_DEPS];
} Node;

static const char *foundation[] = {
    "CONSTRUCT","RELATION","DISTINGUISH","IDENTITY","SCOPE","COLLECTION",
    "ORDER","POSITION","CONFIGURATION","STATE","TRANSITION","OPERATION",
    "RULE","CONSTRAINT","CONDITION","OUTCOME","OCCURRENCE",NULL
};

static const Node nodes[] = {
    {"CONSTRUCT",{"IDENTITY","RELATION","STATE",NULL}},
    {"RELATION",{"CONSTRUCT","STATE",NULL}},
    {"DISTINGUISH",{"RELATION","SCOPE","CONDITION",NULL}},
    {"IDENTITY",{"DISTINGUISH","SCOPE","RELATION",NULL}},
    {"SCOPE",{"RELATION","COLLECTION",NULL}},
    {"COLLECTION",{"RELATION","ORDER",NULL}},
    {"ORDER",{"RELATION","POSITION",NULL}},
    {"POSITION",{"RELATION","SCOPE",NULL}},
    {"CONFIGURATION",{"CONSTRUCT","COLLECTION","ORDER","STATE",NULL}},
    {"STATE",{"CONFIGURATION","POSITION",NULL}},
    {"TRANSITION",{"STATE","OPERATION","CONSTRAINT","OUTCOME",NULL}},
    {"OPERATION",{"RULE","RELATION",NULL}},
    {"RULE",{"RELATION","CONSTRAINT","CONDITION",NULL}},
    {"CONSTRAINT",{"RELATION","CONDITION",NULL}},
    {"CONDITION",{"RELATION","STATE",NULL}},
    {"OUTCOME",{"STATE","TRANSITION",NULL}},
    {"OCCURRENCE",{"OPERATION","STATE","ORDER","TRANSITION",NULL}},
    {"REPRESENT",{"RELATION","CORRESPOND",NULL}},
    {"CORRESPOND",{"RELATION","RULE",NULL}},
    {"MAP",{"COLLECTION","CORRESPOND","RULE",NULL}},
    {"UNIT",{"CONSTRUCT","PARTITION",NULL}},
    {"EXTENT",{"POSITION","UNIT","RELATION",NULL}},
    {"WIDTH",{"EXTENT","UNIT",NULL}},
    {"VALUE",{"CONSTRUCT","REPRESENT","WIDTH",NULL}},
    {"ADDRESS",{"REPRESENT","POSITION","SCOPE",NULL}},
    {"TRANSLATE",{"MAP","POSITION","TRANSITION",NULL}},
    {"OBSERVE",{"STATE","ORDER","RELATION",NULL}},
    {"PARTITION",{"COLLECTION","RULE","RELATION",NULL}},
    {"COUNT",{"COLLECTION","UNIT","EXTENT",NULL}},
    {"ADMIT",{"CONSTRAINT","CONDITION",NULL}},
    {"EQUIVALENT",{"DISTINGUISH","SCOPE","CONSTRAINT","CONDITION",NULL}},
    {"PRESERVE",{"EQUIVALENT","REALIZATION","CONSTRAINT","CONDITION",NULL}},
    {"REALIZATION",{"MAP","CAPABILITY","PRESERVE",NULL}},
    {"CAPABILITY",{"RELATION","STATE",NULL}},
    {"READ",{"POSITION","WIDTH","TRANSITION",NULL}},
    {"WRITE",{"POSITION","WIDTH","TRANSITION",NULL}},
    {"COPY",{"VALUE","TRANSITION",NULL}},
    {"COMPUTE",{"OPERATION","VALUE","TRANSITION",NULL}},
    {"SCHEDULE",{"ORDER","CONSTRAINT","TRANSITION",NULL}},
    {"ALLOCATE",{"SCOPE","EXTENT","CONSTRAINT","RELATION","TRANSITION",NULL}},
    {"RELEASE",{"RELATION","TRANSITION",NULL}},
    {"TRANSFER",{"POSITION","EXTENT","CONSTRAINT","TRANSITION",NULL}},
    {"SIGNAL",{"OCCURRENCE","TRANSITION",NULL}},
    {NULL,{NULL}}
};

static int node_count(void) {
    int n=0; while(nodes[n].name) n++; return n;
}
static int find_node(const char *name) {
    int i; for(i=0; nodes[i].name; i++) if(strcmp(nodes[i].name,name)==0) return i;
    return -1;
}
static int is_foundation(const char *name) {
    int i; for(i=0; foundation[i]; i++) if(strcmp(foundation[i],name)==0) return 1;
    return 0;
}
static int foundation_count(void) {
    int n=0; while(foundation[n]) n++; return n;
}

static int visited[MAX_NODES], active[MAX_NODES];
static int cycles=0, failures=0, visited_count=0;

static void walk(int idx) {
    int d;
    if(idx < 0) { failures++; return; }
    if(active[idx]) { cycles++; return; }
    if(visited[idx]) return;
    active[idx]=1;
    for(d=0; nodes[idx].deps[d]; d++) {
        int next=find_node(nodes[idx].deps[d]);
        if(next < 0) {
            fprintf(stderr,"EXTERNAL_DEPENDENCY:%s->%s\n",nodes[idx].name,nodes[idx].deps[d]);
            failures++;
        } else walk(next);
    }
    active[idx]=0;
    visited[idx]=1;
    visited_count++;
}

int main(void) {
    int i, d, total=node_count(), fcount=foundation_count();

    if(total > MAX_NODES) {
        fprintf(stderr,"FAIL_LIMIT: node count exceeds MAX_NODES\n");
        return 1;
    }

    for(i=0; foundation[i]; i++) {
        if(find_node(foundation[i]) < 0) {
            fprintf(stderr,"FOUNDATION_UNDEFINED:%s\n",foundation[i]);
            failures++;
        }
    }

    for(i=0; nodes[i].name; i++) {
        for(d=0; nodes[i].deps[d]; d++) {
            if(find_node(nodes[i].deps[d]) < 0) failures++;
        }
    }

    for(i=0; foundation[i]; i++) {
        int idx=find_node(foundation[i]);
        if(idx >= 0) walk(idx);
    }

    for(i=0; foundation[i]; i++) {
        int idx=find_node(foundation[i]);
        if(idx < 0 || !visited[idx]) {
            fprintf(stderr,"FOUNDATION_UNREACHED:%s\n",foundation[i]);
            failures++;
        }
    }

    printf("{\n");
    printf("  \"format\": \"mcsp-bootstrap-0.9-c\",\n");
    printf("  \"foundation_count\": %d,\n",fcount);
    printf("  \"defined_count\": %d,\n",total);
    printf("  \"visited_count\": %d,\n",visited_count);
    printf("  \"explicit_cycle_count\": %d,\n",cycles);
    printf("  \"result\": \"%s\"\n",failures ? "FAIL" : "PASS");
    printf("}\n");

    (void)is_foundation; /* retained for subsequent qualification checks */
    return failures ? 1 : 0;
}
