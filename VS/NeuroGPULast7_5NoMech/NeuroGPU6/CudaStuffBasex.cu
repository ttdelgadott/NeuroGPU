#include "CudaStuff.cuh"
#include "AllModels.cu"
#include "AllModels.cuh"

__constant__ MYFTYPE cCm[NSEG];
__constant__ MYSECONDFTYPE cE[NSEG];
__constant__ MYSECONDFTYPE cF[NSEG];
__constant__ MYDTYPE cFIdxs[NSEG*LOG_N_DEPTH];
__constant__ MYDTYPE cKs[NSEG];
__constant__ MYDTYPE cSegToComp[NSEG];
__constant__ MYDTYPE cBoolModel[NSEG * N_MODELS];//One day change this to bool
__constant__ MYDTYPE cRelStarts[N_FATHERS];//nFathers
__constant__ MYDTYPE cRelEnds[N_FATHERS];//nFathers
__constant__ MYDTYPE cFathers[N_FATHERS];//nFathers
__constant__ MYDTYPE cRelVec[N_CALL_FOR_FATHER];//nCallForFather
__constant__ MYDTYPE cSegStartI[N_CALL_FOR_FATHER+1];//nCallForFather
__constant__ MYDTYPE cSegEndI[N_CALL_FOR_FATHER+1];//nCallForFather

__constant__ MYDTYPE cCompByLevel32[COMP_DEPTH*WARPSIZE];//CompDepth
__constant__ MYDTYPE cCompByFLevel32[COMP_DEPTH*WARPSIZE];//CompFDepth
__constant__ MYDTYPE cLRelStarts[N_L_REL];//nLRel
__constant__ MYDTYPE cLRelEnds[N_L_REL];//nLRel
__constant__ MYDTYPE cFLRelStarts[N_F_L_REL];//nFLRel
__constant__ MYDTYPE cFLRelEnds[N_F_L_REL];//nFLRel
__constant__ MYDTYPE cSonNoVec[NSEG];//InMat.N 


#ifdef ILP1
	#define SUPERILPMACRO(x) ; ## x ## (1);
#endif
#ifdef ILP2
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2);
#endif
#ifdef ILP3
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3);
#endif
#ifdef ILP4
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); 
#endif
#ifdef ILP5
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); 
#endif
#ifdef ILP6
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6);
#endif
#ifdef ILP7
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7);
#endif
#ifdef ILP8
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8);
#endif
#ifdef ILP9
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9);
#endif
#ifdef ILP10
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10);
#endif
#ifdef ILP11
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11);
#endif
#ifdef ILP12
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12);
#endif
#ifdef ILP13
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13);
#endif
#ifdef ILP14
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14);
#endif
#ifdef ILP15
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15);
#endif
#ifdef ILP16
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16);
#endif
#ifdef ILP17
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17);
#endif
#ifdef ILP18
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18);
#endif
#ifdef ILP19
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19);
#endif
#ifdef ILP20
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20);
#endif
#ifdef ILP21
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21);
#endif
#ifdef ILP22
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22);
#endif
#ifdef ILP23
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23);
#endif
#ifdef ILP24
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24);
#endif
#ifdef ILP25
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25);
#endif
#ifdef ILP26
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26);
#endif
#ifdef ILP27
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27);
#endif
#ifdef ILP28
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28);
#endif
#ifdef ILP29
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29);
#endif
#ifdef ILP30
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30);
#endif
#ifdef ILP31
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31);
#endif
#ifdef ILP32
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); 
#endif
#ifdef ILP33
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33);
#endif
#ifdef ILP34
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34);
#endif
#ifdef ILP35
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35);
#endif
#ifdef ILP36
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36);
#endif
#ifdef ILP37
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37);
#endif
#ifdef ILP38
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38);
#endif
#ifdef ILP39
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39);
#endif
#ifdef ILP40
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40);
#endif
#ifdef ILP41
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41);
#endif
#ifdef ILP42
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42);
#endif
#ifdef ILP43
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43);
#endif
#ifdef ILP44
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44);
#endif
#ifdef ILP45
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44); ## x ## (45);
#endif
#ifdef ILP46
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44); ## x ## (45); ## x ## (46);
#endif
#ifdef ILP47
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44); ## x ## (45); ## x ## (46); ## x ## (47);
#endif
#ifdef ILP48
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44); ## x ## (45); ## x ## (46); ## x ## (47); ## x ## (48);
#endif
#ifdef ILP49
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44); ## x ## (45); ## x ## (46); ## x ## (47); ## x ## (48); ## x ## (49);
#endif
#ifdef ILP50
	#define SUPERILPMACRO(x) ; ## x ## (1); ## x ## (2); ## x ## (3); ## x ## (4); ## x ## (5); ## x ## (6); ## x ## (7); ## x ## (8); ## x ## (9); ## x ## (10); ## x ## (11); ## x ## (12); ## x ## (13); ## x ## (14); ## x ## (15); ## x ## (16); ## x ## (17); ## x ## (18); ## x ## (19); ## x ## (20); ## x ## (21); ## x ## (22); ## x ## (23); ## x ## (24); ## x ## (25); ## x ## (26); ## x ## (27); ## x ## (28); ## x ## (29); ## x ## (30); ## x ## (31); ## x ## (32); ## x ## (33); ## x ## (34); ## x ## (35); ## x ## (36); ## x ## (37); ## x ## (38); ## x ## (39); ## x ## (40); ## x ## (41); ## x ## (42); ## x ## (43); ## x ## (44); ## x ## (45); ## x ## (46); ## x ## (47); ## x ## (48); ## x ## (49); ## x ## (50);
#endif

__device__ void BeforeLU(HMat InMat, MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP, MYDTYPE Depth)
{
	MYDTYPE PIdx=threadIdx.x;
	MYDTYPE i,j,CurJ,CurB,t, CurLevel,LRelIndex;
	MYDTYPE JumctionI;
	LRelIndex=cLRelStarts[CurLevel];
	LRelIndex=LRelIndex+cLRelEnds[CurLevel];
	for(CurLevel=0;CurLevel<=Depth;CurLevel++) {
		
		for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=cLRelEnds[CurLevel];LRelIndex++){ 
		//for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
			JumctionI=cCompByLevel32[LRelIndex*WARPSIZE+PIdx]-1;
			for(i=cSegStartI[JumctionI]-1;i<cSegEndI[JumctionI];i++) {
				MYSECONDFTYPE uHPm1=uHP[i-1];
			
				uHP[i]=uHP[i]-cF[i-1]*(cE[i-1]/uHPm1); // So far same as paper parallel
				uHPm1=uHP[i-1];
				MYSECONDFTYPE bHPm1=bHP[i-1];
				bHP[i]=bHP[i]-bHPm1*cE[i-1]/uHPm1; // bH is y
			}
		}
		if(CurLevel<Depth) {
			for(LRelIndex=cFLRelStarts[CurLevel];LRelIndex<=cFLRelEnds[CurLevel];LRelIndex++){ 
				CurB=cCompByFLevel32[(LRelIndex)*WARPSIZE+PIdx]-1;//RB i inserted another  -1 into the index RB 2 i removed the-1 from the curlevel 
				CurJ=cFathers[CurB]-1;
				MYDTYPE St=cRelStarts[CurB];
				MYDTYPE En=cRelEnds[CurB];
				for(j=St;j<=En;j++) {
					t=cRelVec[j-1]-1;
					MYSECONDFTYPE uHPm1=uHP[t-1];
					uHP[CurJ]-=cF[t-1]*(cE[t-1]/uHPm1); 
					uHPm1=uHP[t-1];
					MYSECONDFTYPE bHPm1=bHP[t-1];
					bHP[CurJ]-=bHPm1*cE[t-1]/uHPm1; 
				}
			}
		}	
	}
}

#ifdef BKSUB1
__device__ void BkSub(HMat InMat, MYSECONDFTYPE* PX, MYSECONDFTYPE* PF,MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP, MYDTYPE LognDepth)
{
	// MYDTYPE PIdx_1=threadIdx.x; // MYDTYPE NextID_1;
#define THISCOMMANDHERE1(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*(## VARILP -1)); MYDTYPE NextID_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHERE1)
	MYDTYPE i;
	
	PX=bHP;
	PF=uHP;
	// PX[PIdx_1]=PX[PIdx_1]/PF[PIdx_1]; // PF[PIdx_1]=-cF[PIdx_1]/PF[PIdx_1];
#define THISCOMMANDHERE2(VARILP) PX[PIdx_ ## VARILP ]=PX[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ]; PF[PIdx_ ## VARILP ]=-cF[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE2)

	PX[InMat.N]=0;
	PF[InMat.N]=1;
	for(i=0;i<LognDepth;i++) {	
		// NextID_1=cFIdxs[i*InMat.N+PIdx_1]-1; // MYFTYPE OldPXj_1=PX[PIdx_1]; // MYFTYPE OldPXNextID_1=PX[NextID_1]; // PX[PIdx_1]=OldPXj_1+OldPXNextID_1*PF[PIdx_1];
#define THISCOMMANDHERE3(VARILP) NextID_ ## VARILP =cFIdxs[i*InMat.N+PIdx_ ## VARILP ]-1; MYFTYPE OldPXj_ ## VARILP =PX[PIdx_ ## VARILP ]; MYFTYPE OldPXNextID_ ## VARILP =PX[NextID_ ## VARILP ]; PX[PIdx_ ## VARILP ]=OldPXj_ ## VARILP +OldPXNextID_ ## VARILP *PF[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE3)

		// PX[j]=PX[j]+PX[NextID]*PF[j];
		// PF[j]=PF[j]*PF[NextID];
		// MYFTYPE OldPFj_1=PF[PIdx_1]; // MYFTYPE OldPFNextID_1=PF[NextID_1]; // PF[PIdx_1]=OldPFj_1*OldPFNextID_1;
#define THISCOMMANDHERE4(VARILP) MYFTYPE OldPFj_ ## VARILP =PF[PIdx_ ## VARILP ]; MYFTYPE OldPFNextID_ ## VARILP =PF[NextID_ ## VARILP ]; PF[PIdx_ ## VARILP ]=OldPFj_ ## VARILP *OldPFNextID_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHERE4)
	}
}
#endif

#ifdef BKSUB2
__device__ void BkSub(HMat InMat, MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP,MYSECONDFTYPE* Out, MYDTYPE Depth)
{
	// MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2); Out[PIdx_2]=0; // might be useless?
#define THISCOMMANDHEREB1(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1)); Out[PIdx_ ## VARILP ]=0;
	SUPERILPMACRO(THISCOMMANDHEREB1)

	MYDTYPE j,CurJ,CurB,t;
	MYDTYPE JumctionI;
	short CurLevel,i;

	// get KsB from MATLAB (this comes instead of FIdxsX)
	// KsB=Ks; // do in matlab

	// bPX=zeros(1,N); // might be useless
	// for CurLevel=Depth:-1:0
	MYDTYPE LRelIndex,k;
	MYFTYPE temp;
 for(CurLevel=Depth;CurLevel>=0;CurLevel--) {
  //     Run all independent set for this level, in parallel
  // for JumctionI=find(Level==CurLevel) % in parallel
  for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=cLRelEnds[CurLevel];LRelIndex++){ 
   JumctionI=cCompByLevel32[LRelIndex*WARPSIZE+PIdx_1]-1;
   // for i=(cSegEndI(JumctionI)):-1:(cSegStartI(JumctionI)-1)
   for(i=cSegEndI[JumctionI]-1;i>=(cSegStartI[JumctionI]-2);i--) {
    // k=cKsB(i+1);
     k=cKsB[i+1];
	 
    // bPX(i)=(bH(i)-bPX(k)*f(i))/uH(i);
   Out[i]=(bHP[i]-Out[k]*cF[i])/uHP[i];
   }
  }
 }
 } 
#endif

__device__ void runSimulation(HMat InMat,MYFTYPE* ParamsM, MYFTYPE* V,Stim stim,Sim sim,MYFTYPE* VHotGlobal,MYFTYPE* SMemVHot,MYFTYPE* amps,MYDTYPE offset)
{


	MYSECONDFTYPE *uHP,*bHP;
	MYDTYPE StimID=threadIdx.y;
		
#ifdef BKSUB2
    MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(InMat.N+2*WARPSIZE)*sizeof(MYFTYPE);
#endif
#ifdef BKSUB1

  MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(WARPSIZE + sim.NRecSites*(WARPSIZE))*sizeof(MYFTYPE);
  PerStimulus =ceilf(MYSECONDFTYPE(PerStimulus)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE); 
#endif
	//MYDTYPE PerStimulus;
	//PerStimulus = InMat.N+2;
	offset+=PerStimulus*threadIdx.y;
	uHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	//uHP[InMat.N+2] =0;
	bHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	//bHP[InMat.N+2] =0;
	offset = ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	//Vs = (MYFTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYFTYPE);
	// Vs[PIdx_3]=V[PIdx_3];
	SMemVHot = (MYFTYPE*) &smem[offset];
	offset+=(WARPSIZE)*sim.NRecSites*sizeof(MYFTYPE);
	SMemVHot[WARPSIZE]=0;
    amps = (MYFTYPE*) &smem[offset];
    offset+=WARPSIZE*sizeof(MYFTYPE);
	MYDTYPE NeuronID = blockIdx.x;
	int Nt=stim.Nt;
	MYFTYPE t=0;
	MYSECONDFTYPE *PX,*PF;
	PX=bHP;
	PF=uHP;
	#define THISCOMMANDHERE18(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1));
	SUPERILPMACRO(THISCOMMANDHERE18)

	 #define THISCOMMANDHERE19(VARILP) MYFTYPE isModel_ ## VARILP , dVec_ ## VARILP , Vmid_ ## VARILP ; MYFTYPE ModelStates_ ## VARILP [NSTATES]; MYFTYPE v_ ## VARILP =V[PIdx_ ## VARILP ]; MYFTYPE dv_ ## VARILP;
	SUPERILPMACRO(THISCOMMANDHERE19)

	 #define THISCOMMANDHERE20(VARILP) MYSECONDFTYPE sumCurrents_ ## VARILP=0 ,sumCurrentsDv_ ## VARILP=0; MYFTYPE  sumConductivity_ ## VARILP=0 ,sumConductivityDv_ ## VARILP=0 ;
	SUPERILPMACRO(THISCOMMANDHERE20)
	// end for model in init
	SUPERILPMACRO(SET_STATES)
	#define THISCOMMANDHERE21(VARILP) MYDTYPE SonNo_ ## VARILP =cSonNoVec[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE21)
	
	#define THISCOMMANDHERE22(VARILP) bHP[PIdx_ ## VARILP]=0;dv_ ## VARILP =0;
	SUPERILPMACRO(THISCOMMANDHERE22)


	#define THISCOMMANDHERE23(VARILP) MYDTYPE parentIndex_ ## VARILP ; MYDTYPE Eidx_ ## VARILP ; Eidx_ ## VARILP = InMat.N-PIdx_ ## VARILP -1;
	SUPERILPMACRO(THISCOMMANDHERE23)
	// RRRXXX This probably should be in ILP too!
	if(Eidx_1>InMat.N-1){
		Eidx_1=InMat.N-1;
	}
	MYDTYPE perThreadParamMSize = InMat.NComps*NPARAMS;
#define param_macro(paramInd,segmentInd) ParamsM[NeuronID*perThreadParamMSize + paramInd*InMat.NComps+cSegToComp[segmentInd] ]
	
	SUPERILPMACRO(CALL_TO_INIT_STATES_CU)
	
		// parentIndex_3 =InMat.N-InMat.Ks[InMat.N-PIdx_3];
#define THISCOMMANDHERE24(VARILP) parentIndex_ ## VARILP =InMat.N-cKs[InMat.N-PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE24)
	MYDTYPE stimLoc = stim.loc;
    MYFTYPE stimArea = stim.area;
    MYDTYPE dtCounter=0;
    MYFTYPE  dt = sim.dt;
#ifndef STIMFROMFILE
    MYFTYPE stimDel = stim.dels[StimID];//Should be constant
    MYFTYPE stimDur = stim.durs[StimID];//Should be constant
    MYFTYPE stimAmp = stim.amps[StimID];
#endif // !STIMFROMFILE
	// MYFTYPE rhs_3,D_3,gModel_3,StimCurrent_3,dv_3;
#define THISCOMMANDHERE25(VARILP) MYSECONDFTYPE rhs_ ## VARILP ,D_ ## VARILP; MYFTYPE gModel_ ## VARILP ,StimCurrent_ ## VARILP;
	SUPERILPMACRO(THISCOMMANDHERE25)

for(int i=0;i<Nt;i++) {
        if(i==stim.dtInds[dtCounter]){
                dt = stim.durs[dtCounter];
                if (dtCounter != stim.numofdts-1){
                    dtCounter++;
                }
        }
        t+=0.5*dt;
 
       if((i%(WARPSIZE)==0)){
            if(i>0){
               for(int recInd =0;recInd<sim.NRecSites;recInd++){
					VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) +threadIdx.y*Nt*sim.NRecSites+recInd*Nt + (i-WARPSIZE)+PIdx_1]=SMemVHot[WARPSIZE*recInd + PIdx_1];
				}
            }
			
            amps[PIdx_1]=stim.amps[threadIdx.y*Nt+i+PIdx_1];
        }
        for(int recInd =0;recInd<sim.NRecSites;recInd++){
			if(sim.RecSites[recInd]%WARPSIZE == threadIdx.x)
				//This is done by all threads why???
				SMemVHot[recInd*WARPSIZE+i%(WARPSIZE)]=v_1;//This is going to be challenging to make it general but possible.
			
		}
		 // rhs_3=0; // D_3=0;// StimCurrent_3=0;
#define THISCOMMANDHERE26(VARILP) rhs_ ## VARILP =0; D_ ## VARILP =0; sumCurrents_ ## VARILP=0; sumConductivity_ ## VARILP=0; sumCurrentsDv_ ## VARILP=0; sumConductivityDv_ ## VARILP=0;StimCurrent_ ## VARILP =0;
	SUPERILPMACRO(THISCOMMANDHERE26)
		// Before matrix
		// if(t>=stimDel && t<stimDel+stimDur && PIdx_3 == stimLoc){StimCurrent_3 = 100*stimAmp/stimArea;}
#ifndef STIMFROMFILE
    #define THISCOMMANDHERE27(VARILP) if(t>=stimDel && t<stimDel+stimDur && PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP  = 100*stimAmp/stimArea;}
	SUPERILPMACRO(THISCOMMANDHERE27)
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
    
    #define THISCOMMANDHERE28(VARILP) if(PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP = 100*amps[i%WARPSIZE]/stimArea;}
	SUPERILPMACRO(THISCOMMANDHERE28)
#endif // STIMFROMFILE
	SUPERILPMACRO(CALL_TO_BREAK_DV_CU)
	SUPERILPMACRO(CALL_TO_BREAK_CU)

	// gModel_3 = (sumCurrentsDv_3-sumCurrents_3)/0.001; 
#define THISCOMMANDHERE29(VARILP) gModel_ ## VARILP  = (sumCurrentsDv_ ## VARILP -sumCurrents_ ## VARILP )/EPS_V;  
	SUPERILPMACRO(THISCOMMANDHERE29)
	
#define THISCOMMANDHERE30(VARILP) rhs_ ## VARILP =StimCurrent_ ## VARILP -sumCurrents_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHERE30)
#define THISCOMMANDHERE31(VARILP) D_ ## VARILP =gModel_ ## VARILP +cCm[PIdx_ ## VARILP ]/(dt*1000); D_ ## VARILP -=cF[InMat.N-PIdx_ ## VARILP -1];
	SUPERILPMACRO(THISCOMMANDHERE31)
   
    //this should be out and correct cKs
	if(PIdx_1==0) {
		parentIndex_1=0;
	};
#define THISCOMMANDHERE32(VARILP)  dv_ ## VARILP +=bHP[InMat.N-parentIndex_ ## VARILP -1]-bHP[InMat.N-PIdx_ ## VARILP -1]; rhs_ ## VARILP -=cF[InMat.N-PIdx_ ## VARILP -1]*dv_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHERE32)
		// D_3=sumConductivity_3+InMat.Cms[PIdx_3]/(sim.dt*1000); // D_3-=InMat.f[InMat.N-PIdx_3-1];
		// bHP[InMat.N-PIdx_3-1]=rhs_3; // uHP[InMat.N-PIdx_3-1]=D_3;
#define THISCOMMANDHERE33(VARILP) bHP[InMat.N-PIdx_ ## VARILP -1]=rhs_ ## VARILP ; uHP[InMat.N-PIdx_ ## VARILP -1]=D_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE33)
		syncthreads();
		
		// if(SonNo_3==1) {bHP[InMat.N-parentIndex_3-1]+=cE[Eidx_3]*dv_3;uHP[InMat.N-parentIndex_3-1]-=cE[Eidx_3];}
		
#define THISCOMMANDHERE34(VARILP) if(cSonNoVec[PIdx_ ## VARILP] ==1) {bHP[InMat.N-parentIndex_ ## VARILP -1]+=cE[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[InMat.N-parentIndex_ ## VARILP -1]-=cE[Eidx_ ## VARILP ];}
		SUPERILPMACRO(THISCOMMANDHERE34)
		// if(SonNo_3==2) {bHP[InMat.N-parentIndex_3-1]+=InMat.e[Eidx_3]*dv_3;uHP[InMat.N-parentIndex_3-1]-=InMat.e[Eidx_3];}
#define THISCOMMANDHERE35(VARILP) if(cSonNoVec[PIdx_ ## VARILP] ==2) {bHP[InMat.N-parentIndex_ ## VARILP -1]+=cE[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[InMat.N-parentIndex_ ## VARILP -1]-=cE[Eidx_ ## VARILP ];}
		SUPERILPMACRO(THISCOMMANDHERE35)
		syncthreads();
		BeforeLU(InMat,uHP,bHP,InMat.Depth);
#ifdef BKSUB1
		BkSub(InMat, PX,PF,uHP,bHP,InMat.LognDepth);
		#define THISCOMMANDHERE36(VARILP) Vmid_ ## VARILP =PX[InMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ; 
		SUPERILPMACRO(THISCOMMANDHERE36)
#endif

		
#ifdef BKSUB2
		#define THISCOMMANDHERE37(VARILP) MYFTYPE vTemp_ ## VARILP=Vs[PIdx_ ## VARILP];
		SUPERILPMACRO(THISCOMMANDHERE37)
		syncthreads();
		BkSub(InMat,uHP,bHP,Vs,InMat.Depth);
		syncthreads();
		PX=Vs;

#define THISCOMMANDHERE38(VARILP) Vmid_ ## VARILP =PX[InMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE38)
		syncthreads(); 
#define THISCOMMANDHERE39(VARILP) Vs[PIdx_ ## VARILP ]= vTemp_ ## VARILP +Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE39)
#endif		
            t+=0.5*dt;

        

//      if(InMat.boolModel[PIdx_1 +0*InMat.N]){CuDerivModel_ca(dt, v_1,ModelStates_1[0],ModelStates_1[1],p0_1 ,p1_1 ,ModelStates_1[8],ModelStates_1[9]);} if(InMat.boolModel[PIdx_1 +1*InMat.N]){CuDerivModel_cad(dt, v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(InMat.boolModel[PIdx_1 +2*InMat.N]){CuDerivModel_kca(dt, v_1,ModelStates_1[3],p2_1 ,p3_1 ,p4_1 ,p5_1 ,ModelStates_1[8]);} if(InMat.boolModel[PIdx_1 +3*InMat.N]){CuDerivModel_km(dt, v_1,ModelStates_1[4],p6_1 ,p7_1 ,p8_1 ,p9_1 ,p10_1 );} if(InMat.boolModel[PIdx_1 +4*InMat.N]){CuDerivModel_kv(dt, v_1,ModelStates_1[5],p11_1 ,p12_1 ,p13_1 ,p14_1 ,p15_1 );} if(InMat.boolModel[PIdx_1 +5*InMat.N]){CuDerivModel_na(dt, v_1,ModelStates_1[6],ModelStates_1[7],p16_1 ,p17_1 ,p18_1 ,p19_1 ,p20_1 ,p21_1 ,p22_1 ,p23_1 ,p24_1 ,p25_1 ,p26_1 ,p27_1 );}  if(InMat.boolModel[PIdx_2 +0*InMat.N]){CuDerivModel_ca(dt, v_2,ModelStates_2[0],ModelStates_2[1],p0_2 ,p1_2 ,ModelStates_2[8],ModelStates_2[9]);} if(InMat.boolModel[PIdx_2 +1*InMat.N]){CuDerivModel_cad(dt, v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(InMat.boolModel[PIdx_2 +2*InMat.N]){CuDerivModel_kca(dt, v_2,ModelStates_2[3],p2_2 ,p3_2 ,p4_2 ,p5_2 ,ModelStates_2[8]);} if(InMat.boolModel[PIdx_2 +3*InMat.N]){CuDerivModel_km(dt, v_2,ModelStates_2[4],p6_2 ,p7_2 ,p8_2 ,p9_2 ,p10_2 );} if(InMat.boolModel[PIdx_2 +4*InMat.N]){CuDerivModel_kv(dt, v_2,ModelStates_2[5],p11_2 ,p12_2 ,p13_2 ,p14_2 ,p15_2 );} if(InMat.boolModel[PIdx_2 +5*InMat.N]){CuDerivModel_na(dt, v_2,ModelStates_2[6],ModelStates_2[7],p16_2 ,p17_2 ,p18_2 ,p19_2 ,p20_2 ,p21_2 ,p22_2 ,p23_2 ,p24_2 ,p25_2 ,p26_2 ,p27_2 );}  if(InMat.boolModel[PIdx_3 +0*InMat.N]){CuDerivModel_ca(dt, v_3,ModelStates_3[0],ModelStates_3[1],p0_3 ,p1_3 ,ModelStates_3[8],ModelStates_3[9]);} if(InMat.boolModel[PIdx_3 +1*InMat.N]){CuDerivModel_cad(dt, v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(InMat.boolModel[PIdx_3 +2*InMat.N]){CuDerivModel_kca(dt, v_3,ModelStates_3[3],p2_3 ,p3_3 ,p4_3 ,p5_3 ,ModelStates_3[8]);} if(InMat.boolModel[PIdx_3 +3*InMat.N]){CuDerivModel_km(dt, v_3,ModelStates_3[4],p6_3 ,p7_3 ,p8_3 ,p9_3 ,p10_3 );} if(InMat.boolModel[PIdx_3 +4*InMat.N]){CuDerivModel_kv(dt, v_3,ModelStates_3[5],p11_3 ,p12_3 ,p13_3 ,p14_3 ,p15_3 );} if(InMat.boolModel[PIdx_3 +5*InMat.N]){CuDerivModel_na(dt, v_3,ModelStates_3[6],ModelStates_3[7],p16_3 ,p17_3 ,p18_3 ,p19_3 ,p20_3 ,p21_3 ,p22_3 ,p23_3 ,p24_3 ,p25_3 ,p26_3 ,p27_3 );}
		SUPERILPMACRO(CALL_TO_DERIV_CU)

 
 
    }
	//This one looks suspicious but leaving it and will check it later.
   for(int recInd =0;recInd<sim.NRecSites;recInd++){
		VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) +threadIdx.y*Nt*sim.NRecSites+recInd*Nt + Nt-WARPSIZE+PIdx_1]=SMemVHot[WARPSIZE*recInd + PIdx_1];
	}
 
}
__global__ void NeuroGPUKernel(Stim stim, MYFTYPE* ParamsM, Sim sim, HMat InMat, MYFTYPE *V,MYFTYPE* VHotGlobal,MYDTYPE CompDepth,MYDTYPE CompFDepth)
{

	MYFTYPE *amps,*SMemVHot;
	MYDTYPE offset=0;
	
	
	
	runSimulation(InMat,ParamsM,V,stim,sim,VHotGlobal,SMemVHot,amps,offset);

}
void ReadParamsMatX(const char* FN,MYFTYPE* ParamsM,MYDTYPE NParams,MYDTYPE Nx) {
	char FileName[300];
	//sprintf(FileName,"%s%d.mat",FN,MUL32*32);
	sprintf(FileName,"%sForC.mat",FN);
	FILE *fl = fopen(FileName, "rb"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read TreeData.x\n");
		return;
	}
	fread(ParamsM, sizeof(MYFTYPE), Nx*NParams, fl);
	fclose(fl);
}
MYFTYPE* ReadAllParams(const char* FN,MYDTYPE NParams,MYDTYPE Nx,MYDTYPE  &ntemp) {
	char FileName[300];
	//sprintf(FileName,"%s%d.mat",FN,MUL32*32);
	//sprintf(FileName,"%sForC.mat",FN);
	MYFTYPE* ans;
	MYDTYPE tmp;
	FILE *fl = fopen(FN, "rb"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read TreeData.x\n");
		return nullptr;
	}
	fread(&tmp, sizeof(MYDTYPE),1, fl);
		ntemp = tmp;

	ans=(MYFTYPE *)malloc(Nx * NPARAMS * tmp * sizeof(MYFTYPE ));
	fread(ans, sizeof(MYFTYPE), tmp*Nx*NParams, fl);
	fclose(fl);
	return ans;
}
void ReadParamsMat(const char* FN,MYFTYPE** ParamsM,MYDTYPE NParams,MYDTYPE Nx) {
	char FileName[300];
	//sprintf(FileName,"%s%d.mat",FN,MUL32*32);
	sprintf(FileName,"%sForC.mat",FN);
	FILE *fl = fopen(FileName, "rb"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read TreeData.x\n");
		return;
	}
	for(int i=0;i<NParams;i++){
		ParamsM[i]=(MYFTYPE*)malloc(Nx * sizeof(MYFTYPE));
		fread(ParamsM[i], sizeof(MYFTYPE), Nx, fl);
	}
	fclose(fl);
}


cudaError_t stEfork2TimeLoopGPU(Stim stim, Sim sim, MYFTYPE* ParamsM, HMat& InMat, MYFTYPE* V,MYDTYPE CompDepth,MYDTYPE CompFDepth,MYDTYPE NSets) { 

	cudaError_t cudaStatus;
	cudaStatus = cudaSetDevice(0);
	cudaStatus = cudaDeviceReset();
	MYFTYPE *VHotsGlobal,*VHotsHost;
	MYDTYPE Nt=stim.Nt;
	cudaMallocHost((void**)&VHotsHost,stim.NStimuli*Nt*sim.NRecSites*NSets*sizeof(MYFTYPE));
	
	int i,j,t;
	// For matrix -
	MYFTYPE *PXOut_d,*PFOut_d;
	MYFTYPE *uHPOut_d, *bHPOut_d;
	HMat Mat_d;
	Mat_d.N=InMat.N;
	Mat_d.NComps=InMat.NComps;
	Mat_d.Depth=InMat.Depth;
	Mat_d.NModels=InMat.NModels;
	Mat_d.LognDepth=InMat.LognDepth;
	Mat_d.nFathers=InMat.nFathers;
	Mat_d.nCallForFather=InMat.nCallForFather;
	Mat_d.nLRel=InMat.nLRel;
	Mat_d.nFLRel=InMat.nFLRel;
	Stim stim_d;
	stim_d.NStimuli = stim.NStimuli;
	stim_d.comp = stim.comp;
	stim_d.area = stim.area;
	stim_d.loc = stim.loc;
	stim_d.Nt = stim.Nt;
	Sim sim_d; 	 			
	sim_d.Celsius = sim.Celsius; 	 	
	sim_d.dt = sim.dt; 	 	
	sim_d.NRecSites = sim.NRecSites; 	 	
	sim_d.TFinal = sim.TFinal; 
#ifndef STIMFROMFILE
    cudaStatus = cudaMalloc((void**)&stim_d.dels, stim_d.NStimuli * sizeof(MYFTYPE));
    cudaStatus = cudaMalloc((void**)&stim_d.durs, stim_d.NStimuli * sizeof(MYFTYPE));
    cudaStatus = cudaMalloc((void**)&stim_d.amps, stim_d.NStimuli * sizeof(MYFTYPE));
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE

    stim_d.numofdts = stim.numofdts;
    cudaStatus = cudaMalloc((void**)&stim_d.dtInds, stim_d.numofdts * sizeof(MYDTYPE));
    cudaStatus = cudaMalloc((void**)&stim_d.durs, stim_d.numofdts * sizeof(MYFTYPE));
    cudaStatus = cudaMalloc((void**)&stim_d.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE));
#endif // STIMFROMFILE
	cudaStatus = cudaMalloc((void**)&sim_d.RecSites, sim_d.NRecSites * sizeof(MYDTYPE));
	


	//cudaStatus = cudaMalloc((void**)&Mat_d.e, InMat.N * sizeof(MYSECONDFTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.f, InMat.N * sizeof(MYSECONDFTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.Ks, InMat.N * sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.SegToComp, InMat.N * sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.boolModel, InMat.N * InMat.NModels* sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.Cms, InMat.N * sizeof(MYFTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.SonNoVec, InMat.N* sizeof(MYDTYPE));
	
	//cudaStatus = cudaMalloc((void**)&Mat_d.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	
	//cudaStatus = cudaMalloc((void**)&Mat_d.RelStarts, InMat.nFathers * sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.RelEnds, (InMat.nFathers) * sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.RelVec, InMat.nCallForFather * sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	//cudaStatus = cudaMalloc((void**)&Mat_d.SegEndI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&VHotsGlobal, NSets*Nt *stim.NStimuli* sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&VHotsGlobal, NSets*sim_d.NRecSites*Nt *stim.NStimuli* sizeof(MYFTYPE));
	// 32 data
#ifdef BKSUB1
	//cudaStatus = cudaMalloc((void**)&Mat_d.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE));
#endif
#ifdef BKSUB2
	cudaStatus = cudaMalloc((void**)&Mat_d.KsB, (InMat.N +1)* sizeof(MYDTYPE));
#endif
	/*cudaStatus = cudaMalloc((void**)&Mat_d.CompByLevel32, (CompDepth)*WARPSIZE* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.CompByFLevel32, (CompFDepth)*WARPSIZE* sizeof(MYDTYPE));

	cudaStatus = cudaMalloc((void**)&Mat_d.LRelStarts, Mat_d.nLRel* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.LRelEnds, Mat_d.nLRel* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.FLRelStarts, Mat_d.nFLRel* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.FLRelEnds, Mat_d.nFLRel* sizeof(MYDTYPE));
*/
	

	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}

	#ifndef STIMFROMFILE
 
    cudaStatus = cudaMemcpy(stim_d.dels, stim.dels, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
    cudaStatus = cudaMemcpy(stim_d.durs, stim.durs, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
    cudaStatus = cudaMemcpy(stim_d.amps, stim.amps, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
	
    cudaStatus = cudaMemcpy(stim_d.dtInds, stim.dtInds, stim.numofdts * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
    cudaStatus = cudaMemcpy(stim_d.durs, stim.durs, stim.numofdts * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
    cudaStatus = cudaMemcpy(stim_d.amps, stim.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
#endif // STIMFROMFILE
	cudaStatus = cudaMemcpy(sim_d.RecSites, sim.RecSites, sim_d.NRecSites * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	//cudaStatus = cudaMalloc((void**)&Mat_d.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.e, InMat.e, InMat.N * sizeof(MYSECONDFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cE, InMat.e, InMat.N * sizeof(MYSECONDFTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.f, InMat.f, InMat.N * sizeof(MYSECONDFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cF, InMat.f, InMat.N * sizeof(MYSECONDFTYPE));
	cudaStatus = cudaMemcpyToSymbol(cKs, InMat.Ks, InMat.N * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.Ks, InMat.Ks, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	//cudaStatus = cudaMemcpy(Mat_d.SegToComp, InMat.SegToComp, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cSegToComp, InMat.SegToComp, InMat.N * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.boolModel, InMat.boolModel, InMat.N * InMat.NModels * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cBoolModel, InMat.boolModel, InMat.N * InMat.NModels * sizeof(MYDTYPE));

	cudaStatus = cudaMemcpyToSymbol(cCm, InMat.Cms, InMat.N * sizeof(MYFTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.SonNoVec, InMat.SonNoVec, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cSonNoVec, InMat.SonNoVec, InMat.N * sizeof(MYDTYPE));
	
	
	//cudaStatus = cudaMemcpy(Mat_d.RelStarts, InMat.RelStarts, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cRelStarts, InMat.RelStarts, InMat.nFathers * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.RelEnds, InMat.RelEnds, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cRelEnds, InMat.RelEnds, InMat.nFathers * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.RelVec, InMat.RelVec, InMat.nCallForFather* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cRelVec, InMat.RelVec, InMat.nCallForFather* sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.SegStartI, InMat.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cSegStartI, InMat.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.SegEndI, InMat.SegEndI, (InMat.nCallForFather+1)* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cSegEndI, InMat.SegEndI, (InMat.nCallForFather+1)* sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.Fathers, InMat.Fathers, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cFathers, InMat.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	
	
	// 32 data
#ifdef BKSUB1
	//cudaStatus = cudaMemcpy(Mat_d.FIdxs, InMat.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cFIdxs, InMat.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE));
#endif
#ifdef BKSUB2
	cudaStatus = cudaMemcpy(Mat_d.KsB, InMat.KsB,(InMat.N+1)*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
#endif

	//cudaStatus = cudaMemcpy(Mat_d.CompByLevel32, InMat.CompByLevel32, (CompDepth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cCompByLevel32, InMat.CompByLevel32, (CompDepth)*WARPSIZE*sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.CompByFLevel32, InMat.CompByFLevel32, (CompFDepth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cCompByFLevel32, InMat.CompByFLevel32, (CompFDepth)*WARPSIZE*sizeof(MYDTYPE));


	//cudaStatus = cudaMemcpy(Mat_d.LRelStarts, InMat.LRelStarts,InMat.nLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cLRelStarts, InMat.LRelStarts,InMat.nLRel*sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.LRelEnds, InMat.LRelEnds,InMat.nLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cLRelEnds, InMat.LRelEnds,InMat.nLRel*sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.FLRelStarts, InMat.FLRelStarts,InMat.nFLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cFLRelStarts, InMat.FLRelStarts,InMat.nFLRel*sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.FLRelEnds, InMat.FLRelEnds,InMat.nFLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cFLRelEnds, InMat.FLRelEnds,InMat.nFLRel*sizeof(MYDTYPE));


	
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMemcpyToDevice failed!");
		return cudaStatus;  
	}

	cudaStatus = cudaMalloc((void**)&PXOut_d, (InMat.N+1) * sizeof(MYSECONDFTYPE));
	cudaStatus = cudaMalloc((void**)&PFOut_d, (InMat.N+1) * sizeof(MYSECONDFTYPE));
	cudaStatus = cudaThreadSynchronize();
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching stEfork2TimeLoopGPU!\n", cudaStatus);
		return cudaStatus;
	}

	// A bit more
	/*MYFTYPE *d_d,*Iapp_d,*VHots_d,*dOrig_d,*V_d;

	cudaStatus = cudaMalloc((void**)&d_d, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&VHots_d, sim.Nt*NSTIMULI * sizeof(MYFTYPE*));
	cudaStatus = cudaMalloc((void**)&dOrig_d, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&V_d, InMat.N * sizeof(MYFTYPE));
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}*/
	MYFTYPE *V_d;
	cudaStatus = cudaMalloc((void**)&V_d, InMat.N * sizeof(MYFTYPE));

	//RRR  For model
	// allocation
	MYFTYPE *d_modelParams;
	cudaStatus = cudaMalloc((void**)&d_modelParams, NPARAMS * InMat.NComps *NSets * sizeof(MYFTYPE));
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}
	// copying
	
	cudaStatus = cudaMemcpy(d_modelParams, ParamsM, NPARAMS * InMat.NComps * NSets *sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(V_d, V, InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMemcpyToDevice failed!");
		return cudaStatus;  
	}

	dim3 blockDim(WARPSIZE,stim.NStimuli);
	dim3 gridDim(NSets);

	MYDTYPE offset=0;
	//offset+=InMat.N*sizeof(MYSECONDFTYPE);
	//offset+=InMat.N*sizeof(MYSECONDFTYPE);
	//offset+=InMat.N*sizeof(MYFTYPE);
	// 1 - e,f,Cms
#ifdef BKSUB1
	//offset+=InMat.N*InMat.LognDepth*sizeof(MYDTYPE);
#endif
	//offset+=InMat.N*sizeof(MYDTYPE);
	//offset+=InMat.N*sizeof(MYDTYPE);
	//offset+=InMat.N*InMat.NModels*sizeof(MYDTYPE);
	// 2 FIdxs, Ks, SegToComp,boolModel
	//offset+=InMat.nFathers*sizeof(MYDTYPE); // RelStarts
	//offset+=InMat.nFathers*sizeof(MYDTYPE); // RelEnds
	//offset+=InMat.nFathers*sizeof(MYDTYPE); // Fathers
	//offset+=InMat.nCallForFather*sizeof(MYDTYPE); // RelVec
	//offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE); // SegStartI
	//offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE); // SegEndI
	
	// 3 RelStarts RelEnds RelVec SegStartI SegEndI Fathers
	//offset+=WARPSIZE*(CompDepth)*sizeof(MYDTYPE);
	//offset+=WARPSIZE*(CompFDepth)*sizeof(MYDTYPE);
	//// 4 CompByLevel32 CompByFLevel32
	//offset+=Mat_d.nLRel*sizeof(MYDTYPE);
	//offset+=Mat_d.nLRel*sizeof(MYDTYPE);
	//offset+=Mat_d.nFLRel*sizeof(MYDTYPE);
	//offset+=Mat_d.nFLRel*sizeof(MYDTYPE);
#ifdef BKSUB2
	offset+=(Mat_d.N+1)*sizeof(MYDTYPE);
#endif
	// 5 LRelStarts LRelEnds FLRelStarts  FLRelEnds KsB
	//offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	MYDTYPE FrameworkMemSize=offset;
//PerStimulus
	printf("offset is%d\n",offset);

	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);  // uHP (Diag)
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE); // bHP (rhs)
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	//offset+=InMat.N*sizeof(MYFTYPE); // Vs

	offset+=((WARPSIZE)*sim.NRecSites)*sizeof(MYFTYPE);//SMemVHot
#ifdef STIMFROMFILE
    offset+=WARPSIZE*sizeof(MYFTYPE);//amps
#endif // STIMFROMFILE
	MYDTYPE PerStimulus=offset-FrameworkMemSize;
	
	MYDTYPE TotalSMem=FrameworkMemSize+(PerStimulus)*stim.NStimuli;
	printf("Asking %d bytes, %d+%d*%d\n",TotalSMem,FrameworkMemSize,PerStimulus,stim.NStimuli);
	clock_t begin,end;
	begin=clock();
		MYDTYPE currKernelRun = NKERNEL;
	MYDTYPE prevRuns = 0;
	int memSizeForVHotGlobal = Nt*stim.NStimuli*sim.NRecSites;
	MYDTYPE memSizeForModelParams = NPARAMS * InMat.NComps;
	MYDTYPE streamID=0;
	cudaStream_t stream0,stream1,stream2,stream3;
	cudaStreamCreate (&stream0);
	cudaStreamCreate (&stream1);
	cudaStreamCreate (&stream2);
	cudaStreamCreate (&stream3);
	begin=clock();
	while (prevRuns<NSets){
	if(currKernelRun>(NSets-prevRuns)){
		currKernelRun = (NSets-prevRuns);
	}
	if(streamID==0){
		NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream0>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR	

	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream0); 
		
	}
	if(streamID==1){
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream1>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR

	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream1); 

	}
	if(streamID==2){
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream2>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR
	
	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt *sim.NRecSites *  stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream2); 

	}
	if(streamID==3){
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream3>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR
	
	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream3); 

	}
	prevRuns +=currKernelRun;
	if(streamID==3){
		streamID == 0;
	}	else {
		streamID +=1;
	}
	}
	cudaDeviceSynchronize();

	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching stEfork2TimeLoopGPUKernel!\n", cudaStatus);
		return cudaStatus;
	}
	//cudaStatus = cudaMemcpy(VHotsHost, VHotsGlobal,NSets * Nt * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost); 

	end=clock();
	double totalT = diffclock(end,begin);
	printf("stEfork2TimeLoopGPU took %g milliseconds\n",totalT);
	FILE *file = fopen(TIMES_FN, "wb");
	if ( file ) {
		MYDTYPE mul32 = MUL32;
		fwrite(&mul32,sizeof(MYDTYPE),1,file);
		fwrite(&totalT,sizeof(double),1,file);
	} else {
		printf("ERR SaveArrayToFile %s\n",TIMES_FN);
	}
	fclose(file);
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMemcpyDeviceToHost failed!");
		return cudaStatus;  
	}
	SaveArrayToFile(VHOT_OUT_FN_P,NSets*Nt*stim.NStimuli*sim.NRecSites,VHotsHost);
	
	return cudaStatus;
}


cudaError_t stEfork2Main(Stim stim, Sim sim, MYFTYPE* ParamsM, HMat& InMat, MYFTYPE* V,MYDTYPE CompDepth,MYDTYPE CompFDepth,MYDTYPE NSets) {
	cudaError_t cudaStatus;
	cudaStatus = cudaSetDevice(0);
	cudaDeviceSetSharedMemConfig(cudaSharedMemBankSizeEightByte);
	  stEfork2TimeLoopGPU(stim, sim, ParamsM, InMat, V,CompDepth,CompFDepth,NSets); //RRR sim
	  
	
	


	return cudaStatus;
}
