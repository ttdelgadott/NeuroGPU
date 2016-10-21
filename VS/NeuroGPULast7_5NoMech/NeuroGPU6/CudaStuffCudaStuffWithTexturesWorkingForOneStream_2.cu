#include "CudaStuff.cuh"
#include "AllModels.cu"
#include "AllModels.cuh"

__constant__ MYFTYPE cCm[416];
__constant__ MYSECONDFTYPE cE[416];
__constant__ MYSECONDFTYPE cF[416];
__constant__ MYDTYPE cFIdxs[416*7];
__constant__ MYDTYPE cKs[416];
__constant__ MYDTYPE cSegToComp[416];
__constant__ MYDTYPE cBoolModel[416 * 7];//One day change this to bool
__constant__ MYDTYPE cRelStarts[99];//nFathers
__constant__ MYDTYPE cRelEnds[99];//nFathers
__constant__ MYDTYPE cFathers[99];//nFathers
__constant__ MYDTYPE cRelVec[186];//nCallForFather
__constant__ MYDTYPE cSegStartI[186+1];//nCallForFather
__constant__ MYDTYPE cSegEndI[186+1];//nCallForFather

__constant__ MYDTYPE cCompByLevel32[26*WARPSIZE];//CompDepth
__constant__ MYDTYPE cCompByFLevel32[23*WARPSIZE];//CompFDepth
__constant__ MYDTYPE cLRelStarts[24];//nLRel
__constant__ MYDTYPE cLRelEnds[24];//nLRel
__constant__ MYDTYPE cFLRelStarts[23];//nFLRel
__constant__ MYDTYPE cFLRelEnds[23];//nFLRel
__constant__ MYDTYPE cSonNoVec[416];//InMat.N 


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
	CurJ = cCompByLevel32[2]-1;
	LRelIndex=cLRelStarts[CurLevel];
	LRelIndex=LRelIndex+cLRelEnds[CurLevel];
	for(CurLevel=0;CurLevel<=Depth;CurLevel++) {
		
		for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=cLRelEnds[CurLevel];LRelIndex++){ 
		//for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
			JumctionI=cCompByLevel32[LRelIndex*WARPSIZE+PIdx]-1;
			for(i=cSegStartI[JumctionI]-1;i<cSegEndI[JumctionI];i++) {
				MYSECONDFTYPE uHPm1=uHP[i-1];
			
				uHP[i]=uHP[i]-cE[i-1]*(cF[i-1]/uHPm1); // So far same as paper parallel
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
					uHP[CurJ]-=cE[t-1]*(cF[t-1]/uHPm1); 
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
	MYDTYPE PIdx_1 =threadIdx.x+(WARPSIZE*(1 -1)); MYDTYPE NextID_1 ;MYDTYPE PIdx_2 =threadIdx.x+(WARPSIZE*(2 -1)); MYDTYPE NextID_2 ;MYDTYPE PIdx_3 =threadIdx.x+(WARPSIZE*(3 -1)); MYDTYPE NextID_3 ;MYDTYPE PIdx_4 =threadIdx.x+(WARPSIZE*(4 -1)); MYDTYPE NextID_4 ;MYDTYPE PIdx_5 =threadIdx.x+(WARPSIZE*(5 -1)); MYDTYPE NextID_5 ;MYDTYPE PIdx_6 =threadIdx.x+(WARPSIZE*(6 -1)); MYDTYPE NextID_6 ;MYDTYPE PIdx_7 =threadIdx.x+(WARPSIZE*(7 -1)); MYDTYPE NextID_7 ;MYDTYPE PIdx_8 =threadIdx.x+(WARPSIZE*(8 -1)); MYDTYPE NextID_8 ;MYDTYPE PIdx_9 =threadIdx.x+(WARPSIZE*(9 -1)); MYDTYPE NextID_9 ;MYDTYPE PIdx_10 =threadIdx.x+(WARPSIZE*(10 -1)); MYDTYPE NextID_10 ;MYDTYPE PIdx_11 =threadIdx.x+(WARPSIZE*(11 -1)); MYDTYPE NextID_11 ;MYDTYPE PIdx_12 =threadIdx.x+(WARPSIZE*(12 -1)); MYDTYPE NextID_12 ;MYDTYPE PIdx_13 =threadIdx.x+(WARPSIZE*(13 -1)); MYDTYPE NextID_13 ;
	MYDTYPE i;
	
	PX=bHP;
	PF=uHP;
	// PX[PIdx_1]=PX[PIdx_1]/PF[PIdx_1]; // PF[PIdx_1]=-InMat.f[PIdx_1]/PF[PIdx_1];
#define THISCOMMANDHERE2(VARILP) PX[PIdx_ ## VARILP ]=PX[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ]; PF[PIdx_ ## VARILP ]=-cF[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ];
	PX[PIdx_1 ]=PX[PIdx_1 ]/PF[PIdx_1 ]; PF[PIdx_1 ]=-cF[PIdx_1 ]/PF[PIdx_1 ];PX[PIdx_2 ]=PX[PIdx_2 ]/PF[PIdx_2 ]; PF[PIdx_2 ]=-cF[PIdx_2 ]/PF[PIdx_2 ];PX[PIdx_3 ]=PX[PIdx_3 ]/PF[PIdx_3 ]; PF[PIdx_3 ]=-cF[PIdx_3 ]/PF[PIdx_3 ];PX[PIdx_4 ]=PX[PIdx_4 ]/PF[PIdx_4 ]; PF[PIdx_4 ]=-cF[PIdx_4 ]/PF[PIdx_4 ];PX[PIdx_5 ]=PX[PIdx_5 ]/PF[PIdx_5 ]; PF[PIdx_5 ]=-cF[PIdx_5 ]/PF[PIdx_5 ];PX[PIdx_6 ]=PX[PIdx_6 ]/PF[PIdx_6 ]; PF[PIdx_6 ]=-cF[PIdx_6 ]/PF[PIdx_6 ];PX[PIdx_7 ]=PX[PIdx_7 ]/PF[PIdx_7 ]; PF[PIdx_7 ]=-cF[PIdx_7 ]/PF[PIdx_7 ];PX[PIdx_8 ]=PX[PIdx_8 ]/PF[PIdx_8 ]; PF[PIdx_8 ]=-cF[PIdx_8 ]/PF[PIdx_8 ];PX[PIdx_9 ]=PX[PIdx_9 ]/PF[PIdx_9 ]; PF[PIdx_9 ]=-cF[PIdx_9 ]/PF[PIdx_9 ];PX[PIdx_10 ]=PX[PIdx_10 ]/PF[PIdx_10 ]; PF[PIdx_10 ]=-cF[PIdx_10 ]/PF[PIdx_10 ];PX[PIdx_11 ]=PX[PIdx_11 ]/PF[PIdx_11 ]; PF[PIdx_11 ]=-cF[PIdx_11 ]/PF[PIdx_11 ];PX[PIdx_12 ]=PX[PIdx_12 ]/PF[PIdx_12 ]; PF[PIdx_12 ]=-cF[PIdx_12 ]/PF[PIdx_12 ];PX[PIdx_13 ]=PX[PIdx_13 ]/PF[PIdx_13 ]; PF[PIdx_13 ]=-cF[PIdx_13 ]/PF[PIdx_13 ];

	PX[InMat.N]=0;
	PF[InMat.N]=1;
	for(i=0;i<LognDepth;i++) {	
		// NextID_1=cFIdxs[i*InMat.N+PIdx_1]-1; // MYFTYPE OldPXj_1=PX[PIdx_1]; // MYFTYPE OldPXNextID_1=PX[NextID_1]; // PX[PIdx_1]=OldPXj_1+OldPXNextID_1*PF[PIdx_1];
#define THISCOMMANDHERE3(VARILP) NextID_ ## VARILP =cFIdxs[i*InMat.N+PIdx_ ## VARILP ]-1; MYFTYPE OldPXj_ ## VARILP =PX[PIdx_ ## VARILP ]; MYFTYPE OldPXNextID_ ## VARILP =PX[NextID_ ## VARILP ]; PX[PIdx_ ## VARILP ]=OldPXj_ ## VARILP +OldPXNextID_ ## VARILP *PF[PIdx_ ## VARILP ];
	NextID_1 =cFIdxs[i*InMat.N+PIdx_1 ]-1; MYFTYPE OldPXj_1 =PX[PIdx_1 ]; MYFTYPE OldPXNextID_1 =PX[NextID_1 ]; PX[PIdx_1 ]=OldPXj_1 +OldPXNextID_1 *PF[PIdx_1 ];NextID_2 =cFIdxs[i*InMat.N+PIdx_2 ]-1; MYFTYPE OldPXj_2 =PX[PIdx_2 ]; MYFTYPE OldPXNextID_2 =PX[NextID_2 ]; PX[PIdx_2 ]=OldPXj_2 +OldPXNextID_2 *PF[PIdx_2 ];NextID_3 =cFIdxs[i*InMat.N+PIdx_3 ]-1; MYFTYPE OldPXj_3 =PX[PIdx_3 ]; MYFTYPE OldPXNextID_3 =PX[NextID_3 ]; PX[PIdx_3 ]=OldPXj_3 +OldPXNextID_3 *PF[PIdx_3 ];NextID_4 =cFIdxs[i*InMat.N+PIdx_4 ]-1; MYFTYPE OldPXj_4 =PX[PIdx_4 ]; MYFTYPE OldPXNextID_4 =PX[NextID_4 ]; PX[PIdx_4 ]=OldPXj_4 +OldPXNextID_4 *PF[PIdx_4 ];NextID_5 =cFIdxs[i*InMat.N+PIdx_5 ]-1; MYFTYPE OldPXj_5 =PX[PIdx_5 ]; MYFTYPE OldPXNextID_5 =PX[NextID_5 ]; PX[PIdx_5 ]=OldPXj_5 +OldPXNextID_5 *PF[PIdx_5 ];NextID_6 =cFIdxs[i*InMat.N+PIdx_6 ]-1; MYFTYPE OldPXj_6 =PX[PIdx_6 ]; MYFTYPE OldPXNextID_6 =PX[NextID_6 ]; PX[PIdx_6 ]=OldPXj_6 +OldPXNextID_6 *PF[PIdx_6 ];NextID_7 =cFIdxs[i*InMat.N+PIdx_7 ]-1; MYFTYPE OldPXj_7 =PX[PIdx_7 ]; MYFTYPE OldPXNextID_7 =PX[NextID_7 ]; PX[PIdx_7 ]=OldPXj_7 +OldPXNextID_7 *PF[PIdx_7 ];NextID_8 =cFIdxs[i*InMat.N+PIdx_8 ]-1; MYFTYPE OldPXj_8 =PX[PIdx_8 ]; MYFTYPE OldPXNextID_8 =PX[NextID_8 ]; PX[PIdx_8 ]=OldPXj_8 +OldPXNextID_8 *PF[PIdx_8 ];NextID_9 =cFIdxs[i*InMat.N+PIdx_9 ]-1; MYFTYPE OldPXj_9 =PX[PIdx_9 ]; MYFTYPE OldPXNextID_9 =PX[NextID_9 ]; PX[PIdx_9 ]=OldPXj_9 +OldPXNextID_9 *PF[PIdx_9 ];NextID_10 =cFIdxs[i*InMat.N+PIdx_10 ]-1; MYFTYPE OldPXj_10 =PX[PIdx_10 ]; MYFTYPE OldPXNextID_10 =PX[NextID_10 ]; PX[PIdx_10 ]=OldPXj_10 +OldPXNextID_10 *PF[PIdx_10 ];NextID_11 =cFIdxs[i*InMat.N+PIdx_11 ]-1; MYFTYPE OldPXj_11 =PX[PIdx_11 ]; MYFTYPE OldPXNextID_11 =PX[NextID_11 ]; PX[PIdx_11 ]=OldPXj_11 +OldPXNextID_11 *PF[PIdx_11 ];NextID_12 =cFIdxs[i*InMat.N+PIdx_12 ]-1; MYFTYPE OldPXj_12 =PX[PIdx_12 ]; MYFTYPE OldPXNextID_12 =PX[NextID_12 ]; PX[PIdx_12 ]=OldPXj_12 +OldPXNextID_12 *PF[PIdx_12 ];NextID_13 =cFIdxs[i*InMat.N+PIdx_13 ]-1; MYFTYPE OldPXj_13 =PX[PIdx_13 ]; MYFTYPE OldPXNextID_13 =PX[NextID_13 ]; PX[PIdx_13 ]=OldPXj_13 +OldPXNextID_13 *PF[PIdx_13 ];

		// PX[j]=PX[j]+PX[NextID]*PF[j];
		// PF[j]=PF[j]*PF[NextID];
		
		// MYFTYPE OldPFj_1=PF[PIdx_1]; // MYFTYPE OldPFNextID_1=PF[NextID_1]; // PF[PIdx_1]=OldPFj_1*OldPFNextID_1;
#define THISCOMMANDHERE4(VARILP) MYFTYPE OldPFj_ ## VARILP =PF[PIdx_ ## VARILP ]; MYFTYPE OldPFNextID_ ## VARILP =PF[NextID_ ## VARILP ]; PF[PIdx_ ## VARILP ]=OldPFj_ ## VARILP *OldPFNextID_ ## VARILP ;
	MYFTYPE OldPFj_1 =PF[PIdx_1 ]; MYFTYPE OldPFNextID_1 =PF[NextID_1 ]; PF[PIdx_1 ]=OldPFj_1 *OldPFNextID_1 ;MYFTYPE OldPFj_2 =PF[PIdx_2 ]; MYFTYPE OldPFNextID_2 =PF[NextID_2 ]; PF[PIdx_2 ]=OldPFj_2 *OldPFNextID_2 ;MYFTYPE OldPFj_3 =PF[PIdx_3 ]; MYFTYPE OldPFNextID_3 =PF[NextID_3 ]; PF[PIdx_3 ]=OldPFj_3 *OldPFNextID_3 ;MYFTYPE OldPFj_4 =PF[PIdx_4 ]; MYFTYPE OldPFNextID_4 =PF[NextID_4 ]; PF[PIdx_4 ]=OldPFj_4 *OldPFNextID_4 ;MYFTYPE OldPFj_5 =PF[PIdx_5 ]; MYFTYPE OldPFNextID_5 =PF[NextID_5 ]; PF[PIdx_5 ]=OldPFj_5 *OldPFNextID_5 ;MYFTYPE OldPFj_6 =PF[PIdx_6 ]; MYFTYPE OldPFNextID_6 =PF[NextID_6 ]; PF[PIdx_6 ]=OldPFj_6 *OldPFNextID_6 ;MYFTYPE OldPFj_7 =PF[PIdx_7 ]; MYFTYPE OldPFNextID_7 =PF[NextID_7 ]; PF[PIdx_7 ]=OldPFj_7 *OldPFNextID_7 ;MYFTYPE OldPFj_8 =PF[PIdx_8 ]; MYFTYPE OldPFNextID_8 =PF[NextID_8 ]; PF[PIdx_8 ]=OldPFj_8 *OldPFNextID_8 ;MYFTYPE OldPFj_9 =PF[PIdx_9 ]; MYFTYPE OldPFNextID_9 =PF[NextID_9 ]; PF[PIdx_9 ]=OldPFj_9 *OldPFNextID_9 ;MYFTYPE OldPFj_10 =PF[PIdx_10 ]; MYFTYPE OldPFNextID_10 =PF[NextID_10 ]; PF[PIdx_10 ]=OldPFj_10 *OldPFNextID_10 ;MYFTYPE OldPFj_11 =PF[PIdx_11 ]; MYFTYPE OldPFNextID_11 =PF[NextID_11 ]; PF[PIdx_11 ]=OldPFj_11 *OldPFNextID_11 ;MYFTYPE OldPFj_12 =PF[PIdx_12 ]; MYFTYPE OldPFNextID_12 =PF[NextID_12 ]; PF[PIdx_12 ]=OldPFj_12 *OldPFNextID_12 ;MYFTYPE OldPFj_13 =PF[PIdx_13 ]; MYFTYPE OldPFNextID_13 =PF[NextID_13 ]; PF[PIdx_13 ]=OldPFj_13 *OldPFNextID_13 ;
	}
}
#endif

#ifdef BKSUB2
__device__ void BkSub(HMat InMat, MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP,MYSECONDFTYPE* Out, MYDTYPE Depth)
{
	// MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2); Out[PIdx_2]=0; // might be useless?
#define THISCOMMANDHEREB1(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1)); Out[PIdx_ ## VARILP ]=0;
	MYDTYPE PIdx_1 =threadIdx.x+(WARPSIZE*(1 -1)); Out[PIdx_1 ]=0;MYDTYPE PIdx_2 =threadIdx.x+(WARPSIZE*(2 -1)); Out[PIdx_2 ]=0;MYDTYPE PIdx_3 =threadIdx.x+(WARPSIZE*(3 -1)); Out[PIdx_3 ]=0;MYDTYPE PIdx_4 =threadIdx.x+(WARPSIZE*(4 -1)); Out[PIdx_4 ]=0;MYDTYPE PIdx_5 =threadIdx.x+(WARPSIZE*(5 -1)); Out[PIdx_5 ]=0;MYDTYPE PIdx_6 =threadIdx.x+(WARPSIZE*(6 -1)); Out[PIdx_6 ]=0;MYDTYPE PIdx_7 =threadIdx.x+(WARPSIZE*(7 -1)); Out[PIdx_7 ]=0;MYDTYPE PIdx_8 =threadIdx.x+(WARPSIZE*(8 -1)); Out[PIdx_8 ]=0;MYDTYPE PIdx_9 =threadIdx.x+(WARPSIZE*(9 -1)); Out[PIdx_9 ]=0;MYDTYPE PIdx_10 =threadIdx.x+(WARPSIZE*(10 -1)); Out[PIdx_10 ]=0;MYDTYPE PIdx_11 =threadIdx.x+(WARPSIZE*(11 -1)); Out[PIdx_11 ]=0;MYDTYPE PIdx_12 =threadIdx.x+(WARPSIZE*(12 -1)); Out[PIdx_12 ]=0;MYDTYPE PIdx_13 =threadIdx.x+(WARPSIZE*(13 -1)); Out[PIdx_13 ]=0;

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
  for(LRelIndex=InMat.LRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
   JumctionI=InMat.CompByLevel32[LRelIndex*WARPSIZE+PIdx_1]-1;
   // for i=(SegEndI(JumctionI)):-1:(SegStartI(JumctionI)-1)
   for(i=InMat.SegEndI[JumctionI]-1;i>=(InMat.SegStartI[JumctionI]-2);i--) {
    // k=KsB(i+1);
     k=InMat.KsB[i+1];
	 
    // bPX(i)=(bH(i)-bPX(k)*f(i))/uH(i);
   Out[i]=(bHP[i]-Out[k]*cF[i])/uHP[i];
   }
  }
 }
 } 

#endif

__device__ MYDTYPE InitializeDeviceMemory(Stim stim,Sim sim, HMat InMat,MYFTYPE* VHotGlobal,MYDTYPE CompDepth,MYDTYPE CompFDepth,HMat *SMemMat, MYFTYPE* Vs,MYFTYPE* amps,MYFTYPE* SMemVHot)
{
	//Configure IDs 

	MYDTYPE StimID=threadIdx.y;
	
#define THISCOMMANDHERE1(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1));
	MYDTYPE PIdx_1 =threadIdx.x+(WARPSIZE*(1 -1)); MYDTYPE NextID_1 ;MYDTYPE PIdx_2 =threadIdx.x+(WARPSIZE*(2 -1)); MYDTYPE NextID_2 ;MYDTYPE PIdx_3 =threadIdx.x+(WARPSIZE*(3 -1)); MYDTYPE NextID_3 ;MYDTYPE PIdx_4 =threadIdx.x+(WARPSIZE*(4 -1)); MYDTYPE NextID_4 ;MYDTYPE PIdx_5 =threadIdx.x+(WARPSIZE*(5 -1)); MYDTYPE NextID_5 ;MYDTYPE PIdx_6 =threadIdx.x+(WARPSIZE*(6 -1)); MYDTYPE NextID_6 ;MYDTYPE PIdx_7 =threadIdx.x+(WARPSIZE*(7 -1)); MYDTYPE NextID_7 ;MYDTYPE PIdx_8 =threadIdx.x+(WARPSIZE*(8 -1)); MYDTYPE NextID_8 ;MYDTYPE PIdx_9 =threadIdx.x+(WARPSIZE*(9 -1)); MYDTYPE NextID_9 ;MYDTYPE PIdx_10 =threadIdx.x+(WARPSIZE*(10 -1)); MYDTYPE NextID_10 ;MYDTYPE PIdx_11 =threadIdx.x+(WARPSIZE*(11 -1)); MYDTYPE NextID_11 ;MYDTYPE PIdx_12 =threadIdx.x+(WARPSIZE*(12 -1)); MYDTYPE NextID_12 ;MYDTYPE PIdx_13 =threadIdx.x+(WARPSIZE*(13 -1)); MYDTYPE NextID_13 ;
	cudaError cudaStatus;
	
	//Declaring the shared memory elements
	SMemMat->N=InMat.N;
	SMemMat->NComps=InMat.NComps;
	SMemMat->Depth=InMat.Depth;
	SMemMat->NModels=InMat.NModels;
	SMemMat->LognDepth=InMat.LognDepth;
	SMemMat->nFathers=InMat.nFathers;
	SMemMat->nCallForFather=InMat.nCallForFather;
	SMemMat->nLRel=InMat.nLRel;
	SMemMat->nFLRel=InMat.nFLRel;
	//Offset indicates how far we are into the shared memory
	MYDTYPE offset=0;
	//e indicate the supradiagonal
	//SMemMat->e = (MYSECONDFTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYSECONDFTYPE);
	//f indicates the subdiagonal.
	//SMemMat->f = (MYSECONDFTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYSECONDFTYPE);

	//Copy e,f from the device memory to the shared memory. - Move this to constant RBSConstant
	// SMemMat->e[PIdx_3]=InMat.e[PIdx_3]; // SMemMat->f[PIdx_3]=cF[PIdx_3];
//#define THISCOMMANDHERE6(VARILP) SMemMat->e[PIdx_ ## VARILP ]=InMat.e[PIdx_ ## VARILP ]; SMemMat->f[PIdx_ ## VARILP ]=cF[PIdx_ ## VARILP ];
	//SMemMat->e[PIdx_1 ]=InMat.e[PIdx_1 ]; SMemMat->f[PIdx_1 ]=cF[PIdx_1 ];SMemMat->e[PIdx_2 ]=InMat.e[PIdx_2 ]; SMemMat->f[PIdx_2 ]=cF[PIdx_2 ];SMemMat->e[PIdx_3 ]=InMat.e[PIdx_3 ]; SMemMat->f[PIdx_3 ]=cF[PIdx_3 ];SMemMat->e[PIdx_4 ]=InMat.e[PIdx_4 ]; SMemMat->f[PIdx_4 ]=cF[PIdx_4 ];SMemMat->e[PIdx_5 ]=InMat.e[PIdx_5 ]; SMemMat->f[PIdx_5 ]=cF[PIdx_5 ];SMemMat->e[PIdx_6 ]=InMat.e[PIdx_6 ]; SMemMat->f[PIdx_6 ]=cF[PIdx_6 ];SMemMat->e[PIdx_7 ]=InMat.e[PIdx_7 ]; SMemMat->f[PIdx_7 ]=cF[PIdx_7 ];SMemMat->e[PIdx_8 ]=InMat.e[PIdx_8 ]; SMemMat->f[PIdx_8 ]=cF[PIdx_8 ];SMemMat->e[PIdx_9 ]=InMat.e[PIdx_9 ]; SMemMat->f[PIdx_9 ]=cF[PIdx_9 ];SMemMat->e[PIdx_10 ]=InMat.e[PIdx_10 ]; SMemMat->f[PIdx_10 ]=cF[PIdx_10 ];SMemMat->e[PIdx_11 ]=InMat.e[PIdx_11 ]; SMemMat->f[PIdx_11 ]=cF[PIdx_11 ];SMemMat->e[PIdx_12 ]=InMat.e[PIdx_12 ]; SMemMat->f[PIdx_12 ]=cF[PIdx_12 ];SMemMat->e[PIdx_13 ]=InMat.e[PIdx_13 ]; SMemMat->f[PIdx_13 ]=cF[PIdx_13 ];
	//InMat.e=SMemMat->e;
	//cF=SMemMat->f;
	//Copy e,f from the device memory to the shared memory. - Move this to constant RBSConstant
	//SMemMat->Cms = (MYFTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYFTYPE);
	
//#define THISCOMMANDHERE7(VARILP) SMemMat->Cms[PIdx_ ## VARILP ]=InMat.Cms[PIdx_ ## VARILP ];
	//SMemMat->Cms[PIdx_1 ]=InMat.Cms[PIdx_1 ];SMemMat->Cms[PIdx_2 ]=InMat.Cms[PIdx_2 ];SMemMat->Cms[PIdx_3 ]=InMat.Cms[PIdx_3 ];SMemMat->Cms[PIdx_4 ]=InMat.Cms[PIdx_4 ];SMemMat->Cms[PIdx_5 ]=InMat.Cms[PIdx_5 ];SMemMat->Cms[PIdx_6 ]=InMat.Cms[PIdx_6 ];SMemMat->Cms[PIdx_7 ]=InMat.Cms[PIdx_7 ];SMemMat->Cms[PIdx_8 ]=InMat.Cms[PIdx_8 ];SMemMat->Cms[PIdx_9 ]=InMat.Cms[PIdx_9 ];SMemMat->Cms[PIdx_10 ]=InMat.Cms[PIdx_10 ];SMemMat->Cms[PIdx_11 ]=InMat.Cms[PIdx_11 ];SMemMat->Cms[PIdx_12 ]=InMat.Cms[PIdx_12 ];SMemMat->Cms[PIdx_13 ]=InMat.Cms[PIdx_13 ];
	// discrete
	//BKSUB is the different parallelism we use
#ifdef BKSUB1
	//Copying FIdxs (Father indexes) from device to shared mem
		//SMemMat->FIdxs = (MYDTYPE*) &smem[offset];
		//offset+=InMat.N*SMemMat->LognDepth*sizeof(MYDTYPE);
		//for(int i=0;i<SMemMat->LognDepth;i++) {
			// SMemMat->FIdxs[i*InMat.N+PIdx_3]=cFIdxs[i*InMat.N+PIdx_3];
//#define THISCOMMANDHERE8(VARILP) SMemMat->FIdxs[i*InMat.N+PIdx_ ## VARILP ]=cFIdxs[i*InMat.N+PIdx_ ## VARILP ];
	//SMemMat->FIdxs[i*InMat.N+PIdx_1 ]=cFIdxs[i*InMat.N+PIdx_1 ];SMemMat->FIdxs[i*InMat.N+PIdx_2 ]=cFIdxs[i*InMat.N+PIdx_2 ];SMemMat->FIdxs[i*InMat.N+PIdx_3 ]=cFIdxs[i*InMat.N+PIdx_3 ];SMemMat->FIdxs[i*InMat.N+PIdx_4 ]=cFIdxs[i*InMat.N+PIdx_4 ];SMemMat->FIdxs[i*InMat.N+PIdx_5 ]=cFIdxs[i*InMat.N+PIdx_5 ];SMemMat->FIdxs[i*InMat.N+PIdx_6 ]=cFIdxs[i*InMat.N+PIdx_6 ];SMemMat->FIdxs[i*InMat.N+PIdx_7 ]=cFIdxs[i*InMat.N+PIdx_7 ];SMemMat->FIdxs[i*InMat.N+PIdx_8 ]=cFIdxs[i*InMat.N+PIdx_8 ];SMemMat->FIdxs[i*InMat.N+PIdx_9 ]=cFIdxs[i*InMat.N+PIdx_9 ];SMemMat->FIdxs[i*InMat.N+PIdx_10 ]=cFIdxs[i*InMat.N+PIdx_10 ];SMemMat->FIdxs[i*InMat.N+PIdx_11 ]=cFIdxs[i*InMat.N+PIdx_11 ];SMemMat->FIdxs[i*InMat.N+PIdx_12 ]=cFIdxs[i*InMat.N+PIdx_12 ];SMemMat->FIdxs[i*InMat.N+PIdx_13 ]=cFIdxs[i*InMat.N+PIdx_13 ];
//}
#endif 
#ifdef BKSUB2
		SMemMat->KsB =  (MYDTYPE*) &smem[offset];
		offset+=(SMemMat->N+1)*sizeof(MYDTYPE);		
		SMemMat->KsB[InMat.N]=InMat.KsB[InMat.N];

		// SMemMat->KsB[PIdx_3]=InMat.KsB[PIdx_3];
#define THISCOMMANDHERE9(VARILP) SMemMat->KsB[PIdx_ ## VARILP ]=InMat.KsB[PIdx_ ## VARILP ];
	SMemMat->KsB[PIdx_1 ]=InMat.KsB[PIdx_1 ];SMemMat->KsB[PIdx_2 ]=InMat.KsB[PIdx_2 ];SMemMat->KsB[PIdx_3 ]=InMat.KsB[PIdx_3 ];SMemMat->KsB[PIdx_4 ]=InMat.KsB[PIdx_4 ];SMemMat->KsB[PIdx_5 ]=InMat.KsB[PIdx_5 ];SMemMat->KsB[PIdx_6 ]=InMat.KsB[PIdx_6 ];SMemMat->KsB[PIdx_7 ]=InMat.KsB[PIdx_7 ];SMemMat->KsB[PIdx_8 ]=InMat.KsB[PIdx_8 ];SMemMat->KsB[PIdx_9 ]=InMat.KsB[PIdx_9 ];SMemMat->KsB[PIdx_10 ]=InMat.KsB[PIdx_10 ];SMemMat->KsB[PIdx_11 ]=InMat.KsB[PIdx_11 ];SMemMat->KsB[PIdx_12 ]=InMat.KsB[PIdx_12 ];SMemMat->KsB[PIdx_13 ]=InMat.KsB[PIdx_13 ];
#endif	
	//Copying Ks (ParentSegment) from device to shared
	//SMemMat->Ks = (MYDTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYDTYPE);
	// SMemMat->Ks[PIdx_3]=InMat.Ks[PIdx_3];
//#define THISCOMMANDHERE10(VARILP) SMemMat->Ks[PIdx_ ## VARILP ]=InMat.Ks[PIdx_ ## VARILP ];
//	SMemMat->Ks[PIdx_1 ]=InMat.Ks[PIdx_1 ];SMemMat->Ks[PIdx_2 ]=InMat.Ks[PIdx_2 ];SMemMat->Ks[PIdx_3 ]=InMat.Ks[PIdx_3 ];SMemMat->Ks[PIdx_4 ]=InMat.Ks[PIdx_4 ];SMemMat->Ks[PIdx_5 ]=InMat.Ks[PIdx_5 ];SMemMat->Ks[PIdx_6 ]=InMat.Ks[PIdx_6 ];SMemMat->Ks[PIdx_7 ]=InMat.Ks[PIdx_7 ];SMemMat->Ks[PIdx_8 ]=InMat.Ks[PIdx_8 ];SMemMat->Ks[PIdx_9 ]=InMat.Ks[PIdx_9 ];SMemMat->Ks[PIdx_10 ]=InMat.Ks[PIdx_10 ];SMemMat->Ks[PIdx_11 ]=InMat.Ks[PIdx_11 ];SMemMat->Ks[PIdx_12 ]=InMat.Ks[PIdx_12 ];SMemMat->Ks[PIdx_13 ]=InMat.Ks[PIdx_13 ];
	
	//Copying SegToComp from device to shared
	//SMemMat->SegToComp = (MYDTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYDTYPE);
//#define THISCOMMANDHERE11(VARILP) SMemMat->SegToComp[PIdx_ ## VARILP ]=InMat.SegToComp[PIdx_ ## VARILP ];
	//SMemMat->SegToComp[PIdx_1 ]=InMat.SegToComp[PIdx_1 ];SMemMat->SegToComp[PIdx_2 ]=InMat.SegToComp[PIdx_2 ];SMemMat->SegToComp[PIdx_3 ]=InMat.SegToComp[PIdx_3 ];SMemMat->SegToComp[PIdx_4 ]=InMat.SegToComp[PIdx_4 ];SMemMat->SegToComp[PIdx_5 ]=InMat.SegToComp[PIdx_5 ];SMemMat->SegToComp[PIdx_6 ]=InMat.SegToComp[PIdx_6 ];SMemMat->SegToComp[PIdx_7 ]=InMat.SegToComp[PIdx_7 ];SMemMat->SegToComp[PIdx_8 ]=InMat.SegToComp[PIdx_8 ];SMemMat->SegToComp[PIdx_9 ]=InMat.SegToComp[PIdx_9 ];SMemMat->SegToComp[PIdx_10 ]=InMat.SegToComp[PIdx_10 ];SMemMat->SegToComp[PIdx_11 ]=InMat.SegToComp[PIdx_11 ];SMemMat->SegToComp[PIdx_12 ]=InMat.SegToComp[PIdx_12 ];SMemMat->SegToComp[PIdx_13 ]=InMat.SegToComp[PIdx_13 ];
	//SMemMat->boolModel= (MYDTYPE*) &smem[offset];
	//offset+=InMat.N*SMemMat->NModels*sizeof(MYDTYPE);
	// SMemMat->boolModel[PIdx_3]=InMat.boolModel[PIdx_3];
//#define THISCOMMANDHERE12(VARILP) for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_ ## VARILP+ii*SMemMat->N]=InMat.boolModel[PIdx_ ## VARILP+ii*SMemMat->N];}
	//for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_1+ii*SMemMat->N]=InMat.boolModel[PIdx_1+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_2+ii*SMemMat->N]=InMat.boolModel[PIdx_2+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_3+ii*SMemMat->N]=InMat.boolModel[PIdx_3+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_4+ii*SMemMat->N]=InMat.boolModel[PIdx_4+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_5+ii*SMemMat->N]=InMat.boolModel[PIdx_5+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_6+ii*SMemMat->N]=InMat.boolModel[PIdx_6+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_7+ii*SMemMat->N]=InMat.boolModel[PIdx_7+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_8+ii*SMemMat->N]=InMat.boolModel[PIdx_8+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_9+ii*SMemMat->N]=InMat.boolModel[PIdx_9+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_10+ii*SMemMat->N]=InMat.boolModel[PIdx_10+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_11+ii*SMemMat->N]=InMat.boolModel[PIdx_11+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_12+ii*SMemMat->N]=InMat.boolModel[PIdx_12+ii*SMemMat->N];}for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_13+ii*SMemMat->N]=InMat.boolModel[PIdx_13+ii*SMemMat->N];}
	
	//SMemMat->RelStarts = (MYDTYPE*) &smem[offset];
	//offset+=InMat.nFathers*sizeof(MYDTYPE);
	//SMemMat->RelEnds = (MYDTYPE*) &smem[offset];
	//offset+=InMat.nFathers*sizeof(MYDTYPE);
	//SMemMat->RelVec = (MYDTYPE*) &smem[offset];
	//offset+=InMat.nCallForFather*sizeof(MYDTYPE);
	//SMemMat->SegStartI = (MYDTYPE*) &smem[offset];
	//offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);
	//SMemMat->SegEndI = (MYDTYPE*) &smem[offset];
	//offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);

	//SMemMat->Fathers= (MYDTYPE*) &smem[offset];
	//offset+=InMat.nFathers*sizeof(MYDTYPE);
	// 3
	//SMemMat->CompByLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	//offset+=WARPSIZE*(CompDepth)*sizeof(MYDTYPE);
	//SMemMat->CompByFLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	//offset+=WARPSIZE*(CompFDepth)*sizeof(MYDTYPE);
	//SMemMat->LRelStarts = (MYDTYPE*) &smem[offset];
	//offset+=SMemMat->nLRel*sizeof(MYDTYPE);
	//SMemMat->LRelEnds = (MYDTYPE*) &smem[offset];
	//offset+=SMemMat->nLRel*sizeof(MYDTYPE);
	//SMemMat->FLRelStarts = (MYDTYPE*) &smem[offset];
	//offset+=SMemMat->nFLRel*sizeof(MYDTYPE);
	//SMemMat->FLRelEnds = (MYDTYPE*) &smem[offset];
	//offset+=SMemMat->nFLRel*sizeof(MYDTYPE);
	// Moving back to MYFTYPEs - make sure that the address is good for MYFTYPE (is modulu 4).
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	MYDTYPE ConstantMemSize=offset;
	//if(PIdx_1<InMat.nFathers) { SMemMat->RelStarts[PIdx_1]=InMat.RelStarts[PIdx_1];SMemMat->RelEnds[PIdx_1]=InMat.RelEnds[PIdx_1];SMemMat->Fathers[PIdx_1]=InMat.Fathers[PIdx_1];}
	//#define THISCOMMANDHERE13(VARILP) if(PIdx_ ## VARILP<InMat.nFathers){ SMemMat->RelStarts[PIdx_ ## VARILP]=InMat.RelStarts[PIdx_ ## VARILP];SMemMat->RelEnds[PIdx_ ## VARILP]=InMat.RelEnds[PIdx_ ## VARILP];SMemMat->Fathers[PIdx_ ## VARILP]=InMat.Fathers[PIdx_ ## VARILP];}
	//if(PIdx_1<InMat.nFathers){ SMemMat->RelStarts[PIdx_1]=InMat.RelStarts[PIdx_1];SMemMat->RelEnds[PIdx_1]=InMat.RelEnds[PIdx_1];SMemMat->Fathers[PIdx_1]=InMat.Fathers[PIdx_1];}if(PIdx_2<InMat.nFathers){ SMemMat->RelStarts[PIdx_2]=InMat.RelStarts[PIdx_2];SMemMat->RelEnds[PIdx_2]=InMat.RelEnds[PIdx_2];SMemMat->Fathers[PIdx_2]=InMat.Fathers[PIdx_2];}if(PIdx_3<InMat.nFathers){ SMemMat->RelStarts[PIdx_3]=InMat.RelStarts[PIdx_3];SMemMat->RelEnds[PIdx_3]=InMat.RelEnds[PIdx_3];SMemMat->Fathers[PIdx_3]=InMat.Fathers[PIdx_3];}if(PIdx_4<InMat.nFathers){ SMemMat->RelStarts[PIdx_4]=InMat.RelStarts[PIdx_4];SMemMat->RelEnds[PIdx_4]=InMat.RelEnds[PIdx_4];SMemMat->Fathers[PIdx_4]=InMat.Fathers[PIdx_4];}if(PIdx_5<InMat.nFathers){ SMemMat->RelStarts[PIdx_5]=InMat.RelStarts[PIdx_5];SMemMat->RelEnds[PIdx_5]=InMat.RelEnds[PIdx_5];SMemMat->Fathers[PIdx_5]=InMat.Fathers[PIdx_5];}if(PIdx_6<InMat.nFathers){ SMemMat->RelStarts[PIdx_6]=InMat.RelStarts[PIdx_6];SMemMat->RelEnds[PIdx_6]=InMat.RelEnds[PIdx_6];SMemMat->Fathers[PIdx_6]=InMat.Fathers[PIdx_6];}if(PIdx_7<InMat.nFathers){ SMemMat->RelStarts[PIdx_7]=InMat.RelStarts[PIdx_7];SMemMat->RelEnds[PIdx_7]=InMat.RelEnds[PIdx_7];SMemMat->Fathers[PIdx_7]=InMat.Fathers[PIdx_7];}if(PIdx_8<InMat.nFathers){ SMemMat->RelStarts[PIdx_8]=InMat.RelStarts[PIdx_8];SMemMat->RelEnds[PIdx_8]=InMat.RelEnds[PIdx_8];SMemMat->Fathers[PIdx_8]=InMat.Fathers[PIdx_8];}if(PIdx_9<InMat.nFathers){ SMemMat->RelStarts[PIdx_9]=InMat.RelStarts[PIdx_9];SMemMat->RelEnds[PIdx_9]=InMat.RelEnds[PIdx_9];SMemMat->Fathers[PIdx_9]=InMat.Fathers[PIdx_9];}if(PIdx_10<InMat.nFathers){ SMemMat->RelStarts[PIdx_10]=InMat.RelStarts[PIdx_10];SMemMat->RelEnds[PIdx_10]=InMat.RelEnds[PIdx_10];SMemMat->Fathers[PIdx_10]=InMat.Fathers[PIdx_10];}if(PIdx_11<InMat.nFathers){ SMemMat->RelStarts[PIdx_11]=InMat.RelStarts[PIdx_11];SMemMat->RelEnds[PIdx_11]=InMat.RelEnds[PIdx_11];SMemMat->Fathers[PIdx_11]=InMat.Fathers[PIdx_11];}if(PIdx_12<InMat.nFathers){ SMemMat->RelStarts[PIdx_12]=InMat.RelStarts[PIdx_12];SMemMat->RelEnds[PIdx_12]=InMat.RelEnds[PIdx_12];SMemMat->Fathers[PIdx_12]=InMat.Fathers[PIdx_12];}if(PIdx_13<InMat.nFathers){ SMemMat->RelStarts[PIdx_13]=InMat.RelStarts[PIdx_13];SMemMat->RelEnds[PIdx_13]=InMat.RelEnds[PIdx_13];SMemMat->Fathers[PIdx_13]=InMat.Fathers[PIdx_13];}
	//if(PIdx_1<InMat.nCallForFather) {SMemMat->RelVec[PIdx_1]=InMat.RelVec[PIdx_1];}
	//#define THISCOMMANDHERE14(VARILP) if(PIdx_ ## VARILP<InMat.nCallForFather){SMemMat->RelVec[PIdx_ ## VARILP]=InMat.RelVec[PIdx_ ## VARILP];}
	//if(PIdx_1<InMat.nCallForFather){SMemMat->RelVec[PIdx_1]=InMat.RelVec[PIdx_1];}if(PIdx_2<InMat.nCallForFather){SMemMat->RelVec[PIdx_2]=InMat.RelVec[PIdx_2];}if(PIdx_3<InMat.nCallForFather){SMemMat->RelVec[PIdx_3]=InMat.RelVec[PIdx_3];}if(PIdx_4<InMat.nCallForFather){SMemMat->RelVec[PIdx_4]=InMat.RelVec[PIdx_4];}if(PIdx_5<InMat.nCallForFather){SMemMat->RelVec[PIdx_5]=InMat.RelVec[PIdx_5];}if(PIdx_6<InMat.nCallForFather){SMemMat->RelVec[PIdx_6]=InMat.RelVec[PIdx_6];}if(PIdx_7<InMat.nCallForFather){SMemMat->RelVec[PIdx_7]=InMat.RelVec[PIdx_7];}if(PIdx_8<InMat.nCallForFather){SMemMat->RelVec[PIdx_8]=InMat.RelVec[PIdx_8];}if(PIdx_9<InMat.nCallForFather){SMemMat->RelVec[PIdx_9]=InMat.RelVec[PIdx_9];}if(PIdx_10<InMat.nCallForFather){SMemMat->RelVec[PIdx_10]=InMat.RelVec[PIdx_10];}if(PIdx_11<InMat.nCallForFather){SMemMat->RelVec[PIdx_11]=InMat.RelVec[PIdx_11];}if(PIdx_12<InMat.nCallForFather){SMemMat->RelVec[PIdx_12]=InMat.RelVec[PIdx_12];}if(PIdx_13<InMat.nCallForFather){SMemMat->RelVec[PIdx_13]=InMat.RelVec[PIdx_13];}
	//if(PIdx_1<InMat.nCallForFather+1) {SMemMat->SegStartI[PIdx_1]=InMat.SegStartI[PIdx_1];SMemMat->SegEndI[PIdx_1]=InMat.SegEndI[PIdx_1];}
	//#define THISCOMMANDHERE15(VARILP) if(PIdx_ ## VARILP<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_ ## VARILP]=InMat.SegStartI[PIdx_ ## VARILP];SMemMat->SegEndI[PIdx_ ## VARILP]=InMat.SegEndI[PIdx_ ## VARILP];}
	//if(PIdx_1<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_1]=InMat.SegStartI[PIdx_1];SMemMat->SegEndI[PIdx_1]=InMat.SegEndI[PIdx_1];}if(PIdx_2<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_2]=InMat.SegStartI[PIdx_2];SMemMat->SegEndI[PIdx_2]=InMat.SegEndI[PIdx_2];}if(PIdx_3<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_3]=InMat.SegStartI[PIdx_3];SMemMat->SegEndI[PIdx_3]=InMat.SegEndI[PIdx_3];}if(PIdx_4<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_4]=InMat.SegStartI[PIdx_4];SMemMat->SegEndI[PIdx_4]=InMat.SegEndI[PIdx_4];}if(PIdx_5<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_5]=InMat.SegStartI[PIdx_5];SMemMat->SegEndI[PIdx_5]=InMat.SegEndI[PIdx_5];}if(PIdx_6<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_6]=InMat.SegStartI[PIdx_6];SMemMat->SegEndI[PIdx_6]=InMat.SegEndI[PIdx_6];}if(PIdx_7<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_7]=InMat.SegStartI[PIdx_7];SMemMat->SegEndI[PIdx_7]=InMat.SegEndI[PIdx_7];}if(PIdx_8<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_8]=InMat.SegStartI[PIdx_8];SMemMat->SegEndI[PIdx_8]=InMat.SegEndI[PIdx_8];}if(PIdx_9<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_9]=InMat.SegStartI[PIdx_9];SMemMat->SegEndI[PIdx_9]=InMat.SegEndI[PIdx_9];}if(PIdx_10<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_10]=InMat.SegStartI[PIdx_10];SMemMat->SegEndI[PIdx_10]=InMat.SegEndI[PIdx_10];}if(PIdx_11<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_11]=InMat.SegStartI[PIdx_11];SMemMat->SegEndI[PIdx_11]=InMat.SegEndI[PIdx_11];}if(PIdx_12<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_12]=InMat.SegStartI[PIdx_12];SMemMat->SegEndI[PIdx_12]=InMat.SegEndI[PIdx_12];}if(PIdx_13<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_13]=InMat.SegStartI[PIdx_13];SMemMat->SegEndI[PIdx_13]=InMat.SegEndI[PIdx_13];}
	//__syncthreads();
	//for(int i=0;i<CompDepth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByLevel32[WARPSIZE*i+PIdx_1];}
	//#define THISCOMMANDHERE123(VARILP) for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_ ## VARILP]=InMat.CompByLevel32[WARPSIZE*i+PIdx_ ## VARILP];}
	//for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByLevel32[WARPSIZE*i+PIdx_1];}for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_2]=InMat.CompByLevel32[WARPSIZE*i+PIdx_2];}for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_3]=InMat.CompByLevel32[WARPSIZE*i+PIdx_3];}
	//for(int i=0;i<CompFDepth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_1];}
	//#define THISCOMMANDHERE124(VARILP) for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_ ## VARILP]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_ ## VARILP];}
	//for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_1];}for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_2]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_2];}for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_3]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_3];}
	//if(PIdx_1<InMat.nLRel) {SMemMat->LRelStarts[PIdx_1]=InMat.LRelStarts[PIdx_1];SMemMat->LRelEnds[PIdx_1]=InMat.LRelEnds[PIdx_1];}
	//#define THISCOMMANDHERE16(VARILP) if(PIdx_ ## VARILP<InMat.nLRel){SMemMat->LRelStarts[PIdx_ ## VARILP]=InMat.LRelStarts[PIdx_ ## VARILP];SMemMat->LRelEnds[PIdx_ ## VARILP]=InMat.LRelEnds[PIdx_ ## VARILP];}
	//if(PIdx_1<InMat.nLRel){SMemMat->LRelStarts[PIdx_1]=InMat.LRelStarts[PIdx_1];SMemMat->LRelEnds[PIdx_1]=InMat.LRelEnds[PIdx_1];}if(PIdx_2<InMat.nLRel){SMemMat->LRelStarts[PIdx_2]=InMat.LRelStarts[PIdx_2];SMemMat->LRelEnds[PIdx_2]=InMat.LRelEnds[PIdx_2];}if(PIdx_3<InMat.nLRel){SMemMat->LRelStarts[PIdx_3]=InMat.LRelStarts[PIdx_3];SMemMat->LRelEnds[PIdx_3]=InMat.LRelEnds[PIdx_3];}if(PIdx_4<InMat.nLRel){SMemMat->LRelStarts[PIdx_4]=InMat.LRelStarts[PIdx_4];SMemMat->LRelEnds[PIdx_4]=InMat.LRelEnds[PIdx_4];}if(PIdx_5<InMat.nLRel){SMemMat->LRelStarts[PIdx_5]=InMat.LRelStarts[PIdx_5];SMemMat->LRelEnds[PIdx_5]=InMat.LRelEnds[PIdx_5];}if(PIdx_6<InMat.nLRel){SMemMat->LRelStarts[PIdx_6]=InMat.LRelStarts[PIdx_6];SMemMat->LRelEnds[PIdx_6]=InMat.LRelEnds[PIdx_6];}if(PIdx_7<InMat.nLRel){SMemMat->LRelStarts[PIdx_7]=InMat.LRelStarts[PIdx_7];SMemMat->LRelEnds[PIdx_7]=InMat.LRelEnds[PIdx_7];}if(PIdx_8<InMat.nLRel){SMemMat->LRelStarts[PIdx_8]=InMat.LRelStarts[PIdx_8];SMemMat->LRelEnds[PIdx_8]=InMat.LRelEnds[PIdx_8];}if(PIdx_9<InMat.nLRel){SMemMat->LRelStarts[PIdx_9]=InMat.LRelStarts[PIdx_9];SMemMat->LRelEnds[PIdx_9]=InMat.LRelEnds[PIdx_9];}if(PIdx_10<InMat.nLRel){SMemMat->LRelStarts[PIdx_10]=InMat.LRelStarts[PIdx_10];SMemMat->LRelEnds[PIdx_10]=InMat.LRelEnds[PIdx_10];}if(PIdx_11<InMat.nLRel){SMemMat->LRelStarts[PIdx_11]=InMat.LRelStarts[PIdx_11];SMemMat->LRelEnds[PIdx_11]=InMat.LRelEnds[PIdx_11];}if(PIdx_12<InMat.nLRel){SMemMat->LRelStarts[PIdx_12]=InMat.LRelStarts[PIdx_12];SMemMat->LRelEnds[PIdx_12]=InMat.LRelEnds[PIdx_12];}if(PIdx_13<InMat.nLRel){SMemMat->LRelStarts[PIdx_13]=InMat.LRelStarts[PIdx_13];SMemMat->LRelEnds[PIdx_13]=InMat.LRelEnds[PIdx_13];}
	//__syncthreads();
	//if(PIdx_1<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_1]=InMat.FLRelStarts[PIdx_1];SMemMat->FLRelEnds[PIdx_1]=InMat.FLRelEnds[PIdx_1];}
	//#define THISCOMMANDHERE17(VARILP) if(PIdx_ ## VARILP<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_ ## VARILP]=InMat.FLRelStarts[PIdx_ ## VARILP];SMemMat->FLRelEnds[PIdx_ ## VARILP]=InMat.FLRelEnds[PIdx_ ## VARILP];}
	//if(PIdx_1<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_1]=InMat.FLRelStarts[PIdx_1];SMemMat->FLRelEnds[PIdx_1]=InMat.FLRelEnds[PIdx_1];}if(PIdx_2<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_2]=InMat.FLRelStarts[PIdx_2];SMemMat->FLRelEnds[PIdx_2]=InMat.FLRelEnds[PIdx_2];}if(PIdx_3<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_3]=InMat.FLRelStarts[PIdx_3];SMemMat->FLRelEnds[PIdx_3]=InMat.FLRelEnds[PIdx_3];}if(PIdx_4<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_4]=InMat.FLRelStarts[PIdx_4];SMemMat->FLRelEnds[PIdx_4]=InMat.FLRelEnds[PIdx_4];}if(PIdx_5<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_5]=InMat.FLRelStarts[PIdx_5];SMemMat->FLRelEnds[PIdx_5]=InMat.FLRelEnds[PIdx_5];}if(PIdx_6<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_6]=InMat.FLRelStarts[PIdx_6];SMemMat->FLRelEnds[PIdx_6]=InMat.FLRelEnds[PIdx_6];}if(PIdx_7<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_7]=InMat.FLRelStarts[PIdx_7];SMemMat->FLRelEnds[PIdx_7]=InMat.FLRelEnds[PIdx_7];}if(PIdx_8<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_8]=InMat.FLRelStarts[PIdx_8];SMemMat->FLRelEnds[PIdx_8]=InMat.FLRelEnds[PIdx_8];}if(PIdx_9<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_9]=InMat.FLRelStarts[PIdx_9];SMemMat->FLRelEnds[PIdx_9]=InMat.FLRelEnds[PIdx_9];}if(PIdx_10<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_10]=InMat.FLRelStarts[PIdx_10];SMemMat->FLRelEnds[PIdx_10]=InMat.FLRelEnds[PIdx_10];}if(PIdx_11<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_11]=InMat.FLRelStarts[PIdx_11];SMemMat->FLRelEnds[PIdx_11]=InMat.FLRelEnds[PIdx_11];}if(PIdx_12<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_12]=InMat.FLRelStarts[PIdx_12];SMemMat->FLRelEnds[PIdx_12]=InMat.FLRelEnds[PIdx_12];}if(PIdx_13<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_13]=InMat.FLRelStarts[PIdx_13];SMemMat->FLRelEnds[PIdx_13]=InMat.FLRelEnds[PIdx_13];}

	//RBS This works now where all models are in the same comps we need to genreralize it.
	//RBS  This code should be generated with calling all models init and defining all states.
	return offset;
}	
__device__ void runSimulation(HMat SMemMat,HMat InMat,MYFTYPE* V,Stim stim,Sim sim,MYFTYPE* VHotGlobal,MYFTYPE* SMemVHot,MYFTYPE* amps,MYDTYPE offset,cudaTextureObject_t tex)
{
	MYFTYPE *Vs;
	MYSECONDFTYPE *uHP,*bHP;
		// For solving the matrix
#ifdef BKSUB2
    MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(InMat.N+2*WARPSIZE)*sizeof(MYFTYPE);
#endif
#ifdef BKSUB1
   MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(WARPSIZE + sim.NRecSites*WARPSIZE)*sizeof(MYFTYPE);
#endif
	//MYDTYPE PerStimulus;
	//PerStimulus = InMat.N+2;
	offset+=PerStimulus*threadIdx.y;
	uHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	bHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	//Vs = (MYFTYPE*) &smem[offset];
	//offset+=InMat.N*sizeof(MYFTYPE);
	// Vs[PIdx_3]=V[PIdx_3];
	SMemVHot = (MYFTYPE*) &smem[offset];
	offset+=WARPSIZE*sim.NRecSites*sizeof(MYFTYPE);
    amps = (MYFTYPE*) &smem[offset];
    offset+=WARPSIZE*sizeof(MYFTYPE);
	MYDTYPE NeuronID = blockIdx.x;
	int Nt=stim.Nt;
	MYFTYPE t=0;
	MYSECONDFTYPE *PX,*PF;
	PX=bHP;
	PF=uHP;
	#define THISCOMMANDHERE18(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1));
	MYDTYPE PIdx_1 =threadIdx.x+(WARPSIZE*(1 -1));MYDTYPE PIdx_2 =threadIdx.x+(WARPSIZE*(2 -1));MYDTYPE PIdx_3 =threadIdx.x+(WARPSIZE*(3 -1));MYDTYPE PIdx_4 =threadIdx.x+(WARPSIZE*(4 -1));MYDTYPE PIdx_5 =threadIdx.x+(WARPSIZE*(5 -1));MYDTYPE PIdx_6 =threadIdx.x+(WARPSIZE*(6 -1));MYDTYPE PIdx_7 =threadIdx.x+(WARPSIZE*(7 -1));MYDTYPE PIdx_8 =threadIdx.x+(WARPSIZE*(8 -1));MYDTYPE PIdx_9 =threadIdx.x+(WARPSIZE*(9 -1));MYDTYPE PIdx_10 =threadIdx.x+(WARPSIZE*(10 -1));MYDTYPE PIdx_11 =threadIdx.x+(WARPSIZE*(11 -1));MYDTYPE PIdx_12 =threadIdx.x+(WARPSIZE*(12 -1));MYDTYPE PIdx_13 =threadIdx.x+(WARPSIZE*(13 -1));

	 #define THISCOMMANDHERE19(VARILP) MYFTYPE isModel_ ## VARILP , dVec_ ## VARILP , Vmid_ ## VARILP ; MYFTYPE ModelStates_ ## VARILP [NSTATES]; MYFTYPE v_ ## VARILP =V[PIdx_ ## VARILP ]; MYFTYPE dv_ ## VARILP;
	MYFTYPE isModel_1 , dVec_1 , Vmid_1 ; MYFTYPE ModelStates_1 [NSTATES]; MYFTYPE v_1 =V[PIdx_1 ]; MYFTYPE dv_1;MYFTYPE isModel_2 , dVec_2 , Vmid_2 ; MYFTYPE ModelStates_2 [NSTATES]; MYFTYPE v_2 =V[PIdx_2 ]; MYFTYPE dv_2;MYFTYPE isModel_3 , dVec_3 , Vmid_3 ; MYFTYPE ModelStates_3 [NSTATES]; MYFTYPE v_3 =V[PIdx_3 ]; MYFTYPE dv_3;MYFTYPE isModel_4 , dVec_4 , Vmid_4 ; MYFTYPE ModelStates_4 [NSTATES]; MYFTYPE v_4 =V[PIdx_4 ]; MYFTYPE dv_4;MYFTYPE isModel_5 , dVec_5 , Vmid_5 ; MYFTYPE ModelStates_5 [NSTATES]; MYFTYPE v_5 =V[PIdx_5 ]; MYFTYPE dv_5;MYFTYPE isModel_6 , dVec_6 , Vmid_6 ; MYFTYPE ModelStates_6 [NSTATES]; MYFTYPE v_6 =V[PIdx_6 ]; MYFTYPE dv_6;MYFTYPE isModel_7 , dVec_7 , Vmid_7 ; MYFTYPE ModelStates_7 [NSTATES]; MYFTYPE v_7 =V[PIdx_7 ]; MYFTYPE dv_7;MYFTYPE isModel_8 , dVec_8 , Vmid_8 ; MYFTYPE ModelStates_8 [NSTATES]; MYFTYPE v_8 =V[PIdx_8 ]; MYFTYPE dv_8;MYFTYPE isModel_9 , dVec_9 , Vmid_9 ; MYFTYPE ModelStates_9 [NSTATES]; MYFTYPE v_9 =V[PIdx_9 ]; MYFTYPE dv_9;MYFTYPE isModel_10 , dVec_10 , Vmid_10 ; MYFTYPE ModelStates_10 [NSTATES]; MYFTYPE v_10 =V[PIdx_10 ]; MYFTYPE dv_10;MYFTYPE isModel_11 , dVec_11 , Vmid_11 ; MYFTYPE ModelStates_11 [NSTATES]; MYFTYPE v_11 =V[PIdx_11 ]; MYFTYPE dv_11;MYFTYPE isModel_12 , dVec_12 , Vmid_12 ; MYFTYPE ModelStates_12 [NSTATES]; MYFTYPE v_12 =V[PIdx_12 ]; MYFTYPE dv_12;MYFTYPE isModel_13 , dVec_13 , Vmid_13 ; MYFTYPE ModelStates_13 [NSTATES]; MYFTYPE v_13 =V[PIdx_13 ]; MYFTYPE dv_13;

	 #define THISCOMMANDHERE20(VARILP) MYSECONDFTYPE sumCurrents_ ## VARILP=0 ,sumCurrentsDv_ ## VARILP=0; MYFTYPE  sumConductivity_ ## VARILP=0 ,sumConductivityDv_ ## VARILP=0 ;
	MYSECONDFTYPE sumCurrents_1=0 ,sumCurrentsDv_1=0; MYFTYPE  sumConductivity_1=0 ,sumConductivityDv_1=0 ;MYSECONDFTYPE sumCurrents_2=0 ,sumCurrentsDv_2=0; MYFTYPE  sumConductivity_2=0 ,sumConductivityDv_2=0 ;MYSECONDFTYPE sumCurrents_3=0 ,sumCurrentsDv_3=0; MYFTYPE  sumConductivity_3=0 ,sumConductivityDv_3=0 ;MYSECONDFTYPE sumCurrents_4=0 ,sumCurrentsDv_4=0; MYFTYPE  sumConductivity_4=0 ,sumConductivityDv_4=0 ;MYSECONDFTYPE sumCurrents_5=0 ,sumCurrentsDv_5=0; MYFTYPE  sumConductivity_5=0 ,sumConductivityDv_5=0 ;MYSECONDFTYPE sumCurrents_6=0 ,sumCurrentsDv_6=0; MYFTYPE  sumConductivity_6=0 ,sumConductivityDv_6=0 ;MYSECONDFTYPE sumCurrents_7=0 ,sumCurrentsDv_7=0; MYFTYPE  sumConductivity_7=0 ,sumConductivityDv_7=0 ;MYSECONDFTYPE sumCurrents_8=0 ,sumCurrentsDv_8=0; MYFTYPE  sumConductivity_8=0 ,sumConductivityDv_8=0 ;MYSECONDFTYPE sumCurrents_9=0 ,sumCurrentsDv_9=0; MYFTYPE  sumConductivity_9=0 ,sumConductivityDv_9=0 ;MYSECONDFTYPE sumCurrents_10=0 ,sumCurrentsDv_10=0; MYFTYPE  sumConductivity_10=0 ,sumConductivityDv_10=0 ;MYSECONDFTYPE sumCurrents_11=0 ,sumCurrentsDv_11=0; MYFTYPE  sumConductivity_11=0 ,sumConductivityDv_11=0 ;MYSECONDFTYPE sumCurrents_12=0 ,sumCurrentsDv_12=0; MYFTYPE  sumConductivity_12=0 ,sumConductivityDv_12=0 ;MYSECONDFTYPE sumCurrents_13=0 ,sumCurrentsDv_13=0; MYFTYPE  sumConductivity_13=0 ,sumConductivityDv_13=0 ;
	// end for model in init
	ModelStates_1 [0]=0;ModelStates_1 [1]=0;ModelStates_1 [2]=0;ModelStates_1 [3]=0;ModelStates_1 [4]=0;ModelStates_1 [5]=0;ModelStates_1 [6]=0;ModelStates_1 [7]=0;ModelStates_1 [8]=0;ModelStates_1 [9]=0;;ModelStates_2 [0]=0;ModelStates_2 [1]=0;ModelStates_2 [2]=0;ModelStates_2 [3]=0;ModelStates_2 [4]=0;ModelStates_2 [5]=0;ModelStates_2 [6]=0;ModelStates_2 [7]=0;ModelStates_2 [8]=0;ModelStates_2 [9]=0;;ModelStates_3 [0]=0;ModelStates_3 [1]=0;ModelStates_3 [2]=0;ModelStates_3 [3]=0;ModelStates_3 [4]=0;ModelStates_3 [5]=0;ModelStates_3 [6]=0;ModelStates_3 [7]=0;ModelStates_3 [8]=0;ModelStates_3 [9]=0;;ModelStates_4 [0]=0;ModelStates_4 [1]=0;ModelStates_4 [2]=0;ModelStates_4 [3]=0;ModelStates_4 [4]=0;ModelStates_4 [5]=0;ModelStates_4 [6]=0;ModelStates_4 [7]=0;ModelStates_4 [8]=0;ModelStates_4 [9]=0;;ModelStates_5 [0]=0;ModelStates_5 [1]=0;ModelStates_5 [2]=0;ModelStates_5 [3]=0;ModelStates_5 [4]=0;ModelStates_5 [5]=0;ModelStates_5 [6]=0;ModelStates_5 [7]=0;ModelStates_5 [8]=0;ModelStates_5 [9]=0;;ModelStates_6 [0]=0;ModelStates_6 [1]=0;ModelStates_6 [2]=0;ModelStates_6 [3]=0;ModelStates_6 [4]=0;ModelStates_6 [5]=0;ModelStates_6 [6]=0;ModelStates_6 [7]=0;ModelStates_6 [8]=0;ModelStates_6 [9]=0;;ModelStates_7 [0]=0;ModelStates_7 [1]=0;ModelStates_7 [2]=0;ModelStates_7 [3]=0;ModelStates_7 [4]=0;ModelStates_7 [5]=0;ModelStates_7 [6]=0;ModelStates_7 [7]=0;ModelStates_7 [8]=0;ModelStates_7 [9]=0;;ModelStates_8 [0]=0;ModelStates_8 [1]=0;ModelStates_8 [2]=0;ModelStates_8 [3]=0;ModelStates_8 [4]=0;ModelStates_8 [5]=0;ModelStates_8 [6]=0;ModelStates_8 [7]=0;ModelStates_8 [8]=0;ModelStates_8 [9]=0;;ModelStates_9 [0]=0;ModelStates_9 [1]=0;ModelStates_9 [2]=0;ModelStates_9 [3]=0;ModelStates_9 [4]=0;ModelStates_9 [5]=0;ModelStates_9 [6]=0;ModelStates_9 [7]=0;ModelStates_9 [8]=0;ModelStates_9 [9]=0;;ModelStates_10 [0]=0;ModelStates_10 [1]=0;ModelStates_10 [2]=0;ModelStates_10 [3]=0;ModelStates_10 [4]=0;ModelStates_10 [5]=0;ModelStates_10 [6]=0;ModelStates_10 [7]=0;ModelStates_10 [8]=0;ModelStates_10 [9]=0;;ModelStates_11 [0]=0;ModelStates_11 [1]=0;ModelStates_11 [2]=0;ModelStates_11 [3]=0;ModelStates_11 [4]=0;ModelStates_11 [5]=0;ModelStates_11 [6]=0;ModelStates_11 [7]=0;ModelStates_11 [8]=0;ModelStates_11 [9]=0;;ModelStates_12 [0]=0;ModelStates_12 [1]=0;ModelStates_12 [2]=0;ModelStates_12 [3]=0;ModelStates_12 [4]=0;ModelStates_12 [5]=0;ModelStates_12 [6]=0;ModelStates_12 [7]=0;ModelStates_12 [8]=0;ModelStates_12 [9]=0;;ModelStates_13 [0]=0;ModelStates_13 [1]=0;ModelStates_13 [2]=0;ModelStates_13 [3]=0;ModelStates_13 [4]=0;ModelStates_13 [5]=0;ModelStates_13 [6]=0;ModelStates_13 [7]=0;ModelStates_13 [8]=0;ModelStates_13 [9]=0;;
	//#define THISCOMMANDHERE21(VARILP) MYDTYPE SonNo_ ## VARILP =InMat.SonNoVec[PIdx_ ## VARILP ];
	//MYDTYPE SonNo_1 =InMat.SonNoVec[PIdx_1 ];MYDTYPE SonNo_2 =InMat.SonNoVec[PIdx_2 ];MYDTYPE SonNo_3 =InMat.SonNoVec[PIdx_3 ];MYDTYPE SonNo_4 =InMat.SonNoVec[PIdx_4 ];MYDTYPE SonNo_5 =InMat.SonNoVec[PIdx_5 ];MYDTYPE SonNo_6 =InMat.SonNoVec[PIdx_6 ];MYDTYPE SonNo_7 =InMat.SonNoVec[PIdx_7 ];MYDTYPE SonNo_8 =InMat.SonNoVec[PIdx_8 ];MYDTYPE SonNo_9 =InMat.SonNoVec[PIdx_9 ];MYDTYPE SonNo_10 =InMat.SonNoVec[PIdx_10 ];MYDTYPE SonNo_11 =InMat.SonNoVec[PIdx_11 ];MYDTYPE SonNo_12 =InMat.SonNoVec[PIdx_12 ];MYDTYPE SonNo_13 =InMat.SonNoVec[PIdx_13 ];
	//RBS i deleteed  Vs[PIdx_ ## VARILP ]=V[PIdx_ ## VARILP ];
	#define THISCOMMANDHERE22(VARILP) Vs[PIdx_ ## VARILP ]=V[PIdx_ ## VARILP ];bHP[PIdx_ ## VARILP]=0;dv_ ## VARILP =0;
	bHP[PIdx_1]=0;dv_1 =0;;bHP[PIdx_2]=0;dv_2 =0;bHP[PIdx_3]=0;dv_3 =0;bHP[PIdx_4]=0;dv_4 =0;bHP[PIdx_5]=0;dv_5 =0;bHP[PIdx_6]=0;dv_6 =0;bHP[PIdx_7]=0;dv_7 =0;bHP[PIdx_8]=0;dv_8 =0;bHP[PIdx_9]=0;dv_9 =0;bHP[PIdx_10]=0;dv_10 =0;bHP[PIdx_11]=0;dv_11 =0;bHP[PIdx_12]=0;dv_12 =0;bHP[PIdx_13]=0;dv_13 =0;

	// MYDTYPE parentIndex_3; // MYDTYPE Eidx_3; // Eidx_3 = SMemMat->N-PIdx_3;
	#define THISCOMMANDHERE23(VARILP) MYDTYPE parentIndex_ ## VARILP ; MYDTYPE Eidx_ ## VARILP ; Eidx_ ## VARILP = SMemMat.N-PIdx_ ## VARILP -1;
	MYDTYPE parentIndex_1 ; MYDTYPE Eidx_1 ; Eidx_1 = SMemMat.N-PIdx_1 -1;MYDTYPE parentIndex_2 ; MYDTYPE Eidx_2 ; Eidx_2 = SMemMat.N-PIdx_2 -1;MYDTYPE parentIndex_3 ; MYDTYPE Eidx_3 ; Eidx_3 = SMemMat.N-PIdx_3 -1;MYDTYPE parentIndex_4 ; MYDTYPE Eidx_4 ; Eidx_4 = SMemMat.N-PIdx_4 -1;MYDTYPE parentIndex_5 ; MYDTYPE Eidx_5 ; Eidx_5 = SMemMat.N-PIdx_5 -1;MYDTYPE parentIndex_6 ; MYDTYPE Eidx_6 ; Eidx_6 = SMemMat.N-PIdx_6 -1;MYDTYPE parentIndex_7 ; MYDTYPE Eidx_7 ; Eidx_7 = SMemMat.N-PIdx_7 -1;MYDTYPE parentIndex_8 ; MYDTYPE Eidx_8 ; Eidx_8 = SMemMat.N-PIdx_8 -1;MYDTYPE parentIndex_9 ; MYDTYPE Eidx_9 ; Eidx_9 = SMemMat.N-PIdx_9 -1;MYDTYPE parentIndex_10 ; MYDTYPE Eidx_10 ; Eidx_10 = SMemMat.N-PIdx_10 -1;MYDTYPE parentIndex_11 ; MYDTYPE Eidx_11 ; Eidx_11 = SMemMat.N-PIdx_11 -1;MYDTYPE parentIndex_12 ; MYDTYPE Eidx_12 ; Eidx_12 = SMemMat.N-PIdx_12 -1;MYDTYPE parentIndex_13 ; MYDTYPE Eidx_13 ; Eidx_13 = SMemMat.N-PIdx_13 -1;
	// RRRXXX This probably should be in ILP too!
	if(Eidx_1>SMemMat.N-1){
		Eidx_1=SMemMat.N-1;
	}
	MYDTYPE perThreadParamMSize = SMemMat.NComps*NPARAMS;
//#define param_macro(paramInd,segmentInd) ParamsM[NeuronID*perThreadParamMSize + paramInd*SMemMat.NComps+cSegToComp[segmentInd] ]
	#define param_macro(paramInd,segmentInd) tex2D<float>(tex, paramInd*SMemMat.NComps+cSegToComp[segmentInd], NeuronID)


if(cBoolModel[PIdx_1 +0*SMemMat.N]){CuInitModel_ca(v_1,ModelStates_1[0],ModelStates_1[1],param_macro(0,PIdx_1) ,param_macro(1,PIdx_1) ,ModelStates_1[8],ModelStates_1[9]);} if(cBoolModel[PIdx_1 +1*SMemMat.N]){CuInitModel_cad(v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(cBoolModel[PIdx_1 +2*SMemMat.N]){CuInitModel_kca(v_1,ModelStates_1[3],param_macro(2,PIdx_1) ,param_macro(3,PIdx_1) ,param_macro(4,PIdx_1) ,param_macro(5,PIdx_1) ,ModelStates_1[8]);} if(cBoolModel[PIdx_1 +3*SMemMat.N]){CuInitModel_km(v_1,ModelStates_1[4],param_macro(6,PIdx_1) ,param_macro(7,PIdx_1) ,param_macro(8,PIdx_1) ,param_macro(9,PIdx_1) ,param_macro(10,PIdx_1) );} if(cBoolModel[PIdx_1 +4*SMemMat.N]){CuInitModel_kv(v_1,ModelStates_1[5],param_macro(11,PIdx_1) ,param_macro(12,PIdx_1) ,param_macro(13,PIdx_1) ,param_macro(14,PIdx_1) ,param_macro(15,PIdx_1) );} if(cBoolModel[PIdx_1 +5*SMemMat.N]){CuInitModel_na(v_1,ModelStates_1[6],ModelStates_1[7],param_macro(16,PIdx_1) ,param_macro(17,PIdx_1) ,param_macro(18,PIdx_1) ,param_macro(19,PIdx_1) ,param_macro(20,PIdx_1) ,param_macro(21,PIdx_1) ,param_macro(22,PIdx_1) ,param_macro(23,PIdx_1) ,param_macro(24,PIdx_1) ,param_macro(25,PIdx_1) ,param_macro(26,PIdx_1) ,param_macro(27,PIdx_1) );} if(cBoolModel[PIdx_1 +6*SMemMat.N]){CuInitModel_pas(v_1,param_macro(28,PIdx_1) ,param_macro(29,PIdx_1) );}  if(cBoolModel[PIdx_2 +0*SMemMat.N]){CuInitModel_ca(v_2,ModelStates_2[0],ModelStates_2[1],param_macro(0,PIdx_2) ,param_macro(1,PIdx_2) ,ModelStates_2[8],ModelStates_2[9]);} if(cBoolModel[PIdx_2 +1*SMemMat.N]){CuInitModel_cad(v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(cBoolModel[PIdx_2 +2*SMemMat.N]){CuInitModel_kca(v_2,ModelStates_2[3],param_macro(2,PIdx_2) ,param_macro(3,PIdx_2) ,param_macro(4,PIdx_2) ,param_macro(5,PIdx_2) ,ModelStates_2[8]);} if(cBoolModel[PIdx_2 +3*SMemMat.N]){CuInitModel_km(v_2,ModelStates_2[4],param_macro(6,PIdx_2) ,param_macro(7,PIdx_2) ,param_macro(8,PIdx_2) ,param_macro(9,PIdx_2) ,param_macro(10,PIdx_2) );} if(cBoolModel[PIdx_2 +4*SMemMat.N]){CuInitModel_kv(v_2,ModelStates_2[5],param_macro(11,PIdx_2) ,param_macro(12,PIdx_2) ,param_macro(13,PIdx_2) ,param_macro(14,PIdx_2) ,param_macro(15,PIdx_2) );} if(cBoolModel[PIdx_2 +5*SMemMat.N]){CuInitModel_na(v_2,ModelStates_2[6],ModelStates_2[7],param_macro(16,PIdx_2) ,param_macro(17,PIdx_2) ,param_macro(18,PIdx_2) ,param_macro(19,PIdx_2) ,param_macro(20,PIdx_2) ,param_macro(21,PIdx_2) ,param_macro(22,PIdx_2) ,param_macro(23,PIdx_2) ,param_macro(24,PIdx_2) ,param_macro(25,PIdx_2) ,param_macro(26,PIdx_2) ,param_macro(27,PIdx_2) );} if(cBoolModel[PIdx_2 +6*SMemMat.N]){CuInitModel_pas(v_2,param_macro(28,PIdx_2) ,param_macro(29,PIdx_2) );}  if(cBoolModel[PIdx_3 +0*SMemMat.N]){CuInitModel_ca(v_3,ModelStates_3[0],ModelStates_3[1],param_macro(0,PIdx_3) ,param_macro(1,PIdx_3) ,ModelStates_3[8],ModelStates_3[9]);} if(cBoolModel[PIdx_3 +1*SMemMat.N]){CuInitModel_cad(v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(cBoolModel[PIdx_3 +2*SMemMat.N]){CuInitModel_kca(v_3,ModelStates_3[3],param_macro(2,PIdx_3) ,param_macro(3,PIdx_3) ,param_macro(4,PIdx_3) ,param_macro(5,PIdx_3) ,ModelStates_3[8]);} if(cBoolModel[PIdx_3 +3*SMemMat.N]){CuInitModel_km(v_3,ModelStates_3[4],param_macro(6,PIdx_3) ,param_macro(7,PIdx_3) ,param_macro(8,PIdx_3) ,param_macro(9,PIdx_3) ,param_macro(10,PIdx_3) );} if(cBoolModel[PIdx_3 +4*SMemMat.N]){CuInitModel_kv(v_3,ModelStates_3[5],param_macro(11,PIdx_3) ,param_macro(12,PIdx_3) ,param_macro(13,PIdx_3) ,param_macro(14,PIdx_3) ,param_macro(15,PIdx_3) );} if(cBoolModel[PIdx_3 +5*SMemMat.N]){CuInitModel_na(v_3,ModelStates_3[6],ModelStates_3[7],param_macro(16,PIdx_3) ,param_macro(17,PIdx_3) ,param_macro(18,PIdx_3) ,param_macro(19,PIdx_3) ,param_macro(20,PIdx_3) ,param_macro(21,PIdx_3) ,param_macro(22,PIdx_3) ,param_macro(23,PIdx_3) ,param_macro(24,PIdx_3) ,param_macro(25,PIdx_3) ,param_macro(26,PIdx_3) ,param_macro(27,PIdx_3) );} if(cBoolModel[PIdx_3 +6*SMemMat.N]){CuInitModel_pas(v_3,param_macro(28,PIdx_3) ,param_macro(29,PIdx_3) );}  if(cBoolModel[PIdx_4 +0*SMemMat.N]){CuInitModel_ca(v_4,ModelStates_4[0],ModelStates_4[1],param_macro(0,PIdx_4) ,param_macro(1,PIdx_4) ,ModelStates_4[8],ModelStates_4[9]);} if(cBoolModel[PIdx_4 +1*SMemMat.N]){CuInitModel_cad(v_4,ModelStates_4[2],ModelStates_4[9],ModelStates_4[8]);} if(cBoolModel[PIdx_4 +2*SMemMat.N]){CuInitModel_kca(v_4,ModelStates_4[3],param_macro(2,PIdx_4) ,param_macro(3,PIdx_4) ,param_macro(4,PIdx_4) ,param_macro(5,PIdx_4) ,ModelStates_4[8]);} if(cBoolModel[PIdx_4 +3*SMemMat.N]){CuInitModel_km(v_4,ModelStates_4[4],param_macro(6,PIdx_4) ,param_macro(7,PIdx_4) ,param_macro(8,PIdx_4) ,param_macro(9,PIdx_4) ,param_macro(10,PIdx_4) );} if(cBoolModel[PIdx_4 +4*SMemMat.N]){CuInitModel_kv(v_4,ModelStates_4[5],param_macro(11,PIdx_4) ,param_macro(12,PIdx_4) ,param_macro(13,PIdx_4) ,param_macro(14,PIdx_4) ,param_macro(15,PIdx_4) );} if(cBoolModel[PIdx_4 +5*SMemMat.N]){CuInitModel_na(v_4,ModelStates_4[6],ModelStates_4[7],param_macro(16,PIdx_4) ,param_macro(17,PIdx_4) ,param_macro(18,PIdx_4) ,param_macro(19,PIdx_4) ,param_macro(20,PIdx_4) ,param_macro(21,PIdx_4) ,param_macro(22,PIdx_4) ,param_macro(23,PIdx_4) ,param_macro(24,PIdx_4) ,param_macro(25,PIdx_4) ,param_macro(26,PIdx_4) ,param_macro(27,PIdx_4) );} if(cBoolModel[PIdx_4 +6*SMemMat.N]){CuInitModel_pas(v_4,param_macro(28,PIdx_4) ,param_macro(29,PIdx_4) );}  if(cBoolModel[PIdx_5 +0*SMemMat.N]){CuInitModel_ca(v_5,ModelStates_5[0],ModelStates_5[1],param_macro(0,PIdx_5) ,param_macro(1,PIdx_5) ,ModelStates_5[8],ModelStates_5[9]);} if(cBoolModel[PIdx_5 +1*SMemMat.N]){CuInitModel_cad(v_5,ModelStates_5[2],ModelStates_5[9],ModelStates_5[8]);} if(cBoolModel[PIdx_5 +2*SMemMat.N]){CuInitModel_kca(v_5,ModelStates_5[3],param_macro(2,PIdx_5) ,param_macro(3,PIdx_5) ,param_macro(4,PIdx_5) ,param_macro(5,PIdx_5) ,ModelStates_5[8]);} if(cBoolModel[PIdx_5 +3*SMemMat.N]){CuInitModel_km(v_5,ModelStates_5[4],param_macro(6,PIdx_5) ,param_macro(7,PIdx_5) ,param_macro(8,PIdx_5) ,param_macro(9,PIdx_5) ,param_macro(10,PIdx_5) );} if(cBoolModel[PIdx_5 +4*SMemMat.N]){CuInitModel_kv(v_5,ModelStates_5[5],param_macro(11,PIdx_5) ,param_macro(12,PIdx_5) ,param_macro(13,PIdx_5) ,param_macro(14,PIdx_5) ,param_macro(15,PIdx_5) );} if(cBoolModel[PIdx_5 +5*SMemMat.N]){CuInitModel_na(v_5,ModelStates_5[6],ModelStates_5[7],param_macro(16,PIdx_5) ,param_macro(17,PIdx_5) ,param_macro(18,PIdx_5) ,param_macro(19,PIdx_5) ,param_macro(20,PIdx_5) ,param_macro(21,PIdx_5) ,param_macro(22,PIdx_5) ,param_macro(23,PIdx_5) ,param_macro(24,PIdx_5) ,param_macro(25,PIdx_5) ,param_macro(26,PIdx_5) ,param_macro(27,PIdx_5) );} if(cBoolModel[PIdx_5 +6*SMemMat.N]){CuInitModel_pas(v_5,param_macro(28,PIdx_5) ,param_macro(29,PIdx_5) );}  if(cBoolModel[PIdx_6 +0*SMemMat.N]){CuInitModel_ca(v_6,ModelStates_6[0],ModelStates_6[1],param_macro(0,PIdx_6) ,param_macro(1,PIdx_6) ,ModelStates_6[8],ModelStates_6[9]);} if(cBoolModel[PIdx_6 +1*SMemMat.N]){CuInitModel_cad(v_6,ModelStates_6[2],ModelStates_6[9],ModelStates_6[8]);} if(cBoolModel[PIdx_6 +2*SMemMat.N]){CuInitModel_kca(v_6,ModelStates_6[3],param_macro(2,PIdx_6) ,param_macro(3,PIdx_6) ,param_macro(4,PIdx_6) ,param_macro(5,PIdx_6) ,ModelStates_6[8]);} if(cBoolModel[PIdx_6 +3*SMemMat.N]){CuInitModel_km(v_6,ModelStates_6[4],param_macro(6,PIdx_6) ,param_macro(7,PIdx_6) ,param_macro(8,PIdx_6) ,param_macro(9,PIdx_6) ,param_macro(10,PIdx_6) );} if(cBoolModel[PIdx_6 +4*SMemMat.N]){CuInitModel_kv(v_6,ModelStates_6[5],param_macro(11,PIdx_6) ,param_macro(12,PIdx_6) ,param_macro(13,PIdx_6) ,param_macro(14,PIdx_6) ,param_macro(15,PIdx_6) );} if(cBoolModel[PIdx_6 +5*SMemMat.N]){CuInitModel_na(v_6,ModelStates_6[6],ModelStates_6[7],param_macro(16,PIdx_6) ,param_macro(17,PIdx_6) ,param_macro(18,PIdx_6) ,param_macro(19,PIdx_6) ,param_macro(20,PIdx_6) ,param_macro(21,PIdx_6) ,param_macro(22,PIdx_6) ,param_macro(23,PIdx_6) ,param_macro(24,PIdx_6) ,param_macro(25,PIdx_6) ,param_macro(26,PIdx_6) ,param_macro(27,PIdx_6) );} if(cBoolModel[PIdx_6 +6*SMemMat.N]){CuInitModel_pas(v_6,param_macro(28,PIdx_6) ,param_macro(29,PIdx_6) );}  if(cBoolModel[PIdx_7 +0*SMemMat.N]){CuInitModel_ca(v_7,ModelStates_7[0],ModelStates_7[1],param_macro(0,PIdx_7) ,param_macro(1,PIdx_7) ,ModelStates_7[8],ModelStates_7[9]);} if(cBoolModel[PIdx_7 +1*SMemMat.N]){CuInitModel_cad(v_7,ModelStates_7[2],ModelStates_7[9],ModelStates_7[8]);} if(cBoolModel[PIdx_7 +2*SMemMat.N]){CuInitModel_kca(v_7,ModelStates_7[3],param_macro(2,PIdx_7) ,param_macro(3,PIdx_7) ,param_macro(4,PIdx_7) ,param_macro(5,PIdx_7) ,ModelStates_7[8]);} if(cBoolModel[PIdx_7 +3*SMemMat.N]){CuInitModel_km(v_7,ModelStates_7[4],param_macro(6,PIdx_7) ,param_macro(7,PIdx_7) ,param_macro(8,PIdx_7) ,param_macro(9,PIdx_7) ,param_macro(10,PIdx_7) );} if(cBoolModel[PIdx_7 +4*SMemMat.N]){CuInitModel_kv(v_7,ModelStates_7[5],param_macro(11,PIdx_7) ,param_macro(12,PIdx_7) ,param_macro(13,PIdx_7) ,param_macro(14,PIdx_7) ,param_macro(15,PIdx_7) );} if(cBoolModel[PIdx_7 +5*SMemMat.N]){CuInitModel_na(v_7,ModelStates_7[6],ModelStates_7[7],param_macro(16,PIdx_7) ,param_macro(17,PIdx_7) ,param_macro(18,PIdx_7) ,param_macro(19,PIdx_7) ,param_macro(20,PIdx_7) ,param_macro(21,PIdx_7) ,param_macro(22,PIdx_7) ,param_macro(23,PIdx_7) ,param_macro(24,PIdx_7) ,param_macro(25,PIdx_7) ,param_macro(26,PIdx_7) ,param_macro(27,PIdx_7) );} if(cBoolModel[PIdx_7 +6*SMemMat.N]){CuInitModel_pas(v_7,param_macro(28,PIdx_7) ,param_macro(29,PIdx_7) );}  if(cBoolModel[PIdx_8 +0*SMemMat.N]){CuInitModel_ca(v_8,ModelStates_8[0],ModelStates_8[1],param_macro(0,PIdx_8) ,param_macro(1,PIdx_8) ,ModelStates_8[8],ModelStates_8[9]);} if(cBoolModel[PIdx_8 +1*SMemMat.N]){CuInitModel_cad(v_8,ModelStates_8[2],ModelStates_8[9],ModelStates_8[8]);} if(cBoolModel[PIdx_8 +2*SMemMat.N]){CuInitModel_kca(v_8,ModelStates_8[3],param_macro(2,PIdx_8) ,param_macro(3,PIdx_8) ,param_macro(4,PIdx_8) ,param_macro(5,PIdx_8) ,ModelStates_8[8]);} if(cBoolModel[PIdx_8 +3*SMemMat.N]){CuInitModel_km(v_8,ModelStates_8[4],param_macro(6,PIdx_8) ,param_macro(7,PIdx_8) ,param_macro(8,PIdx_8) ,param_macro(9,PIdx_8) ,param_macro(10,PIdx_8) );} if(cBoolModel[PIdx_8 +4*SMemMat.N]){CuInitModel_kv(v_8,ModelStates_8[5],param_macro(11,PIdx_8) ,param_macro(12,PIdx_8) ,param_macro(13,PIdx_8) ,param_macro(14,PIdx_8) ,param_macro(15,PIdx_8) );} if(cBoolModel[PIdx_8 +5*SMemMat.N]){CuInitModel_na(v_8,ModelStates_8[6],ModelStates_8[7],param_macro(16,PIdx_8) ,param_macro(17,PIdx_8) ,param_macro(18,PIdx_8) ,param_macro(19,PIdx_8) ,param_macro(20,PIdx_8) ,param_macro(21,PIdx_8) ,param_macro(22,PIdx_8) ,param_macro(23,PIdx_8) ,param_macro(24,PIdx_8) ,param_macro(25,PIdx_8) ,param_macro(26,PIdx_8) ,param_macro(27,PIdx_8) );} if(cBoolModel[PIdx_8 +6*SMemMat.N]){CuInitModel_pas(v_8,param_macro(28,PIdx_8) ,param_macro(29,PIdx_8) );}  if(cBoolModel[PIdx_9 +0*SMemMat.N]){CuInitModel_ca(v_9,ModelStates_9[0],ModelStates_9[1],param_macro(0,PIdx_9) ,param_macro(1,PIdx_9) ,ModelStates_9[8],ModelStates_9[9]);} if(cBoolModel[PIdx_9 +1*SMemMat.N]){CuInitModel_cad(v_9,ModelStates_9[2],ModelStates_9[9],ModelStates_9[8]);} if(cBoolModel[PIdx_9 +2*SMemMat.N]){CuInitModel_kca(v_9,ModelStates_9[3],param_macro(2,PIdx_9) ,param_macro(3,PIdx_9) ,param_macro(4,PIdx_9) ,param_macro(5,PIdx_9) ,ModelStates_9[8]);} if(cBoolModel[PIdx_9 +3*SMemMat.N]){CuInitModel_km(v_9,ModelStates_9[4],param_macro(6,PIdx_9) ,param_macro(7,PIdx_9) ,param_macro(8,PIdx_9) ,param_macro(9,PIdx_9) ,param_macro(10,PIdx_9) );} if(cBoolModel[PIdx_9 +4*SMemMat.N]){CuInitModel_kv(v_9,ModelStates_9[5],param_macro(11,PIdx_9) ,param_macro(12,PIdx_9) ,param_macro(13,PIdx_9) ,param_macro(14,PIdx_9) ,param_macro(15,PIdx_9) );} if(cBoolModel[PIdx_9 +5*SMemMat.N]){CuInitModel_na(v_9,ModelStates_9[6],ModelStates_9[7],param_macro(16,PIdx_9) ,param_macro(17,PIdx_9) ,param_macro(18,PIdx_9) ,param_macro(19,PIdx_9) ,param_macro(20,PIdx_9) ,param_macro(21,PIdx_9) ,param_macro(22,PIdx_9) ,param_macro(23,PIdx_9) ,param_macro(24,PIdx_9) ,param_macro(25,PIdx_9) ,param_macro(26,PIdx_9) ,param_macro(27,PIdx_9) );} if(cBoolModel[PIdx_9 +6*SMemMat.N]){CuInitModel_pas(v_9,param_macro(28,PIdx_9) ,param_macro(29,PIdx_9) );}  if(cBoolModel[PIdx_10 +0*SMemMat.N]){CuInitModel_ca(v_10,ModelStates_10[0],ModelStates_10[1],param_macro(0,PIdx_10) ,param_macro(1,PIdx_10) ,ModelStates_10[8],ModelStates_10[9]);} if(cBoolModel[PIdx_10 +1*SMemMat.N]){CuInitModel_cad(v_10,ModelStates_10[2],ModelStates_10[9],ModelStates_10[8]);} if(cBoolModel[PIdx_10 +2*SMemMat.N]){CuInitModel_kca(v_10,ModelStates_10[3],param_macro(2,PIdx_10) ,param_macro(3,PIdx_10) ,param_macro(4,PIdx_10) ,param_macro(5,PIdx_10) ,ModelStates_10[8]);} if(cBoolModel[PIdx_10 +3*SMemMat.N]){CuInitModel_km(v_10,ModelStates_10[4],param_macro(6,PIdx_10) ,param_macro(7,PIdx_10) ,param_macro(8,PIdx_10) ,param_macro(9,PIdx_10) ,param_macro(10,PIdx_10) );} if(cBoolModel[PIdx_10 +4*SMemMat.N]){CuInitModel_kv(v_10,ModelStates_10[5],param_macro(11,PIdx_10) ,param_macro(12,PIdx_10) ,param_macro(13,PIdx_10) ,param_macro(14,PIdx_10) ,param_macro(15,PIdx_10) );} if(cBoolModel[PIdx_10 +5*SMemMat.N]){CuInitModel_na(v_10,ModelStates_10[6],ModelStates_10[7],param_macro(16,PIdx_10) ,param_macro(17,PIdx_10) ,param_macro(18,PIdx_10) ,param_macro(19,PIdx_10) ,param_macro(20,PIdx_10) ,param_macro(21,PIdx_10) ,param_macro(22,PIdx_10) ,param_macro(23,PIdx_10) ,param_macro(24,PIdx_10) ,param_macro(25,PIdx_10) ,param_macro(26,PIdx_10) ,param_macro(27,PIdx_10) );} if(cBoolModel[PIdx_10 +6*SMemMat.N]){CuInitModel_pas(v_10,param_macro(28,PIdx_10) ,param_macro(29,PIdx_10) );}  if(cBoolModel[PIdx_11 +0*SMemMat.N]){CuInitModel_ca(v_11,ModelStates_11[0],ModelStates_11[1],param_macro(0,PIdx_11) ,param_macro(1,PIdx_11) ,ModelStates_11[8],ModelStates_11[9]);} if(cBoolModel[PIdx_11 +1*SMemMat.N]){CuInitModel_cad(v_11,ModelStates_11[2],ModelStates_11[9],ModelStates_11[8]);} if(cBoolModel[PIdx_11 +2*SMemMat.N]){CuInitModel_kca(v_11,ModelStates_11[3],param_macro(2,PIdx_11) ,param_macro(3,PIdx_11) ,param_macro(4,PIdx_11) ,param_macro(5,PIdx_11) ,ModelStates_11[8]);} if(cBoolModel[PIdx_11 +3*SMemMat.N]){CuInitModel_km(v_11,ModelStates_11[4],param_macro(6,PIdx_11) ,param_macro(7,PIdx_11) ,param_macro(8,PIdx_11) ,param_macro(9,PIdx_11) ,param_macro(10,PIdx_11) );} if(cBoolModel[PIdx_11 +4*SMemMat.N]){CuInitModel_kv(v_11,ModelStates_11[5],param_macro(11,PIdx_11) ,param_macro(12,PIdx_11) ,param_macro(13,PIdx_11) ,param_macro(14,PIdx_11) ,param_macro(15,PIdx_11) );} if(cBoolModel[PIdx_11 +5*SMemMat.N]){CuInitModel_na(v_11,ModelStates_11[6],ModelStates_11[7],param_macro(16,PIdx_11) ,param_macro(17,PIdx_11) ,param_macro(18,PIdx_11) ,param_macro(19,PIdx_11) ,param_macro(20,PIdx_11) ,param_macro(21,PIdx_11) ,param_macro(22,PIdx_11) ,param_macro(23,PIdx_11) ,param_macro(24,PIdx_11) ,param_macro(25,PIdx_11) ,param_macro(26,PIdx_11) ,param_macro(27,PIdx_11) );} if(cBoolModel[PIdx_11 +6*SMemMat.N]){CuInitModel_pas(v_11,param_macro(28,PIdx_11) ,param_macro(29,PIdx_11) );}  if(cBoolModel[PIdx_12 +0*SMemMat.N]){CuInitModel_ca(v_12,ModelStates_12[0],ModelStates_12[1],param_macro(0,PIdx_12) ,param_macro(1,PIdx_12) ,ModelStates_12[8],ModelStates_12[9]);} if(cBoolModel[PIdx_12 +1*SMemMat.N]){CuInitModel_cad(v_12,ModelStates_12[2],ModelStates_12[9],ModelStates_12[8]);} if(cBoolModel[PIdx_12 +2*SMemMat.N]){CuInitModel_kca(v_12,ModelStates_12[3],param_macro(2,PIdx_12) ,param_macro(3,PIdx_12) ,param_macro(4,PIdx_12) ,param_macro(5,PIdx_12) ,ModelStates_12[8]);} if(cBoolModel[PIdx_12 +3*SMemMat.N]){CuInitModel_km(v_12,ModelStates_12[4],param_macro(6,PIdx_12) ,param_macro(7,PIdx_12) ,param_macro(8,PIdx_12) ,param_macro(9,PIdx_12) ,param_macro(10,PIdx_12) );} if(cBoolModel[PIdx_12 +4*SMemMat.N]){CuInitModel_kv(v_12,ModelStates_12[5],param_macro(11,PIdx_12) ,param_macro(12,PIdx_12) ,param_macro(13,PIdx_12) ,param_macro(14,PIdx_12) ,param_macro(15,PIdx_12) );} if(cBoolModel[PIdx_12 +5*SMemMat.N]){CuInitModel_na(v_12,ModelStates_12[6],ModelStates_12[7],param_macro(16,PIdx_12) ,param_macro(17,PIdx_12) ,param_macro(18,PIdx_12) ,param_macro(19,PIdx_12) ,param_macro(20,PIdx_12) ,param_macro(21,PIdx_12) ,param_macro(22,PIdx_12) ,param_macro(23,PIdx_12) ,param_macro(24,PIdx_12) ,param_macro(25,PIdx_12) ,param_macro(26,PIdx_12) ,param_macro(27,PIdx_12) );} if(cBoolModel[PIdx_12 +6*SMemMat.N]){CuInitModel_pas(v_12,param_macro(28,PIdx_12) ,param_macro(29,PIdx_12) );}  if(cBoolModel[PIdx_13 +0*SMemMat.N]){CuInitModel_ca(v_13,ModelStates_13[0],ModelStates_13[1],param_macro(0,PIdx_13) ,param_macro(1,PIdx_13) ,ModelStates_13[8],ModelStates_13[9]);} if(cBoolModel[PIdx_13 +1*SMemMat.N]){CuInitModel_cad(v_13,ModelStates_13[2],ModelStates_13[9],ModelStates_13[8]);} if(cBoolModel[PIdx_13 +2*SMemMat.N]){CuInitModel_kca(v_13,ModelStates_13[3],param_macro(2,PIdx_13) ,param_macro(3,PIdx_13) ,param_macro(4,PIdx_13) ,param_macro(5,PIdx_13) ,ModelStates_13[8]);} if(cBoolModel[PIdx_13 +3*SMemMat.N]){CuInitModel_km(v_13,ModelStates_13[4],param_macro(6,PIdx_13) ,param_macro(7,PIdx_13) ,param_macro(8,PIdx_13) ,param_macro(9,PIdx_13) ,param_macro(10,PIdx_13) );} if(cBoolModel[PIdx_13 +4*SMemMat.N]){CuInitModel_kv(v_13,ModelStates_13[5],param_macro(11,PIdx_13) ,param_macro(12,PIdx_13) ,param_macro(13,PIdx_13) ,param_macro(14,PIdx_13) ,param_macro(15,PIdx_13) );} if(cBoolModel[PIdx_13 +5*SMemMat.N]){CuInitModel_na(v_13,ModelStates_13[6],ModelStates_13[7],param_macro(16,PIdx_13) ,param_macro(17,PIdx_13) ,param_macro(18,PIdx_13) ,param_macro(19,PIdx_13) ,param_macro(20,PIdx_13) ,param_macro(21,PIdx_13) ,param_macro(22,PIdx_13) ,param_macro(23,PIdx_13) ,param_macro(24,PIdx_13) ,param_macro(25,PIdx_13) ,param_macro(26,PIdx_13) ,param_macro(27,PIdx_13) );} if(cBoolModel[PIdx_13 +6*SMemMat.N]){CuInitModel_pas(v_13,param_macro(28,PIdx_13) ,param_macro(29,PIdx_13) );}
#define THISCOMMANDHERE24(VARILP) parentIndex_ ## VARILP =SMemMat.N-cKs[SMemMat.N-PIdx_ ## VARILP ];
	parentIndex_1 =SMemMat.N-cKs[SMemMat.N-PIdx_1 ];parentIndex_2 =SMemMat.N-cKs[SMemMat.N-PIdx_2 ];parentIndex_3 =SMemMat.N-cKs[SMemMat.N-PIdx_3 ];parentIndex_4 =SMemMat.N-cKs[SMemMat.N-PIdx_4 ];parentIndex_5 =SMemMat.N-cKs[SMemMat.N-PIdx_5 ];parentIndex_6 =SMemMat.N-cKs[SMemMat.N-PIdx_6 ];parentIndex_7 =SMemMat.N-cKs[SMemMat.N-PIdx_7 ];parentIndex_8 =SMemMat.N-cKs[SMemMat.N-PIdx_8 ];parentIndex_9 =SMemMat.N-cKs[SMemMat.N-PIdx_9 ];parentIndex_10 =SMemMat.N-cKs[SMemMat.N-PIdx_10 ];parentIndex_11 =SMemMat.N-cKs[SMemMat.N-PIdx_11 ];parentIndex_12 =SMemMat.N-cKs[SMemMat.N-PIdx_12 ];parentIndex_13 =SMemMat.N-cKs[SMemMat.N-PIdx_13 ];
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
	MYSECONDFTYPE rhs_1 ,D_1; MYFTYPE gModel_1 ,StimCurrent_1;MYSECONDFTYPE rhs_2 ,D_2; MYFTYPE gModel_2 ,StimCurrent_2;MYSECONDFTYPE rhs_3 ,D_3; MYFTYPE gModel_3 ,StimCurrent_3;MYSECONDFTYPE rhs_4 ,D_4; MYFTYPE gModel_4 ,StimCurrent_4;MYSECONDFTYPE rhs_5 ,D_5; MYFTYPE gModel_5 ,StimCurrent_5;MYSECONDFTYPE rhs_6 ,D_6; MYFTYPE gModel_6 ,StimCurrent_6;MYSECONDFTYPE rhs_7 ,D_7; MYFTYPE gModel_7 ,StimCurrent_7;MYSECONDFTYPE rhs_8 ,D_8; MYFTYPE gModel_8 ,StimCurrent_8;MYSECONDFTYPE rhs_9 ,D_9; MYFTYPE gModel_9 ,StimCurrent_9;MYSECONDFTYPE rhs_10 ,D_10; MYFTYPE gModel_10 ,StimCurrent_10;MYSECONDFTYPE rhs_11 ,D_11; MYFTYPE gModel_11 ,StimCurrent_11;MYSECONDFTYPE rhs_12 ,D_12; MYFTYPE gModel_12 ,StimCurrent_12;MYSECONDFTYPE rhs_13 ,D_13; MYFTYPE gModel_13 ,StimCurrent_13;

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
	rhs_1 =0; D_1 =0; sumCurrents_1=0; sumConductivity_1=0; sumCurrentsDv_1=0; sumConductivityDv_1=0;StimCurrent_1 =0;rhs_2 =0; D_2 =0; sumCurrents_2=0; sumConductivity_2=0; sumCurrentsDv_2=0; sumConductivityDv_2=0;StimCurrent_2 =0;rhs_3 =0; D_3 =0; sumCurrents_3=0; sumConductivity_3=0; sumCurrentsDv_3=0; sumConductivityDv_3=0;StimCurrent_3 =0;rhs_4 =0; D_4 =0; sumCurrents_4=0; sumConductivity_4=0; sumCurrentsDv_4=0; sumConductivityDv_4=0;StimCurrent_4 =0;rhs_5 =0; D_5 =0; sumCurrents_5=0; sumConductivity_5=0; sumCurrentsDv_5=0; sumConductivityDv_5=0;StimCurrent_5 =0;rhs_6 =0; D_6 =0; sumCurrents_6=0; sumConductivity_6=0; sumCurrentsDv_6=0; sumConductivityDv_6=0;StimCurrent_6 =0;rhs_7 =0; D_7 =0; sumCurrents_7=0; sumConductivity_7=0; sumCurrentsDv_7=0; sumConductivityDv_7=0;StimCurrent_7 =0;rhs_8 =0; D_8 =0; sumCurrents_8=0; sumConductivity_8=0; sumCurrentsDv_8=0; sumConductivityDv_8=0;StimCurrent_8 =0;rhs_9 =0; D_9 =0; sumCurrents_9=0; sumConductivity_9=0; sumCurrentsDv_9=0; sumConductivityDv_9=0;StimCurrent_9 =0;rhs_10 =0; D_10 =0; sumCurrents_10=0; sumConductivity_10=0; sumCurrentsDv_10=0; sumConductivityDv_10=0;StimCurrent_10 =0;rhs_11 =0; D_11 =0; sumCurrents_11=0; sumConductivity_11=0; sumCurrentsDv_11=0; sumConductivityDv_11=0;StimCurrent_11 =0;rhs_12 =0; D_12 =0; sumCurrents_12=0; sumConductivity_12=0; sumCurrentsDv_12=0; sumConductivityDv_12=0;StimCurrent_12 =0;rhs_13 =0; D_13 =0; sumCurrents_13=0; sumConductivity_13=0; sumCurrentsDv_13=0; sumConductivityDv_13=0;StimCurrent_13 =0;
		// Before matrix
		// if(t>=stimDel && t<stimDel+stimDur && PIdx_3 == stimLoc){StimCurrent_3 = 100*stimAmp/stimArea;}
#ifndef STIMFROMFILE
    #define THISCOMMANDHERE27(VARILP) if(t>=stimDel && t<stimDel+stimDur && PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP  = 100*stimAmp/stimArea;}
	if(t>=stimDel && t<stimDel+stimDur && PIdx_1  == stimLoc){StimCurrent_1  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_2  == stimLoc){StimCurrent_2  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_3  == stimLoc){StimCurrent_3  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_4  == stimLoc){StimCurrent_4  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_5  == stimLoc){StimCurrent_5  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_6  == stimLoc){StimCurrent_6  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_7  == stimLoc){StimCurrent_7  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_8  == stimLoc){StimCurrent_8  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_9  == stimLoc){StimCurrent_9  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_10  == stimLoc){StimCurrent_10  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_11  == stimLoc){StimCurrent_11  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_12  == stimLoc){StimCurrent_12  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_13  == stimLoc){StimCurrent_13  = 100*stimAmp/stimArea;}
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
    
    #define THISCOMMANDHERE28(VARILP) if(PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP = 100*amps[i%WARPSIZE]/stimArea;}
	if(PIdx_1  == stimLoc){StimCurrent_1 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_2  == stimLoc){StimCurrent_2 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_3  == stimLoc){StimCurrent_3 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_4  == stimLoc){StimCurrent_4 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_5  == stimLoc){StimCurrent_5 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_6  == stimLoc){StimCurrent_6 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_7  == stimLoc){StimCurrent_7 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_8  == stimLoc){StimCurrent_8 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_9  == stimLoc){StimCurrent_9 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_10  == stimLoc){StimCurrent_10 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_11  == stimLoc){StimCurrent_11 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_12  == stimLoc){StimCurrent_12 = 100*amps[i%WARPSIZE]/stimArea;}if(PIdx_13  == stimLoc){StimCurrent_13 = 100*amps[i%WARPSIZE]/stimArea;}
#endif // STIMFROMFILE
	 if(cBoolModel[PIdx_1 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,ModelStates_1[0],ModelStates_1[1],param_macro(0,PIdx_1) ,param_macro(1,PIdx_1) ,ModelStates_1[8],ModelStates_1[9]);} if(cBoolModel[PIdx_1 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(cBoolModel[PIdx_1 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,ModelStates_1[3],param_macro(2,PIdx_1) ,param_macro(3,PIdx_1) ,param_macro(4,PIdx_1) ,param_macro(5,PIdx_1) ,ModelStates_1[8]);} if(cBoolModel[PIdx_1 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,ModelStates_1[4],param_macro(6,PIdx_1) ,param_macro(7,PIdx_1) ,param_macro(8,PIdx_1) ,param_macro(9,PIdx_1) ,param_macro(10,PIdx_1) );} if(cBoolModel[PIdx_1 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,ModelStates_1[5],param_macro(11,PIdx_1) ,param_macro(12,PIdx_1) ,param_macro(13,PIdx_1) ,param_macro(14,PIdx_1) ,param_macro(15,PIdx_1) );} if(cBoolModel[PIdx_1 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,ModelStates_1[6],ModelStates_1[7],param_macro(16,PIdx_1) ,param_macro(17,PIdx_1) ,param_macro(18,PIdx_1) ,param_macro(19,PIdx_1) ,param_macro(20,PIdx_1) ,param_macro(21,PIdx_1) ,param_macro(22,PIdx_1) ,param_macro(23,PIdx_1) ,param_macro(24,PIdx_1) ,param_macro(25,PIdx_1) ,param_macro(26,PIdx_1) ,param_macro(27,PIdx_1) );} if(cBoolModel[PIdx_1 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_1 , sumConductivityDv_1 ,v_1 +0.001,param_macro(28,PIdx_1) ,param_macro(29,PIdx_1) );} if(cBoolModel[PIdx_2 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,ModelStates_2[0],ModelStates_2[1],param_macro(0,PIdx_2) ,param_macro(1,PIdx_2) ,ModelStates_2[8],ModelStates_2[9]);} if(cBoolModel[PIdx_2 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(cBoolModel[PIdx_2 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,ModelStates_2[3],param_macro(2,PIdx_2) ,param_macro(3,PIdx_2) ,param_macro(4,PIdx_2) ,param_macro(5,PIdx_2) ,ModelStates_2[8]);} if(cBoolModel[PIdx_2 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,ModelStates_2[4],param_macro(6,PIdx_2) ,param_macro(7,PIdx_2) ,param_macro(8,PIdx_2) ,param_macro(9,PIdx_2) ,param_macro(10,PIdx_2) );} if(cBoolModel[PIdx_2 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,ModelStates_2[5],param_macro(11,PIdx_2) ,param_macro(12,PIdx_2) ,param_macro(13,PIdx_2) ,param_macro(14,PIdx_2) ,param_macro(15,PIdx_2) );} if(cBoolModel[PIdx_2 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,ModelStates_2[6],ModelStates_2[7],param_macro(16,PIdx_2) ,param_macro(17,PIdx_2) ,param_macro(18,PIdx_2) ,param_macro(19,PIdx_2) ,param_macro(20,PIdx_2) ,param_macro(21,PIdx_2) ,param_macro(22,PIdx_2) ,param_macro(23,PIdx_2) ,param_macro(24,PIdx_2) ,param_macro(25,PIdx_2) ,param_macro(26,PIdx_2) ,param_macro(27,PIdx_2) );} if(cBoolModel[PIdx_2 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_2 , sumConductivityDv_2 ,v_2 +0.001,param_macro(28,PIdx_2) ,param_macro(29,PIdx_2) );} if(cBoolModel[PIdx_3 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,ModelStates_3[0],ModelStates_3[1],param_macro(0,PIdx_3) ,param_macro(1,PIdx_3) ,ModelStates_3[8],ModelStates_3[9]);} if(cBoolModel[PIdx_3 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(cBoolModel[PIdx_3 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,ModelStates_3[3],param_macro(2,PIdx_3) ,param_macro(3,PIdx_3) ,param_macro(4,PIdx_3) ,param_macro(5,PIdx_3) ,ModelStates_3[8]);} if(cBoolModel[PIdx_3 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,ModelStates_3[4],param_macro(6,PIdx_3) ,param_macro(7,PIdx_3) ,param_macro(8,PIdx_3) ,param_macro(9,PIdx_3) ,param_macro(10,PIdx_3) );} if(cBoolModel[PIdx_3 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,ModelStates_3[5],param_macro(11,PIdx_3) ,param_macro(12,PIdx_3) ,param_macro(13,PIdx_3) ,param_macro(14,PIdx_3) ,param_macro(15,PIdx_3) );} if(cBoolModel[PIdx_3 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,ModelStates_3[6],ModelStates_3[7],param_macro(16,PIdx_3) ,param_macro(17,PIdx_3) ,param_macro(18,PIdx_3) ,param_macro(19,PIdx_3) ,param_macro(20,PIdx_3) ,param_macro(21,PIdx_3) ,param_macro(22,PIdx_3) ,param_macro(23,PIdx_3) ,param_macro(24,PIdx_3) ,param_macro(25,PIdx_3) ,param_macro(26,PIdx_3) ,param_macro(27,PIdx_3) );} if(cBoolModel[PIdx_3 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_3 , sumConductivityDv_3 ,v_3 +0.001,param_macro(28,PIdx_3) ,param_macro(29,PIdx_3) );} if(cBoolModel[PIdx_4 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,ModelStates_4[0],ModelStates_4[1],param_macro(0,PIdx_4) ,param_macro(1,PIdx_4) ,ModelStates_4[8],ModelStates_4[9]);} if(cBoolModel[PIdx_4 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,ModelStates_4[2],ModelStates_4[9],ModelStates_4[8]);} if(cBoolModel[PIdx_4 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,ModelStates_4[3],param_macro(2,PIdx_4) ,param_macro(3,PIdx_4) ,param_macro(4,PIdx_4) ,param_macro(5,PIdx_4) ,ModelStates_4[8]);} if(cBoolModel[PIdx_4 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,ModelStates_4[4],param_macro(6,PIdx_4) ,param_macro(7,PIdx_4) ,param_macro(8,PIdx_4) ,param_macro(9,PIdx_4) ,param_macro(10,PIdx_4) );} if(cBoolModel[PIdx_4 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,ModelStates_4[5],param_macro(11,PIdx_4) ,param_macro(12,PIdx_4) ,param_macro(13,PIdx_4) ,param_macro(14,PIdx_4) ,param_macro(15,PIdx_4) );} if(cBoolModel[PIdx_4 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,ModelStates_4[6],ModelStates_4[7],param_macro(16,PIdx_4) ,param_macro(17,PIdx_4) ,param_macro(18,PIdx_4) ,param_macro(19,PIdx_4) ,param_macro(20,PIdx_4) ,param_macro(21,PIdx_4) ,param_macro(22,PIdx_4) ,param_macro(23,PIdx_4) ,param_macro(24,PIdx_4) ,param_macro(25,PIdx_4) ,param_macro(26,PIdx_4) ,param_macro(27,PIdx_4) );} if(cBoolModel[PIdx_4 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_4 , sumConductivityDv_4 ,v_4 +0.001,param_macro(28,PIdx_4) ,param_macro(29,PIdx_4) );} if(cBoolModel[PIdx_5 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,ModelStates_5[0],ModelStates_5[1],param_macro(0,PIdx_5) ,param_macro(1,PIdx_5) ,ModelStates_5[8],ModelStates_5[9]);} if(cBoolModel[PIdx_5 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,ModelStates_5[2],ModelStates_5[9],ModelStates_5[8]);} if(cBoolModel[PIdx_5 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,ModelStates_5[3],param_macro(2,PIdx_5) ,param_macro(3,PIdx_5) ,param_macro(4,PIdx_5) ,param_macro(5,PIdx_5) ,ModelStates_5[8]);} if(cBoolModel[PIdx_5 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,ModelStates_5[4],param_macro(6,PIdx_5) ,param_macro(7,PIdx_5) ,param_macro(8,PIdx_5) ,param_macro(9,PIdx_5) ,param_macro(10,PIdx_5) );} if(cBoolModel[PIdx_5 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,ModelStates_5[5],param_macro(11,PIdx_5) ,param_macro(12,PIdx_5) ,param_macro(13,PIdx_5) ,param_macro(14,PIdx_5) ,param_macro(15,PIdx_5) );} if(cBoolModel[PIdx_5 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,ModelStates_5[6],ModelStates_5[7],param_macro(16,PIdx_5) ,param_macro(17,PIdx_5) ,param_macro(18,PIdx_5) ,param_macro(19,PIdx_5) ,param_macro(20,PIdx_5) ,param_macro(21,PIdx_5) ,param_macro(22,PIdx_5) ,param_macro(23,PIdx_5) ,param_macro(24,PIdx_5) ,param_macro(25,PIdx_5) ,param_macro(26,PIdx_5) ,param_macro(27,PIdx_5) );} if(cBoolModel[PIdx_5 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_5 , sumConductivityDv_5 ,v_5 +0.001,param_macro(28,PIdx_5) ,param_macro(29,PIdx_5) );} if(cBoolModel[PIdx_6 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,ModelStates_6[0],ModelStates_6[1],param_macro(0,PIdx_6) ,param_macro(1,PIdx_6) ,ModelStates_6[8],ModelStates_6[9]);} if(cBoolModel[PIdx_6 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,ModelStates_6[2],ModelStates_6[9],ModelStates_6[8]);} if(cBoolModel[PIdx_6 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,ModelStates_6[3],param_macro(2,PIdx_6) ,param_macro(3,PIdx_6) ,param_macro(4,PIdx_6) ,param_macro(5,PIdx_6) ,ModelStates_6[8]);} if(cBoolModel[PIdx_6 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,ModelStates_6[4],param_macro(6,PIdx_6) ,param_macro(7,PIdx_6) ,param_macro(8,PIdx_6) ,param_macro(9,PIdx_6) ,param_macro(10,PIdx_6) );} if(cBoolModel[PIdx_6 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,ModelStates_6[5],param_macro(11,PIdx_6) ,param_macro(12,PIdx_6) ,param_macro(13,PIdx_6) ,param_macro(14,PIdx_6) ,param_macro(15,PIdx_6) );} if(cBoolModel[PIdx_6 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,ModelStates_6[6],ModelStates_6[7],param_macro(16,PIdx_6) ,param_macro(17,PIdx_6) ,param_macro(18,PIdx_6) ,param_macro(19,PIdx_6) ,param_macro(20,PIdx_6) ,param_macro(21,PIdx_6) ,param_macro(22,PIdx_6) ,param_macro(23,PIdx_6) ,param_macro(24,PIdx_6) ,param_macro(25,PIdx_6) ,param_macro(26,PIdx_6) ,param_macro(27,PIdx_6) );} if(cBoolModel[PIdx_6 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_6 , sumConductivityDv_6 ,v_6 +0.001,param_macro(28,PIdx_6) ,param_macro(29,PIdx_6) );} if(cBoolModel[PIdx_7 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,ModelStates_7[0],ModelStates_7[1],param_macro(0,PIdx_7) ,param_macro(1,PIdx_7) ,ModelStates_7[8],ModelStates_7[9]);} if(cBoolModel[PIdx_7 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,ModelStates_7[2],ModelStates_7[9],ModelStates_7[8]);} if(cBoolModel[PIdx_7 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,ModelStates_7[3],param_macro(2,PIdx_7) ,param_macro(3,PIdx_7) ,param_macro(4,PIdx_7) ,param_macro(5,PIdx_7) ,ModelStates_7[8]);} if(cBoolModel[PIdx_7 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,ModelStates_7[4],param_macro(6,PIdx_7) ,param_macro(7,PIdx_7) ,param_macro(8,PIdx_7) ,param_macro(9,PIdx_7) ,param_macro(10,PIdx_7) );} if(cBoolModel[PIdx_7 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,ModelStates_7[5],param_macro(11,PIdx_7) ,param_macro(12,PIdx_7) ,param_macro(13,PIdx_7) ,param_macro(14,PIdx_7) ,param_macro(15,PIdx_7) );} if(cBoolModel[PIdx_7 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,ModelStates_7[6],ModelStates_7[7],param_macro(16,PIdx_7) ,param_macro(17,PIdx_7) ,param_macro(18,PIdx_7) ,param_macro(19,PIdx_7) ,param_macro(20,PIdx_7) ,param_macro(21,PIdx_7) ,param_macro(22,PIdx_7) ,param_macro(23,PIdx_7) ,param_macro(24,PIdx_7) ,param_macro(25,PIdx_7) ,param_macro(26,PIdx_7) ,param_macro(27,PIdx_7) );} if(cBoolModel[PIdx_7 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_7 , sumConductivityDv_7 ,v_7 +0.001,param_macro(28,PIdx_7) ,param_macro(29,PIdx_7) );} if(cBoolModel[PIdx_8 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,ModelStates_8[0],ModelStates_8[1],param_macro(0,PIdx_8) ,param_macro(1,PIdx_8) ,ModelStates_8[8],ModelStates_8[9]);} if(cBoolModel[PIdx_8 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,ModelStates_8[2],ModelStates_8[9],ModelStates_8[8]);} if(cBoolModel[PIdx_8 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,ModelStates_8[3],param_macro(2,PIdx_8) ,param_macro(3,PIdx_8) ,param_macro(4,PIdx_8) ,param_macro(5,PIdx_8) ,ModelStates_8[8]);} if(cBoolModel[PIdx_8 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,ModelStates_8[4],param_macro(6,PIdx_8) ,param_macro(7,PIdx_8) ,param_macro(8,PIdx_8) ,param_macro(9,PIdx_8) ,param_macro(10,PIdx_8) );} if(cBoolModel[PIdx_8 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,ModelStates_8[5],param_macro(11,PIdx_8) ,param_macro(12,PIdx_8) ,param_macro(13,PIdx_8) ,param_macro(14,PIdx_8) ,param_macro(15,PIdx_8) );} if(cBoolModel[PIdx_8 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,ModelStates_8[6],ModelStates_8[7],param_macro(16,PIdx_8) ,param_macro(17,PIdx_8) ,param_macro(18,PIdx_8) ,param_macro(19,PIdx_8) ,param_macro(20,PIdx_8) ,param_macro(21,PIdx_8) ,param_macro(22,PIdx_8) ,param_macro(23,PIdx_8) ,param_macro(24,PIdx_8) ,param_macro(25,PIdx_8) ,param_macro(26,PIdx_8) ,param_macro(27,PIdx_8) );} if(cBoolModel[PIdx_8 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_8 , sumConductivityDv_8 ,v_8 +0.001,param_macro(28,PIdx_8) ,param_macro(29,PIdx_8) );} if(cBoolModel[PIdx_9 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,ModelStates_9[0],ModelStates_9[1],param_macro(0,PIdx_9) ,param_macro(1,PIdx_9) ,ModelStates_9[8],ModelStates_9[9]);} if(cBoolModel[PIdx_9 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,ModelStates_9[2],ModelStates_9[9],ModelStates_9[8]);} if(cBoolModel[PIdx_9 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,ModelStates_9[3],param_macro(2,PIdx_9) ,param_macro(3,PIdx_9) ,param_macro(4,PIdx_9) ,param_macro(5,PIdx_9) ,ModelStates_9[8]);} if(cBoolModel[PIdx_9 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,ModelStates_9[4],param_macro(6,PIdx_9) ,param_macro(7,PIdx_9) ,param_macro(8,PIdx_9) ,param_macro(9,PIdx_9) ,param_macro(10,PIdx_9) );} if(cBoolModel[PIdx_9 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,ModelStates_9[5],param_macro(11,PIdx_9) ,param_macro(12,PIdx_9) ,param_macro(13,PIdx_9) ,param_macro(14,PIdx_9) ,param_macro(15,PIdx_9) );} if(cBoolModel[PIdx_9 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,ModelStates_9[6],ModelStates_9[7],param_macro(16,PIdx_9) ,param_macro(17,PIdx_9) ,param_macro(18,PIdx_9) ,param_macro(19,PIdx_9) ,param_macro(20,PIdx_9) ,param_macro(21,PIdx_9) ,param_macro(22,PIdx_9) ,param_macro(23,PIdx_9) ,param_macro(24,PIdx_9) ,param_macro(25,PIdx_9) ,param_macro(26,PIdx_9) ,param_macro(27,PIdx_9) );} if(cBoolModel[PIdx_9 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_9 , sumConductivityDv_9 ,v_9 +0.001,param_macro(28,PIdx_9) ,param_macro(29,PIdx_9) );} if(cBoolModel[PIdx_10 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,ModelStates_10[0],ModelStates_10[1],param_macro(0,PIdx_10) ,param_macro(1,PIdx_10) ,ModelStates_10[8],ModelStates_10[9]);} if(cBoolModel[PIdx_10 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,ModelStates_10[2],ModelStates_10[9],ModelStates_10[8]);} if(cBoolModel[PIdx_10 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,ModelStates_10[3],param_macro(2,PIdx_10) ,param_macro(3,PIdx_10) ,param_macro(4,PIdx_10) ,param_macro(5,PIdx_10) ,ModelStates_10[8]);} if(cBoolModel[PIdx_10 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,ModelStates_10[4],param_macro(6,PIdx_10) ,param_macro(7,PIdx_10) ,param_macro(8,PIdx_10) ,param_macro(9,PIdx_10) ,param_macro(10,PIdx_10) );} if(cBoolModel[PIdx_10 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,ModelStates_10[5],param_macro(11,PIdx_10) ,param_macro(12,PIdx_10) ,param_macro(13,PIdx_10) ,param_macro(14,PIdx_10) ,param_macro(15,PIdx_10) );} if(cBoolModel[PIdx_10 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,ModelStates_10[6],ModelStates_10[7],param_macro(16,PIdx_10) ,param_macro(17,PIdx_10) ,param_macro(18,PIdx_10) ,param_macro(19,PIdx_10) ,param_macro(20,PIdx_10) ,param_macro(21,PIdx_10) ,param_macro(22,PIdx_10) ,param_macro(23,PIdx_10) ,param_macro(24,PIdx_10) ,param_macro(25,PIdx_10) ,param_macro(26,PIdx_10) ,param_macro(27,PIdx_10) );} if(cBoolModel[PIdx_10 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_10 , sumConductivityDv_10 ,v_10 +0.001,param_macro(28,PIdx_10) ,param_macro(29,PIdx_10) );} if(cBoolModel[PIdx_11 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,ModelStates_11[0],ModelStates_11[1],param_macro(0,PIdx_11) ,param_macro(1,PIdx_11) ,ModelStates_11[8],ModelStates_11[9]);} if(cBoolModel[PIdx_11 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,ModelStates_11[2],ModelStates_11[9],ModelStates_11[8]);} if(cBoolModel[PIdx_11 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,ModelStates_11[3],param_macro(2,PIdx_11) ,param_macro(3,PIdx_11) ,param_macro(4,PIdx_11) ,param_macro(5,PIdx_11) ,ModelStates_11[8]);} if(cBoolModel[PIdx_11 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,ModelStates_11[4],param_macro(6,PIdx_11) ,param_macro(7,PIdx_11) ,param_macro(8,PIdx_11) ,param_macro(9,PIdx_11) ,param_macro(10,PIdx_11) );} if(cBoolModel[PIdx_11 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,ModelStates_11[5],param_macro(11,PIdx_11) ,param_macro(12,PIdx_11) ,param_macro(13,PIdx_11) ,param_macro(14,PIdx_11) ,param_macro(15,PIdx_11) );} if(cBoolModel[PIdx_11 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,ModelStates_11[6],ModelStates_11[7],param_macro(16,PIdx_11) ,param_macro(17,PIdx_11) ,param_macro(18,PIdx_11) ,param_macro(19,PIdx_11) ,param_macro(20,PIdx_11) ,param_macro(21,PIdx_11) ,param_macro(22,PIdx_11) ,param_macro(23,PIdx_11) ,param_macro(24,PIdx_11) ,param_macro(25,PIdx_11) ,param_macro(26,PIdx_11) ,param_macro(27,PIdx_11) );} if(cBoolModel[PIdx_11 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_11 , sumConductivityDv_11 ,v_11 +0.001,param_macro(28,PIdx_11) ,param_macro(29,PIdx_11) );} if(cBoolModel[PIdx_12 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,ModelStates_12[0],ModelStates_12[1],param_macro(0,PIdx_12) ,param_macro(1,PIdx_12) ,ModelStates_12[8],ModelStates_12[9]);} if(cBoolModel[PIdx_12 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,ModelStates_12[2],ModelStates_12[9],ModelStates_12[8]);} if(cBoolModel[PIdx_12 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,ModelStates_12[3],param_macro(2,PIdx_12) ,param_macro(3,PIdx_12) ,param_macro(4,PIdx_12) ,param_macro(5,PIdx_12) ,ModelStates_12[8]);} if(cBoolModel[PIdx_12 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,ModelStates_12[4],param_macro(6,PIdx_12) ,param_macro(7,PIdx_12) ,param_macro(8,PIdx_12) ,param_macro(9,PIdx_12) ,param_macro(10,PIdx_12) );} if(cBoolModel[PIdx_12 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,ModelStates_12[5],param_macro(11,PIdx_12) ,param_macro(12,PIdx_12) ,param_macro(13,PIdx_12) ,param_macro(14,PIdx_12) ,param_macro(15,PIdx_12) );} if(cBoolModel[PIdx_12 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,ModelStates_12[6],ModelStates_12[7],param_macro(16,PIdx_12) ,param_macro(17,PIdx_12) ,param_macro(18,PIdx_12) ,param_macro(19,PIdx_12) ,param_macro(20,PIdx_12) ,param_macro(21,PIdx_12) ,param_macro(22,PIdx_12) ,param_macro(23,PIdx_12) ,param_macro(24,PIdx_12) ,param_macro(25,PIdx_12) ,param_macro(26,PIdx_12) ,param_macro(27,PIdx_12) );} if(cBoolModel[PIdx_12 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_12 , sumConductivityDv_12 ,v_12 +0.001,param_macro(28,PIdx_12) ,param_macro(29,PIdx_12) );} if(cBoolModel[PIdx_13 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,ModelStates_13[0],ModelStates_13[1],param_macro(0,PIdx_13) ,param_macro(1,PIdx_13) ,ModelStates_13[8],ModelStates_13[9]);} if(cBoolModel[PIdx_13 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,ModelStates_13[2],ModelStates_13[9],ModelStates_13[8]);} if(cBoolModel[PIdx_13 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,ModelStates_13[3],param_macro(2,PIdx_13) ,param_macro(3,PIdx_13) ,param_macro(4,PIdx_13) ,param_macro(5,PIdx_13) ,ModelStates_13[8]);} if(cBoolModel[PIdx_13 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,ModelStates_13[4],param_macro(6,PIdx_13) ,param_macro(7,PIdx_13) ,param_macro(8,PIdx_13) ,param_macro(9,PIdx_13) ,param_macro(10,PIdx_13) );} if(cBoolModel[PIdx_13 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,ModelStates_13[5],param_macro(11,PIdx_13) ,param_macro(12,PIdx_13) ,param_macro(13,PIdx_13) ,param_macro(14,PIdx_13) ,param_macro(15,PIdx_13) );} if(cBoolModel[PIdx_13 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,ModelStates_13[6],ModelStates_13[7],param_macro(16,PIdx_13) ,param_macro(17,PIdx_13) ,param_macro(18,PIdx_13) ,param_macro(19,PIdx_13) ,param_macro(20,PIdx_13) ,param_macro(21,PIdx_13) ,param_macro(22,PIdx_13) ,param_macro(23,PIdx_13) ,param_macro(24,PIdx_13) ,param_macro(25,PIdx_13) ,param_macro(26,PIdx_13) ,param_macro(27,PIdx_13) );} if(cBoolModel[PIdx_13 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrentsDv_13 , sumConductivityDv_13 ,v_13 +0.001,param_macro(28,PIdx_13) ,param_macro(29,PIdx_13) );}
	 if(cBoolModel[PIdx_1 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_1 , sumConductivity_1,v_1 ,ModelStates_1[0],ModelStates_1[1],param_macro(0,PIdx_1) ,param_macro(1,PIdx_1) ,ModelStates_1[8],ModelStates_1[9]);} if(cBoolModel[PIdx_1 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_1 , sumConductivity_1,v_1 ,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(cBoolModel[PIdx_1 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_1 , sumConductivity_1,v_1 ,ModelStates_1[3],param_macro(2,PIdx_1) ,param_macro(3,PIdx_1) ,param_macro(4,PIdx_1) ,param_macro(5,PIdx_1) ,ModelStates_1[8]);} if(cBoolModel[PIdx_1 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_1 , sumConductivity_1,v_1 ,ModelStates_1[4],param_macro(6,PIdx_1) ,param_macro(7,PIdx_1) ,param_macro(8,PIdx_1) ,param_macro(9,PIdx_1) ,param_macro(10,PIdx_1) );} if(cBoolModel[PIdx_1 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_1 , sumConductivity_1,v_1 ,ModelStates_1[5],param_macro(11,PIdx_1) ,param_macro(12,PIdx_1) ,param_macro(13,PIdx_1) ,param_macro(14,PIdx_1) ,param_macro(15,PIdx_1) );} if(cBoolModel[PIdx_1 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_1 , sumConductivity_1,v_1 ,ModelStates_1[6],ModelStates_1[7],param_macro(16,PIdx_1) ,param_macro(17,PIdx_1) ,param_macro(18,PIdx_1) ,param_macro(19,PIdx_1) ,param_macro(20,PIdx_1) ,param_macro(21,PIdx_1) ,param_macro(22,PIdx_1) ,param_macro(23,PIdx_1) ,param_macro(24,PIdx_1) ,param_macro(25,PIdx_1) ,param_macro(26,PIdx_1) ,param_macro(27,PIdx_1) );} if(cBoolModel[PIdx_1 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_1 , sumConductivity_1,v_1 ,param_macro(28,PIdx_1) ,param_macro(29,PIdx_1) );} if(cBoolModel[PIdx_2 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_2 , sumConductivity_2,v_2 ,ModelStates_2[0],ModelStates_2[1],param_macro(0,PIdx_2) ,param_macro(1,PIdx_2) ,ModelStates_2[8],ModelStates_2[9]);} if(cBoolModel[PIdx_2 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_2 , sumConductivity_2,v_2 ,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(cBoolModel[PIdx_2 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_2 , sumConductivity_2,v_2 ,ModelStates_2[3],param_macro(2,PIdx_2) ,param_macro(3,PIdx_2) ,param_macro(4,PIdx_2) ,param_macro(5,PIdx_2) ,ModelStates_2[8]);} if(cBoolModel[PIdx_2 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_2 , sumConductivity_2,v_2 ,ModelStates_2[4],param_macro(6,PIdx_2) ,param_macro(7,PIdx_2) ,param_macro(8,PIdx_2) ,param_macro(9,PIdx_2) ,param_macro(10,PIdx_2) );} if(cBoolModel[PIdx_2 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_2 , sumConductivity_2,v_2 ,ModelStates_2[5],param_macro(11,PIdx_2) ,param_macro(12,PIdx_2) ,param_macro(13,PIdx_2) ,param_macro(14,PIdx_2) ,param_macro(15,PIdx_2) );} if(cBoolModel[PIdx_2 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_2 , sumConductivity_2,v_2 ,ModelStates_2[6],ModelStates_2[7],param_macro(16,PIdx_2) ,param_macro(17,PIdx_2) ,param_macro(18,PIdx_2) ,param_macro(19,PIdx_2) ,param_macro(20,PIdx_2) ,param_macro(21,PIdx_2) ,param_macro(22,PIdx_2) ,param_macro(23,PIdx_2) ,param_macro(24,PIdx_2) ,param_macro(25,PIdx_2) ,param_macro(26,PIdx_2) ,param_macro(27,PIdx_2) );} if(cBoolModel[PIdx_2 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_2 , sumConductivity_2,v_2 ,param_macro(28,PIdx_2) ,param_macro(29,PIdx_2) );} if(cBoolModel[PIdx_3 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_3 , sumConductivity_3,v_3 ,ModelStates_3[0],ModelStates_3[1],param_macro(0,PIdx_3) ,param_macro(1,PIdx_3) ,ModelStates_3[8],ModelStates_3[9]);} if(cBoolModel[PIdx_3 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_3 , sumConductivity_3,v_3 ,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(cBoolModel[PIdx_3 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_3 , sumConductivity_3,v_3 ,ModelStates_3[3],param_macro(2,PIdx_3) ,param_macro(3,PIdx_3) ,param_macro(4,PIdx_3) ,param_macro(5,PIdx_3) ,ModelStates_3[8]);} if(cBoolModel[PIdx_3 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_3 , sumConductivity_3,v_3 ,ModelStates_3[4],param_macro(6,PIdx_3) ,param_macro(7,PIdx_3) ,param_macro(8,PIdx_3) ,param_macro(9,PIdx_3) ,param_macro(10,PIdx_3) );} if(cBoolModel[PIdx_3 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_3 , sumConductivity_3,v_3 ,ModelStates_3[5],param_macro(11,PIdx_3) ,param_macro(12,PIdx_3) ,param_macro(13,PIdx_3) ,param_macro(14,PIdx_3) ,param_macro(15,PIdx_3) );} if(cBoolModel[PIdx_3 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_3 , sumConductivity_3,v_3 ,ModelStates_3[6],ModelStates_3[7],param_macro(16,PIdx_3) ,param_macro(17,PIdx_3) ,param_macro(18,PIdx_3) ,param_macro(19,PIdx_3) ,param_macro(20,PIdx_3) ,param_macro(21,PIdx_3) ,param_macro(22,PIdx_3) ,param_macro(23,PIdx_3) ,param_macro(24,PIdx_3) ,param_macro(25,PIdx_3) ,param_macro(26,PIdx_3) ,param_macro(27,PIdx_3) );} if(cBoolModel[PIdx_3 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_3 , sumConductivity_3,v_3 ,param_macro(28,PIdx_3) ,param_macro(29,PIdx_3) );} if(cBoolModel[PIdx_4 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_4 , sumConductivity_4,v_4 ,ModelStates_4[0],ModelStates_4[1],param_macro(0,PIdx_4) ,param_macro(1,PIdx_4) ,ModelStates_4[8],ModelStates_4[9]);} if(cBoolModel[PIdx_4 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_4 , sumConductivity_4,v_4 ,ModelStates_4[2],ModelStates_4[9],ModelStates_4[8]);} if(cBoolModel[PIdx_4 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_4 , sumConductivity_4,v_4 ,ModelStates_4[3],param_macro(2,PIdx_4) ,param_macro(3,PIdx_4) ,param_macro(4,PIdx_4) ,param_macro(5,PIdx_4) ,ModelStates_4[8]);} if(cBoolModel[PIdx_4 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_4 , sumConductivity_4,v_4 ,ModelStates_4[4],param_macro(6,PIdx_4) ,param_macro(7,PIdx_4) ,param_macro(8,PIdx_4) ,param_macro(9,PIdx_4) ,param_macro(10,PIdx_4) );} if(cBoolModel[PIdx_4 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_4 , sumConductivity_4,v_4 ,ModelStates_4[5],param_macro(11,PIdx_4) ,param_macro(12,PIdx_4) ,param_macro(13,PIdx_4) ,param_macro(14,PIdx_4) ,param_macro(15,PIdx_4) );} if(cBoolModel[PIdx_4 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_4 , sumConductivity_4,v_4 ,ModelStates_4[6],ModelStates_4[7],param_macro(16,PIdx_4) ,param_macro(17,PIdx_4) ,param_macro(18,PIdx_4) ,param_macro(19,PIdx_4) ,param_macro(20,PIdx_4) ,param_macro(21,PIdx_4) ,param_macro(22,PIdx_4) ,param_macro(23,PIdx_4) ,param_macro(24,PIdx_4) ,param_macro(25,PIdx_4) ,param_macro(26,PIdx_4) ,param_macro(27,PIdx_4) );} if(cBoolModel[PIdx_4 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_4 , sumConductivity_4,v_4 ,param_macro(28,PIdx_4) ,param_macro(29,PIdx_4) );} if(cBoolModel[PIdx_5 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_5 , sumConductivity_5,v_5 ,ModelStates_5[0],ModelStates_5[1],param_macro(0,PIdx_5) ,param_macro(1,PIdx_5) ,ModelStates_5[8],ModelStates_5[9]);} if(cBoolModel[PIdx_5 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_5 , sumConductivity_5,v_5 ,ModelStates_5[2],ModelStates_5[9],ModelStates_5[8]);} if(cBoolModel[PIdx_5 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_5 , sumConductivity_5,v_5 ,ModelStates_5[3],param_macro(2,PIdx_5) ,param_macro(3,PIdx_5) ,param_macro(4,PIdx_5) ,param_macro(5,PIdx_5) ,ModelStates_5[8]);} if(cBoolModel[PIdx_5 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_5 , sumConductivity_5,v_5 ,ModelStates_5[4],param_macro(6,PIdx_5) ,param_macro(7,PIdx_5) ,param_macro(8,PIdx_5) ,param_macro(9,PIdx_5) ,param_macro(10,PIdx_5) );} if(cBoolModel[PIdx_5 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_5 , sumConductivity_5,v_5 ,ModelStates_5[5],param_macro(11,PIdx_5) ,param_macro(12,PIdx_5) ,param_macro(13,PIdx_5) ,param_macro(14,PIdx_5) ,param_macro(15,PIdx_5) );} if(cBoolModel[PIdx_5 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_5 , sumConductivity_5,v_5 ,ModelStates_5[6],ModelStates_5[7],param_macro(16,PIdx_5) ,param_macro(17,PIdx_5) ,param_macro(18,PIdx_5) ,param_macro(19,PIdx_5) ,param_macro(20,PIdx_5) ,param_macro(21,PIdx_5) ,param_macro(22,PIdx_5) ,param_macro(23,PIdx_5) ,param_macro(24,PIdx_5) ,param_macro(25,PIdx_5) ,param_macro(26,PIdx_5) ,param_macro(27,PIdx_5) );} if(cBoolModel[PIdx_5 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_5 , sumConductivity_5,v_5 ,param_macro(28,PIdx_5) ,param_macro(29,PIdx_5) );} if(cBoolModel[PIdx_6 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_6 , sumConductivity_6,v_6 ,ModelStates_6[0],ModelStates_6[1],param_macro(0,PIdx_6) ,param_macro(1,PIdx_6) ,ModelStates_6[8],ModelStates_6[9]);} if(cBoolModel[PIdx_6 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_6 , sumConductivity_6,v_6 ,ModelStates_6[2],ModelStates_6[9],ModelStates_6[8]);} if(cBoolModel[PIdx_6 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_6 , sumConductivity_6,v_6 ,ModelStates_6[3],param_macro(2,PIdx_6) ,param_macro(3,PIdx_6) ,param_macro(4,PIdx_6) ,param_macro(5,PIdx_6) ,ModelStates_6[8]);} if(cBoolModel[PIdx_6 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_6 , sumConductivity_6,v_6 ,ModelStates_6[4],param_macro(6,PIdx_6) ,param_macro(7,PIdx_6) ,param_macro(8,PIdx_6) ,param_macro(9,PIdx_6) ,param_macro(10,PIdx_6) );} if(cBoolModel[PIdx_6 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_6 , sumConductivity_6,v_6 ,ModelStates_6[5],param_macro(11,PIdx_6) ,param_macro(12,PIdx_6) ,param_macro(13,PIdx_6) ,param_macro(14,PIdx_6) ,param_macro(15,PIdx_6) );} if(cBoolModel[PIdx_6 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_6 , sumConductivity_6,v_6 ,ModelStates_6[6],ModelStates_6[7],param_macro(16,PIdx_6) ,param_macro(17,PIdx_6) ,param_macro(18,PIdx_6) ,param_macro(19,PIdx_6) ,param_macro(20,PIdx_6) ,param_macro(21,PIdx_6) ,param_macro(22,PIdx_6) ,param_macro(23,PIdx_6) ,param_macro(24,PIdx_6) ,param_macro(25,PIdx_6) ,param_macro(26,PIdx_6) ,param_macro(27,PIdx_6) );} if(cBoolModel[PIdx_6 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_6 , sumConductivity_6,v_6 ,param_macro(28,PIdx_6) ,param_macro(29,PIdx_6) );} if(cBoolModel[PIdx_7 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_7 , sumConductivity_7,v_7 ,ModelStates_7[0],ModelStates_7[1],param_macro(0,PIdx_7) ,param_macro(1,PIdx_7) ,ModelStates_7[8],ModelStates_7[9]);} if(cBoolModel[PIdx_7 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_7 , sumConductivity_7,v_7 ,ModelStates_7[2],ModelStates_7[9],ModelStates_7[8]);} if(cBoolModel[PIdx_7 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_7 , sumConductivity_7,v_7 ,ModelStates_7[3],param_macro(2,PIdx_7) ,param_macro(3,PIdx_7) ,param_macro(4,PIdx_7) ,param_macro(5,PIdx_7) ,ModelStates_7[8]);} if(cBoolModel[PIdx_7 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_7 , sumConductivity_7,v_7 ,ModelStates_7[4],param_macro(6,PIdx_7) ,param_macro(7,PIdx_7) ,param_macro(8,PIdx_7) ,param_macro(9,PIdx_7) ,param_macro(10,PIdx_7) );} if(cBoolModel[PIdx_7 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_7 , sumConductivity_7,v_7 ,ModelStates_7[5],param_macro(11,PIdx_7) ,param_macro(12,PIdx_7) ,param_macro(13,PIdx_7) ,param_macro(14,PIdx_7) ,param_macro(15,PIdx_7) );} if(cBoolModel[PIdx_7 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_7 , sumConductivity_7,v_7 ,ModelStates_7[6],ModelStates_7[7],param_macro(16,PIdx_7) ,param_macro(17,PIdx_7) ,param_macro(18,PIdx_7) ,param_macro(19,PIdx_7) ,param_macro(20,PIdx_7) ,param_macro(21,PIdx_7) ,param_macro(22,PIdx_7) ,param_macro(23,PIdx_7) ,param_macro(24,PIdx_7) ,param_macro(25,PIdx_7) ,param_macro(26,PIdx_7) ,param_macro(27,PIdx_7) );} if(cBoolModel[PIdx_7 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_7 , sumConductivity_7,v_7 ,param_macro(28,PIdx_7) ,param_macro(29,PIdx_7) );} if(cBoolModel[PIdx_8 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_8 , sumConductivity_8,v_8 ,ModelStates_8[0],ModelStates_8[1],param_macro(0,PIdx_8) ,param_macro(1,PIdx_8) ,ModelStates_8[8],ModelStates_8[9]);} if(cBoolModel[PIdx_8 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_8 , sumConductivity_8,v_8 ,ModelStates_8[2],ModelStates_8[9],ModelStates_8[8]);} if(cBoolModel[PIdx_8 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_8 , sumConductivity_8,v_8 ,ModelStates_8[3],param_macro(2,PIdx_8) ,param_macro(3,PIdx_8) ,param_macro(4,PIdx_8) ,param_macro(5,PIdx_8) ,ModelStates_8[8]);} if(cBoolModel[PIdx_8 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_8 , sumConductivity_8,v_8 ,ModelStates_8[4],param_macro(6,PIdx_8) ,param_macro(7,PIdx_8) ,param_macro(8,PIdx_8) ,param_macro(9,PIdx_8) ,param_macro(10,PIdx_8) );} if(cBoolModel[PIdx_8 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_8 , sumConductivity_8,v_8 ,ModelStates_8[5],param_macro(11,PIdx_8) ,param_macro(12,PIdx_8) ,param_macro(13,PIdx_8) ,param_macro(14,PIdx_8) ,param_macro(15,PIdx_8) );} if(cBoolModel[PIdx_8 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_8 , sumConductivity_8,v_8 ,ModelStates_8[6],ModelStates_8[7],param_macro(16,PIdx_8) ,param_macro(17,PIdx_8) ,param_macro(18,PIdx_8) ,param_macro(19,PIdx_8) ,param_macro(20,PIdx_8) ,param_macro(21,PIdx_8) ,param_macro(22,PIdx_8) ,param_macro(23,PIdx_8) ,param_macro(24,PIdx_8) ,param_macro(25,PIdx_8) ,param_macro(26,PIdx_8) ,param_macro(27,PIdx_8) );} if(cBoolModel[PIdx_8 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_8 , sumConductivity_8,v_8 ,param_macro(28,PIdx_8) ,param_macro(29,PIdx_8) );} if(cBoolModel[PIdx_9 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_9 , sumConductivity_9,v_9 ,ModelStates_9[0],ModelStates_9[1],param_macro(0,PIdx_9) ,param_macro(1,PIdx_9) ,ModelStates_9[8],ModelStates_9[9]);} if(cBoolModel[PIdx_9 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_9 , sumConductivity_9,v_9 ,ModelStates_9[2],ModelStates_9[9],ModelStates_9[8]);} if(cBoolModel[PIdx_9 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_9 , sumConductivity_9,v_9 ,ModelStates_9[3],param_macro(2,PIdx_9) ,param_macro(3,PIdx_9) ,param_macro(4,PIdx_9) ,param_macro(5,PIdx_9) ,ModelStates_9[8]);} if(cBoolModel[PIdx_9 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_9 , sumConductivity_9,v_9 ,ModelStates_9[4],param_macro(6,PIdx_9) ,param_macro(7,PIdx_9) ,param_macro(8,PIdx_9) ,param_macro(9,PIdx_9) ,param_macro(10,PIdx_9) );} if(cBoolModel[PIdx_9 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_9 , sumConductivity_9,v_9 ,ModelStates_9[5],param_macro(11,PIdx_9) ,param_macro(12,PIdx_9) ,param_macro(13,PIdx_9) ,param_macro(14,PIdx_9) ,param_macro(15,PIdx_9) );} if(cBoolModel[PIdx_9 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_9 , sumConductivity_9,v_9 ,ModelStates_9[6],ModelStates_9[7],param_macro(16,PIdx_9) ,param_macro(17,PIdx_9) ,param_macro(18,PIdx_9) ,param_macro(19,PIdx_9) ,param_macro(20,PIdx_9) ,param_macro(21,PIdx_9) ,param_macro(22,PIdx_9) ,param_macro(23,PIdx_9) ,param_macro(24,PIdx_9) ,param_macro(25,PIdx_9) ,param_macro(26,PIdx_9) ,param_macro(27,PIdx_9) );} if(cBoolModel[PIdx_9 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_9 , sumConductivity_9,v_9 ,param_macro(28,PIdx_9) ,param_macro(29,PIdx_9) );} if(cBoolModel[PIdx_10 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_10 , sumConductivity_10,v_10 ,ModelStates_10[0],ModelStates_10[1],param_macro(0,PIdx_10) ,param_macro(1,PIdx_10) ,ModelStates_10[8],ModelStates_10[9]);} if(cBoolModel[PIdx_10 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_10 , sumConductivity_10,v_10 ,ModelStates_10[2],ModelStates_10[9],ModelStates_10[8]);} if(cBoolModel[PIdx_10 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_10 , sumConductivity_10,v_10 ,ModelStates_10[3],param_macro(2,PIdx_10) ,param_macro(3,PIdx_10) ,param_macro(4,PIdx_10) ,param_macro(5,PIdx_10) ,ModelStates_10[8]);} if(cBoolModel[PIdx_10 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_10 , sumConductivity_10,v_10 ,ModelStates_10[4],param_macro(6,PIdx_10) ,param_macro(7,PIdx_10) ,param_macro(8,PIdx_10) ,param_macro(9,PIdx_10) ,param_macro(10,PIdx_10) );} if(cBoolModel[PIdx_10 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_10 , sumConductivity_10,v_10 ,ModelStates_10[5],param_macro(11,PIdx_10) ,param_macro(12,PIdx_10) ,param_macro(13,PIdx_10) ,param_macro(14,PIdx_10) ,param_macro(15,PIdx_10) );} if(cBoolModel[PIdx_10 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_10 , sumConductivity_10,v_10 ,ModelStates_10[6],ModelStates_10[7],param_macro(16,PIdx_10) ,param_macro(17,PIdx_10) ,param_macro(18,PIdx_10) ,param_macro(19,PIdx_10) ,param_macro(20,PIdx_10) ,param_macro(21,PIdx_10) ,param_macro(22,PIdx_10) ,param_macro(23,PIdx_10) ,param_macro(24,PIdx_10) ,param_macro(25,PIdx_10) ,param_macro(26,PIdx_10) ,param_macro(27,PIdx_10) );} if(cBoolModel[PIdx_10 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_10 , sumConductivity_10,v_10 ,param_macro(28,PIdx_10) ,param_macro(29,PIdx_10) );} if(cBoolModel[PIdx_11 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_11 , sumConductivity_11,v_11 ,ModelStates_11[0],ModelStates_11[1],param_macro(0,PIdx_11) ,param_macro(1,PIdx_11) ,ModelStates_11[8],ModelStates_11[9]);} if(cBoolModel[PIdx_11 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_11 , sumConductivity_11,v_11 ,ModelStates_11[2],ModelStates_11[9],ModelStates_11[8]);} if(cBoolModel[PIdx_11 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_11 , sumConductivity_11,v_11 ,ModelStates_11[3],param_macro(2,PIdx_11) ,param_macro(3,PIdx_11) ,param_macro(4,PIdx_11) ,param_macro(5,PIdx_11) ,ModelStates_11[8]);} if(cBoolModel[PIdx_11 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_11 , sumConductivity_11,v_11 ,ModelStates_11[4],param_macro(6,PIdx_11) ,param_macro(7,PIdx_11) ,param_macro(8,PIdx_11) ,param_macro(9,PIdx_11) ,param_macro(10,PIdx_11) );} if(cBoolModel[PIdx_11 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_11 , sumConductivity_11,v_11 ,ModelStates_11[5],param_macro(11,PIdx_11) ,param_macro(12,PIdx_11) ,param_macro(13,PIdx_11) ,param_macro(14,PIdx_11) ,param_macro(15,PIdx_11) );} if(cBoolModel[PIdx_11 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_11 , sumConductivity_11,v_11 ,ModelStates_11[6],ModelStates_11[7],param_macro(16,PIdx_11) ,param_macro(17,PIdx_11) ,param_macro(18,PIdx_11) ,param_macro(19,PIdx_11) ,param_macro(20,PIdx_11) ,param_macro(21,PIdx_11) ,param_macro(22,PIdx_11) ,param_macro(23,PIdx_11) ,param_macro(24,PIdx_11) ,param_macro(25,PIdx_11) ,param_macro(26,PIdx_11) ,param_macro(27,PIdx_11) );} if(cBoolModel[PIdx_11 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_11 , sumConductivity_11,v_11 ,param_macro(28,PIdx_11) ,param_macro(29,PIdx_11) );} if(cBoolModel[PIdx_12 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_12 , sumConductivity_12,v_12 ,ModelStates_12[0],ModelStates_12[1],param_macro(0,PIdx_12) ,param_macro(1,PIdx_12) ,ModelStates_12[8],ModelStates_12[9]);} if(cBoolModel[PIdx_12 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_12 , sumConductivity_12,v_12 ,ModelStates_12[2],ModelStates_12[9],ModelStates_12[8]);} if(cBoolModel[PIdx_12 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_12 , sumConductivity_12,v_12 ,ModelStates_12[3],param_macro(2,PIdx_12) ,param_macro(3,PIdx_12) ,param_macro(4,PIdx_12) ,param_macro(5,PIdx_12) ,ModelStates_12[8]);} if(cBoolModel[PIdx_12 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_12 , sumConductivity_12,v_12 ,ModelStates_12[4],param_macro(6,PIdx_12) ,param_macro(7,PIdx_12) ,param_macro(8,PIdx_12) ,param_macro(9,PIdx_12) ,param_macro(10,PIdx_12) );} if(cBoolModel[PIdx_12 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_12 , sumConductivity_12,v_12 ,ModelStates_12[5],param_macro(11,PIdx_12) ,param_macro(12,PIdx_12) ,param_macro(13,PIdx_12) ,param_macro(14,PIdx_12) ,param_macro(15,PIdx_12) );} if(cBoolModel[PIdx_12 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_12 , sumConductivity_12,v_12 ,ModelStates_12[6],ModelStates_12[7],param_macro(16,PIdx_12) ,param_macro(17,PIdx_12) ,param_macro(18,PIdx_12) ,param_macro(19,PIdx_12) ,param_macro(20,PIdx_12) ,param_macro(21,PIdx_12) ,param_macro(22,PIdx_12) ,param_macro(23,PIdx_12) ,param_macro(24,PIdx_12) ,param_macro(25,PIdx_12) ,param_macro(26,PIdx_12) ,param_macro(27,PIdx_12) );} if(cBoolModel[PIdx_12 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_12 , sumConductivity_12,v_12 ,param_macro(28,PIdx_12) ,param_macro(29,PIdx_12) );} if(cBoolModel[PIdx_13 +0*SMemMat.N]){CuBreakpointModel_ca(sumCurrents_13 , sumConductivity_13,v_13 ,ModelStates_13[0],ModelStates_13[1],param_macro(0,PIdx_13) ,param_macro(1,PIdx_13) ,ModelStates_13[8],ModelStates_13[9]);} if(cBoolModel[PIdx_13 +1*SMemMat.N]){CuBreakpointModel_cad(sumCurrents_13 , sumConductivity_13,v_13 ,ModelStates_13[2],ModelStates_13[9],ModelStates_13[8]);} if(cBoolModel[PIdx_13 +2*SMemMat.N]){CuBreakpointModel_kca(sumCurrents_13 , sumConductivity_13,v_13 ,ModelStates_13[3],param_macro(2,PIdx_13) ,param_macro(3,PIdx_13) ,param_macro(4,PIdx_13) ,param_macro(5,PIdx_13) ,ModelStates_13[8]);} if(cBoolModel[PIdx_13 +3*SMemMat.N]){CuBreakpointModel_km(sumCurrents_13 , sumConductivity_13,v_13 ,ModelStates_13[4],param_macro(6,PIdx_13) ,param_macro(7,PIdx_13) ,param_macro(8,PIdx_13) ,param_macro(9,PIdx_13) ,param_macro(10,PIdx_13) );} if(cBoolModel[PIdx_13 +4*SMemMat.N]){CuBreakpointModel_kv(sumCurrents_13 , sumConductivity_13,v_13 ,ModelStates_13[5],param_macro(11,PIdx_13) ,param_macro(12,PIdx_13) ,param_macro(13,PIdx_13) ,param_macro(14,PIdx_13) ,param_macro(15,PIdx_13) );} if(cBoolModel[PIdx_13 +5*SMemMat.N]){CuBreakpointModel_na(sumCurrents_13 , sumConductivity_13,v_13 ,ModelStates_13[6],ModelStates_13[7],param_macro(16,PIdx_13) ,param_macro(17,PIdx_13) ,param_macro(18,PIdx_13) ,param_macro(19,PIdx_13) ,param_macro(20,PIdx_13) ,param_macro(21,PIdx_13) ,param_macro(22,PIdx_13) ,param_macro(23,PIdx_13) ,param_macro(24,PIdx_13) ,param_macro(25,PIdx_13) ,param_macro(26,PIdx_13) ,param_macro(27,PIdx_13) );} if(cBoolModel[PIdx_13 +6*SMemMat.N]){CuBreakpointModel_pas(sumCurrents_13 , sumConductivity_13,v_13 ,param_macro(28,PIdx_13) ,param_macro(29,PIdx_13) );}
	// gModel_3 = (sumCurrentsDv_3-sumCurrents_3)/0.001; 
#define THISCOMMANDHERE29(VARILP) gModel_ ## VARILP  = (sumCurrentsDv_ ## VARILP -sumCurrents_ ## VARILP )/EPS_V;  
	gModel_1  = (sumCurrentsDv_1 -sumCurrents_1 )/EPS_V;  gModel_2  = (sumCurrentsDv_2 -sumCurrents_2 )/EPS_V;  gModel_3  = (sumCurrentsDv_3 -sumCurrents_3 )/EPS_V;  gModel_4  = (sumCurrentsDv_4 -sumCurrents_4 )/EPS_V;  gModel_5  = (sumCurrentsDv_5 -sumCurrents_5 )/EPS_V;  gModel_6  = (sumCurrentsDv_6 -sumCurrents_6 )/EPS_V;  gModel_7  = (sumCurrentsDv_7 -sumCurrents_7 )/EPS_V;  gModel_8  = (sumCurrentsDv_8 -sumCurrents_8 )/EPS_V;  gModel_9  = (sumCurrentsDv_9 -sumCurrents_9 )/EPS_V;  gModel_10  = (sumCurrentsDv_10 -sumCurrents_10 )/EPS_V;  gModel_11  = (sumCurrentsDv_11 -sumCurrents_11 )/EPS_V;  gModel_12  = (sumCurrentsDv_12 -sumCurrents_12 )/EPS_V;  gModel_13  = (sumCurrentsDv_13 -sumCurrents_13 )/EPS_V;  
	
#define THISCOMMANDHERE30(VARILP) rhs_ ## VARILP =StimCurrent_ ## VARILP -sumCurrents_ ## VARILP ;
	rhs_1 =StimCurrent_1 -sumCurrents_1 ;rhs_2 =StimCurrent_2 -sumCurrents_2 ;rhs_3 =StimCurrent_3 -sumCurrents_3 ;rhs_4 =StimCurrent_4 -sumCurrents_4 ;rhs_5 =StimCurrent_5 -sumCurrents_5 ;rhs_6 =StimCurrent_6 -sumCurrents_6 ;rhs_7 =StimCurrent_7 -sumCurrents_7 ;rhs_8 =StimCurrent_8 -sumCurrents_8 ;rhs_9 =StimCurrent_9 -sumCurrents_9 ;rhs_10 =StimCurrent_10 -sumCurrents_10 ;rhs_11 =StimCurrent_11 -sumCurrents_11 ;rhs_12 =StimCurrent_12 -sumCurrents_12 ;rhs_13 =StimCurrent_13 -sumCurrents_13 ;
#define THISCOMMANDHERE31(VARILP) D_ ## VARILP =gModel_ ## VARILP +cCm[PIdx_ ## VARILP ]/(dt*1000); D_ ## VARILP -=cF[SMemMat.N-PIdx_ ## VARILP -1];
	D_1 =gModel_1 +cCm[PIdx_1 ]/(dt*1000); D_1 -=cF[SMemMat.N-PIdx_1 -1];D_2 =gModel_2 +cCm[PIdx_2 ]/(dt*1000); D_2 -=cF[SMemMat.N-PIdx_2 -1];D_3 =gModel_3 +cCm[PIdx_3 ]/(dt*1000); D_3 -=cF[SMemMat.N-PIdx_3 -1];D_4 =gModel_4 +cCm[PIdx_4 ]/(dt*1000); D_4 -=cF[SMemMat.N-PIdx_4 -1];D_5 =gModel_5 +cCm[PIdx_5 ]/(dt*1000); D_5 -=cF[SMemMat.N-PIdx_5 -1];D_6 =gModel_6 +cCm[PIdx_6 ]/(dt*1000); D_6 -=cF[SMemMat.N-PIdx_6 -1];D_7 =gModel_7 +cCm[PIdx_7 ]/(dt*1000); D_7 -=cF[SMemMat.N-PIdx_7 -1];D_8 =gModel_8 +cCm[PIdx_8 ]/(dt*1000); D_8 -=cF[SMemMat.N-PIdx_8 -1];D_9 =gModel_9 +cCm[PIdx_9 ]/(dt*1000); D_9 -=cF[SMemMat.N-PIdx_9 -1];D_10 =gModel_10 +cCm[PIdx_10 ]/(dt*1000); D_10 -=cF[SMemMat.N-PIdx_10 -1];D_11 =gModel_11 +cCm[PIdx_11 ]/(dt*1000); D_11 -=cF[SMemMat.N-PIdx_11 -1];D_12 =gModel_12 +cCm[PIdx_12 ]/(dt*1000); D_12 -=cF[SMemMat.N-PIdx_12 -1];D_13 =gModel_13 +cCm[PIdx_13 ]/(dt*1000); D_13 -=cF[SMemMat.N-PIdx_13 -1];
   
    //this should be out and correct cKs
	if(PIdx_1==0) {
		parentIndex_1=0;
	};
#define THISCOMMANDHERE32(VARILP)  dv_ ## VARILP +=bHP[SMemMat.N-parentIndex_ ## VARILP -1]-bHP[SMemMat.N-PIdx_ ## VARILP -1]; rhs_ ## VARILP -=cF[SMemMat.N-PIdx_ ## VARILP -1]*dv_ ## VARILP ;
	 dv_1 +=bHP[SMemMat.N-parentIndex_1 -1]-bHP[SMemMat.N-PIdx_1 -1]; rhs_1 -=cF[SMemMat.N-PIdx_1 -1]*dv_1 ; dv_2 +=bHP[SMemMat.N-parentIndex_2 -1]-bHP[SMemMat.N-PIdx_2 -1]; rhs_2 -=cF[SMemMat.N-PIdx_2 -1]*dv_2 ; dv_3 +=bHP[SMemMat.N-parentIndex_3 -1]-bHP[SMemMat.N-PIdx_3 -1]; rhs_3 -=cF[SMemMat.N-PIdx_3 -1]*dv_3 ; dv_4 +=bHP[SMemMat.N-parentIndex_4 -1]-bHP[SMemMat.N-PIdx_4 -1]; rhs_4 -=cF[SMemMat.N-PIdx_4 -1]*dv_4 ; dv_5 +=bHP[SMemMat.N-parentIndex_5 -1]-bHP[SMemMat.N-PIdx_5 -1]; rhs_5 -=cF[SMemMat.N-PIdx_5 -1]*dv_5 ; dv_6 +=bHP[SMemMat.N-parentIndex_6 -1]-bHP[SMemMat.N-PIdx_6 -1]; rhs_6 -=cF[SMemMat.N-PIdx_6 -1]*dv_6 ; dv_7 +=bHP[SMemMat.N-parentIndex_7 -1]-bHP[SMemMat.N-PIdx_7 -1]; rhs_7 -=cF[SMemMat.N-PIdx_7 -1]*dv_7 ; dv_8 +=bHP[SMemMat.N-parentIndex_8 -1]-bHP[SMemMat.N-PIdx_8 -1]; rhs_8 -=cF[SMemMat.N-PIdx_8 -1]*dv_8 ; dv_9 +=bHP[SMemMat.N-parentIndex_9 -1]-bHP[SMemMat.N-PIdx_9 -1]; rhs_9 -=cF[SMemMat.N-PIdx_9 -1]*dv_9 ; dv_10 +=bHP[SMemMat.N-parentIndex_10 -1]-bHP[SMemMat.N-PIdx_10 -1]; rhs_10 -=cF[SMemMat.N-PIdx_10 -1]*dv_10 ; dv_11 +=bHP[SMemMat.N-parentIndex_11 -1]-bHP[SMemMat.N-PIdx_11 -1]; rhs_11 -=cF[SMemMat.N-PIdx_11 -1]*dv_11 ; dv_12 +=bHP[SMemMat.N-parentIndex_12 -1]-bHP[SMemMat.N-PIdx_12 -1]; rhs_12 -=cF[SMemMat.N-PIdx_12 -1]*dv_12 ; dv_13 +=bHP[SMemMat.N-parentIndex_13 -1]-bHP[SMemMat.N-PIdx_13 -1]; rhs_13 -=cF[SMemMat.N-PIdx_13 -1]*dv_13 ;
		// D_3=sumConductivity_3+SMemMat.Cms[PIdx_3]/(sim.dt*1000); // D_3-=cF[SMemMat.N-PIdx_3-1];
		// bHP[SMemMat.N-PIdx_3-1]=rhs_3; // uHP[SMemMat.N-PIdx_3-1]=D_3;
#define THISCOMMANDHERE33(VARILP) bHP[SMemMat.N-PIdx_ ## VARILP -1]=rhs_ ## VARILP ; uHP[SMemMat.N-PIdx_ ## VARILP -1]=D_ ## VARILP ;
		bHP[SMemMat.N-PIdx_1 -1]=rhs_1 ; uHP[SMemMat.N-PIdx_1 -1]=D_1 ;bHP[SMemMat.N-PIdx_2 -1]=rhs_2 ; uHP[SMemMat.N-PIdx_2 -1]=D_2 ;bHP[SMemMat.N-PIdx_3 -1]=rhs_3 ; uHP[SMemMat.N-PIdx_3 -1]=D_3 ;bHP[SMemMat.N-PIdx_4 -1]=rhs_4 ; uHP[SMemMat.N-PIdx_4 -1]=D_4 ;bHP[SMemMat.N-PIdx_5 -1]=rhs_5 ; uHP[SMemMat.N-PIdx_5 -1]=D_5 ;bHP[SMemMat.N-PIdx_6 -1]=rhs_6 ; uHP[SMemMat.N-PIdx_6 -1]=D_6 ;bHP[SMemMat.N-PIdx_7 -1]=rhs_7 ; uHP[SMemMat.N-PIdx_7 -1]=D_7 ;bHP[SMemMat.N-PIdx_8 -1]=rhs_8 ; uHP[SMemMat.N-PIdx_8 -1]=D_8 ;bHP[SMemMat.N-PIdx_9 -1]=rhs_9 ; uHP[SMemMat.N-PIdx_9 -1]=D_9 ;bHP[SMemMat.N-PIdx_10 -1]=rhs_10 ; uHP[SMemMat.N-PIdx_10 -1]=D_10 ;bHP[SMemMat.N-PIdx_11 -1]=rhs_11 ; uHP[SMemMat.N-PIdx_11 -1]=D_11 ;bHP[SMemMat.N-PIdx_12 -1]=rhs_12 ; uHP[SMemMat.N-PIdx_12 -1]=D_12 ;bHP[SMemMat.N-PIdx_13 -1]=rhs_13 ; uHP[SMemMat.N-PIdx_13 -1]=D_13 ;
		syncthreads();

		// if(SonNo_3==1) {bHP[SMemMat.N-parentIndex_3-1]+=cE[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=cE[Eidx_3];}
		//I
//#define THISCOMMANDHERE34(VARILP) if(SonNo_ ## VARILP ==1) {bHP[SMemMat.N-parentIndex_ ## VARILP -1]+=cE[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[SMemMat.N-parentIndex_ ## VARILP -1]-=cE[Eidx_ ## VARILP ];}
	//above line was changed to the no more variable sonno
		if(cSonNoVec[PIdx_1 ] ==1) {bHP[SMemMat.N-parentIndex_1 -1]+=cE[Eidx_1 ]*dv_1 ;uHP[SMemMat.N-parentIndex_1 -1]-=cE[Eidx_1 ];}if(cSonNoVec[PIdx_2 ] ==1) {bHP[SMemMat.N-parentIndex_2 -1]+=cE[Eidx_2 ]*dv_2 ;uHP[SMemMat.N-parentIndex_2 -1]-=cE[Eidx_2 ];}if(cSonNoVec[PIdx_3 ] ==1) {bHP[SMemMat.N-parentIndex_3 -1]+=cE[Eidx_3 ]*dv_3 ;uHP[SMemMat.N-parentIndex_3 -1]-=cE[Eidx_3 ];}if(cSonNoVec[PIdx_4 ] ==1) {bHP[SMemMat.N-parentIndex_4 -1]+=cE[Eidx_4 ]*dv_4 ;uHP[SMemMat.N-parentIndex_4 -1]-=cE[Eidx_4 ];}if(cSonNoVec[PIdx_5 ] ==1) {bHP[SMemMat.N-parentIndex_5 -1]+=cE[Eidx_5 ]*dv_5 ;uHP[SMemMat.N-parentIndex_5 -1]-=cE[Eidx_5 ];}if(cSonNoVec[PIdx_6 ] ==1) {bHP[SMemMat.N-parentIndex_6 -1]+=cE[Eidx_6 ]*dv_6 ;uHP[SMemMat.N-parentIndex_6 -1]-=cE[Eidx_6 ];}if(cSonNoVec[PIdx_7 ] ==1) {bHP[SMemMat.N-parentIndex_7 -1]+=cE[Eidx_7 ]*dv_7 ;uHP[SMemMat.N-parentIndex_7 -1]-=cE[Eidx_7 ];}if(cSonNoVec[PIdx_8 ] ==1) {bHP[SMemMat.N-parentIndex_8 -1]+=cE[Eidx_8 ]*dv_8 ;uHP[SMemMat.N-parentIndex_8 -1]-=cE[Eidx_8 ];}if(cSonNoVec[PIdx_9 ] ==1) {bHP[SMemMat.N-parentIndex_9 -1]+=cE[Eidx_9 ]*dv_9 ;uHP[SMemMat.N-parentIndex_9 -1]-=cE[Eidx_9 ];}if(cSonNoVec[PIdx_10 ] ==1) {bHP[SMemMat.N-parentIndex_10 -1]+=cE[Eidx_10 ]*dv_10 ;uHP[SMemMat.N-parentIndex_10 -1]-=cE[Eidx_10 ];}if(cSonNoVec[PIdx_11 ] ==1) {bHP[SMemMat.N-parentIndex_11 -1]+=cE[Eidx_11 ]*dv_11 ;uHP[SMemMat.N-parentIndex_11 -1]-=cE[Eidx_11 ];}if(cSonNoVec[PIdx_12 ] ==1) {bHP[SMemMat.N-parentIndex_12 -1]+=cE[Eidx_12 ]*dv_12 ;uHP[SMemMat.N-parentIndex_12 -1]-=cE[Eidx_12 ];}if(cSonNoVec[PIdx_13 ] ==1) {bHP[SMemMat.N-parentIndex_13 -1]+=cE[Eidx_13 ]*dv_13 ;uHP[SMemMat.N-parentIndex_13 -1]-=cE[Eidx_13 ];}
		// if(SonNo_3==2) {bHP[SMemMat.N-parentIndex_3-1]+=cE[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=cE[Eidx_3];}
//#define THISCOMMANDHERE35(VARILP) if(SonNo_ ## VARILP ==2) {bHP[SMemMat.N-parentIndex_ ## VARILP -1]+=cE[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[SMemMat.N-parentIndex_ ## VARILP -1]-=cE[Eidx_ ## VARILP ];}
		//above line was changed to the no more variable sonno
		if(cSonNoVec[PIdx_1 ] ==2) {bHP[SMemMat.N-parentIndex_1 -1]+=cE[Eidx_1 ]*dv_1 ;uHP[SMemMat.N-parentIndex_1 -1]-=cE[Eidx_1 ];}if(cSonNoVec[PIdx_2 ] ==2) {bHP[SMemMat.N-parentIndex_2 -1]+=cE[Eidx_2 ]*dv_2 ;uHP[SMemMat.N-parentIndex_2 -1]-=cE[Eidx_2 ];}if(cSonNoVec[PIdx_3 ] ==2) {bHP[SMemMat.N-parentIndex_3 -1]+=cE[Eidx_3 ]*dv_3 ;uHP[SMemMat.N-parentIndex_3 -1]-=cE[Eidx_3 ];}if(cSonNoVec[PIdx_4 ] ==2) {bHP[SMemMat.N-parentIndex_4 -1]+=cE[Eidx_4 ]*dv_4 ;uHP[SMemMat.N-parentIndex_4 -1]-=cE[Eidx_4 ];}if(cSonNoVec[PIdx_5 ] ==2) {bHP[SMemMat.N-parentIndex_5 -1]+=cE[Eidx_5 ]*dv_5 ;uHP[SMemMat.N-parentIndex_5 -1]-=cE[Eidx_5 ];}if(cSonNoVec[PIdx_6 ] ==2) {bHP[SMemMat.N-parentIndex_6 -1]+=cE[Eidx_6 ]*dv_6 ;uHP[SMemMat.N-parentIndex_6 -1]-=cE[Eidx_6 ];}if(cSonNoVec[PIdx_7 ] ==2) {bHP[SMemMat.N-parentIndex_7 -1]+=cE[Eidx_7 ]*dv_7 ;uHP[SMemMat.N-parentIndex_7 -1]-=cE[Eidx_7 ];}if(cSonNoVec[PIdx_8 ] ==2) {bHP[SMemMat.N-parentIndex_8 -1]+=cE[Eidx_8 ]*dv_8 ;uHP[SMemMat.N-parentIndex_8 -1]-=cE[Eidx_8 ];}if(cSonNoVec[PIdx_9 ] ==2) {bHP[SMemMat.N-parentIndex_9 -1]+=cE[Eidx_9 ]*dv_9 ;uHP[SMemMat.N-parentIndex_9 -1]-=cE[Eidx_9 ];}if(cSonNoVec[PIdx_10 ] ==2) {bHP[SMemMat.N-parentIndex_10 -1]+=cE[Eidx_10 ]*dv_10 ;uHP[SMemMat.N-parentIndex_10 -1]-=cE[Eidx_10 ];}if(cSonNoVec[PIdx_11 ] ==2) {bHP[SMemMat.N-parentIndex_11 -1]+=cE[Eidx_11 ]*dv_11 ;uHP[SMemMat.N-parentIndex_11 -1]-=cE[Eidx_11 ];}if(cSonNoVec[PIdx_12 ] ==2) {bHP[SMemMat.N-parentIndex_12 -1]+=cE[Eidx_12 ]*dv_12 ;uHP[SMemMat.N-parentIndex_12 -1]-=cE[Eidx_12 ];}if(cSonNoVec[PIdx_13 ] ==2) {bHP[SMemMat.N-parentIndex_13 -1]+=cE[Eidx_13 ]*dv_13 ;uHP[SMemMat.N-parentIndex_13 -1]-=cE[Eidx_13 ];}
		syncthreads();
		BeforeLU(SMemMat,uHP,bHP,SMemMat.Depth);
#ifdef BKSUB1
		BkSub(SMemMat, PX,PF,uHP,bHP,SMemMat.LognDepth);
		//RBS Here i removed Vs[PIdx_ ## VARILP ]+=Vmid_ ## VARILP 
		#define THISCOMMANDHERE36(VARILP) Vmid_ ## VARILP =PX[SMemMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ; Vs[PIdx_ ## VARILP ]+=Vmid_ ## VARILP ;
		Vmid_1 =PX[SMemMat.N-PIdx_1 -1]; v_1 +=Vmid_1 ; Vmid_2 =PX[SMemMat.N-PIdx_2 -1]; v_2 +=Vmid_2 ; Vmid_3 =PX[SMemMat.N-PIdx_3 -1]; v_3 +=Vmid_3 ; Vmid_4 =PX[SMemMat.N-PIdx_4 -1]; v_4 +=Vmid_4 ; Vmid_5 =PX[SMemMat.N-PIdx_5 -1]; v_5 +=Vmid_5 ; Vmid_6 =PX[SMemMat.N-PIdx_6 -1]; v_6 +=Vmid_6 ;Vmid_7 =PX[SMemMat.N-PIdx_7 -1]; v_7 +=Vmid_7 ; Vmid_8 =PX[SMemMat.N-PIdx_8 -1]; v_8 +=Vmid_8 ; Vmid_9 =PX[SMemMat.N-PIdx_9 -1]; v_9 +=Vmid_9 ; Vmid_10 =PX[SMemMat.N-PIdx_10 -1]; v_10 +=Vmid_10 ; Vmid_11 =PX[SMemMat.N-PIdx_11 -1]; v_11 +=Vmid_11 ; Vmid_12 =PX[SMemMat.N-PIdx_12 -1]; v_12 +=Vmid_12 ; Vmid_13 =PX[SMemMat.N-PIdx_13 -1]; v_13 +=Vmid_13 ;
#endif

		
#ifdef BKSUB2
		#define THISCOMMANDHERE37(VARILP) MYFTYPE vTemp_ ## VARILP=Vs[PIdx_ ## VARILP];
		MYFTYPE vTemp_1=Vs[PIdx_1];MYFTYPE vTemp_2=Vs[PIdx_2];MYFTYPE vTemp_3=Vs[PIdx_3];MYFTYPE vTemp_4=Vs[PIdx_4];MYFTYPE vTemp_5=Vs[PIdx_5];MYFTYPE vTemp_6=Vs[PIdx_6];MYFTYPE vTemp_7=Vs[PIdx_7];MYFTYPE vTemp_8=Vs[PIdx_8];MYFTYPE vTemp_9=Vs[PIdx_9];MYFTYPE vTemp_10=Vs[PIdx_10];MYFTYPE vTemp_11=Vs[PIdx_11];MYFTYPE vTemp_12=Vs[PIdx_12];MYFTYPE vTemp_13=Vs[PIdx_13];
		syncthreads();
		BkSub(SMemMat,uHP,bHP,Vs,SMemMat.Depth);
		syncthreads();
		PX=Vs;

#define THISCOMMANDHERE38(VARILP) Vmid_ ## VARILP =PX[SMemMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ;
		Vmid_1 =PX[SMemMat.N-PIdx_1 -1]; v_1 +=Vmid_1 ;Vmid_2 =PX[SMemMat.N-PIdx_2 -1]; v_2 +=Vmid_2 ;Vmid_3 =PX[SMemMat.N-PIdx_3 -1]; v_3 +=Vmid_3 ;Vmid_4 =PX[SMemMat.N-PIdx_4 -1]; v_4 +=Vmid_4 ;Vmid_5 =PX[SMemMat.N-PIdx_5 -1]; v_5 +=Vmid_5 ;Vmid_6 =PX[SMemMat.N-PIdx_6 -1]; v_6 +=Vmid_6 ;Vmid_7 =PX[SMemMat.N-PIdx_7 -1]; v_7 +=Vmid_7 ;Vmid_8 =PX[SMemMat.N-PIdx_8 -1]; v_8 +=Vmid_8 ;Vmid_9 =PX[SMemMat.N-PIdx_9 -1]; v_9 +=Vmid_9 ;Vmid_10 =PX[SMemMat.N-PIdx_10 -1]; v_10 +=Vmid_10 ;Vmid_11 =PX[SMemMat.N-PIdx_11 -1]; v_11 +=Vmid_11 ;Vmid_12 =PX[SMemMat.N-PIdx_12 -1]; v_12 +=Vmid_12 ;Vmid_13 =PX[SMemMat.N-PIdx_13 -1]; v_13 +=Vmid_13 ;
		syncthreads(); 
#define THISCOMMANDHERE39(VARILP) Vs[PIdx_ ## VARILP ]= vTemp_ ## VARILP +Vmid_ ## VARILP ;
		Vs[PIdx_1 ]= vTemp_1 +Vmid_1 ;Vs[PIdx_2 ]= vTemp_2 +Vmid_2 ;Vs[PIdx_3 ]= vTemp_3 +Vmid_3 ;Vs[PIdx_4 ]= vTemp_4 +Vmid_4 ;Vs[PIdx_5 ]= vTemp_5 +Vmid_5 ;Vs[PIdx_6 ]= vTemp_6 +Vmid_6 ;Vs[PIdx_7 ]= vTemp_7 +Vmid_7 ;Vs[PIdx_8 ]= vTemp_8 +Vmid_8 ;Vs[PIdx_9 ]= vTemp_9 +Vmid_9 ;Vs[PIdx_10 ]= vTemp_10 +Vmid_10 ;Vs[PIdx_11 ]= vTemp_11 +Vmid_11 ;Vs[PIdx_12 ]= vTemp_12 +Vmid_12 ;Vs[PIdx_13 ]= vTemp_13 +Vmid_13 ;
#endif		
            t+=0.5*dt;

        

//      if(cBoolModel[PIdx_1 +0*SMemMat.N]){CuDerivModel_ca(dt, v_1,ModelStates_1[0],ModelStates_1[1],param_macro(0,PIdx_1) ,param_macro(1,PIdx_1) ,ModelStates_1[8],ModelStates_1[9]);} if(cBoolModel[PIdx_1 +1*SMemMat.N]){CuDerivModel_cad(dt, v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(cBoolModel[PIdx_1 +2*SMemMat.N]){CuDerivModel_kca(dt, v_1,ModelStates_1[3],param_macro(2,PIdx_1) ,param_macro(3,PIdx_1) ,param_macro(4,PIdx_1) ,param_macro(5,PIdx_1) ,ModelStates_1[8]);} if(cBoolModel[PIdx_1 +3*SMemMat.N]){CuDerivModel_km(dt, v_1,ModelStates_1[4],param_macro(6,PIdx_1) ,param_macro(7,PIdx_1) ,param_macro(8,PIdx_1) ,param_macro(9,PIdx_1) ,param_macro(10,PIdx_1) );} if(cBoolModel[PIdx_1 +4*SMemMat.N]){CuDerivModel_kv(dt, v_1,ModelStates_1[5],param_macro(11,PIdx_1) ,param_macro(12,PIdx_1) ,param_macro(13,PIdx_1) ,param_macro(14,PIdx_1) ,param_macro(15,PIdx_1) );} if(cBoolModel[PIdx_1 +5*SMemMat.N]){CuDerivModel_na(dt, v_1,ModelStates_1[6],ModelStates_1[7],param_macro(16,PIdx_1) ,param_macro(17,PIdx_1) ,param_macro(18,PIdx_1) ,param_macro(19,PIdx_1) ,param_macro(20,PIdx_1) ,param_macro(21,PIdx_1) ,param_macro(22,PIdx_1) ,param_macro(23,PIdx_1) ,param_macro(24,PIdx_1) ,param_macro(25,PIdx_1) ,param_macro(26,PIdx_1) ,param_macro(27,PIdx_1) );}  if(cBoolModel[PIdx_2 +0*SMemMat.N]){CuDerivModel_ca(dt, v_2,ModelStates_2[0],ModelStates_2[1],param_macro(0,PIdx_2) ,param_macro(1,PIdx_2) ,ModelStates_2[8],ModelStates_2[9]);} if(cBoolModel[PIdx_2 +1*SMemMat.N]){CuDerivModel_cad(dt, v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(cBoolModel[PIdx_2 +2*SMemMat.N]){CuDerivModel_kca(dt, v_2,ModelStates_2[3],param_macro(2,PIdx_2) ,param_macro(3,PIdx_2) ,param_macro(4,PIdx_2) ,param_macro(5,PIdx_2) ,ModelStates_2[8]);} if(cBoolModel[PIdx_2 +3*SMemMat.N]){CuDerivModel_km(dt, v_2,ModelStates_2[4],param_macro(6,PIdx_2) ,param_macro(7,PIdx_2) ,param_macro(8,PIdx_2) ,param_macro(9,PIdx_2) ,param_macro(10,PIdx_2) );} if(cBoolModel[PIdx_2 +4*SMemMat.N]){CuDerivModel_kv(dt, v_2,ModelStates_2[5],param_macro(11,PIdx_2) ,param_macro(12,PIdx_2) ,param_macro(13,PIdx_2) ,param_macro(14,PIdx_2) ,param_macro(15,PIdx_2) );} if(cBoolModel[PIdx_2 +5*SMemMat.N]){CuDerivModel_na(dt, v_2,ModelStates_2[6],ModelStates_2[7],param_macro(16,PIdx_2) ,param_macro(17,PIdx_2) ,param_macro(18,PIdx_2) ,param_macro(19,PIdx_2) ,param_macro(20,PIdx_2) ,param_macro(21,PIdx_2) ,param_macro(22,PIdx_2) ,param_macro(23,PIdx_2) ,param_macro(24,PIdx_2) ,param_macro(25,PIdx_2) ,param_macro(26,PIdx_2) ,param_macro(27,PIdx_2) );}  if(cBoolModel[PIdx_3 +0*SMemMat.N]){CuDerivModel_ca(dt, v_3,ModelStates_3[0],ModelStates_3[1],param_macro(0,PIdx_3) ,param_macro(1,PIdx_3) ,ModelStates_3[8],ModelStates_3[9]);} if(cBoolModel[PIdx_3 +1*SMemMat.N]){CuDerivModel_cad(dt, v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(cBoolModel[PIdx_3 +2*SMemMat.N]){CuDerivModel_kca(dt, v_3,ModelStates_3[3],param_macro(2,PIdx_3) ,param_macro(3,PIdx_3) ,param_macro(4,PIdx_3) ,param_macro(5,PIdx_3) ,ModelStates_3[8]);} if(cBoolModel[PIdx_3 +3*SMemMat.N]){CuDerivModel_km(dt, v_3,ModelStates_3[4],param_macro(6,PIdx_3) ,param_macro(7,PIdx_3) ,param_macro(8,PIdx_3) ,param_macro(9,PIdx_3) ,param_macro(10,PIdx_3) );} if(cBoolModel[PIdx_3 +4*SMemMat.N]){CuDerivModel_kv(dt, v_3,ModelStates_3[5],param_macro(11,PIdx_3) ,param_macro(12,PIdx_3) ,param_macro(13,PIdx_3) ,param_macro(14,PIdx_3) ,param_macro(15,PIdx_3) );} if(cBoolModel[PIdx_3 +5*SMemMat.N]){CuDerivModel_na(dt, v_3,ModelStates_3[6],ModelStates_3[7],param_macro(16,PIdx_3) ,param_macro(17,PIdx_3) ,param_macro(18,PIdx_3) ,param_macro(19,PIdx_3) ,param_macro(20,PIdx_3) ,param_macro(21,PIdx_3) ,param_macro(22,PIdx_3) ,param_macro(23,PIdx_3) ,param_macro(24,PIdx_3) ,param_macro(25,PIdx_3) ,param_macro(26,PIdx_3) ,param_macro(27,PIdx_3) );}
		  if(cBoolModel[PIdx_1 +0*SMemMat.N]){CuDerivModel_ca(dt, v_1,ModelStates_1[0],ModelStates_1[1],param_macro(0,PIdx_1) ,param_macro(1,PIdx_1) ,ModelStates_1[8],ModelStates_1[9]);} if(cBoolModel[PIdx_1 +1*SMemMat.N]){CuDerivModel_cad(dt, v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(cBoolModel[PIdx_1 +2*SMemMat.N]){CuDerivModel_kca(dt, v_1,ModelStates_1[3],param_macro(2,PIdx_1) ,param_macro(3,PIdx_1) ,param_macro(4,PIdx_1) ,param_macro(5,PIdx_1) ,ModelStates_1[8]);} if(cBoolModel[PIdx_1 +3*SMemMat.N]){CuDerivModel_km(dt, v_1,ModelStates_1[4],param_macro(6,PIdx_1) ,param_macro(7,PIdx_1) ,param_macro(8,PIdx_1) ,param_macro(9,PIdx_1) ,param_macro(10,PIdx_1) );} if(cBoolModel[PIdx_1 +4*SMemMat.N]){CuDerivModel_kv(dt, v_1,ModelStates_1[5],param_macro(11,PIdx_1) ,param_macro(12,PIdx_1) ,param_macro(13,PIdx_1) ,param_macro(14,PIdx_1) ,param_macro(15,PIdx_1) );} if(cBoolModel[PIdx_1 +5*SMemMat.N]){CuDerivModel_na(dt, v_1,ModelStates_1[6],ModelStates_1[7],param_macro(16,PIdx_1) ,param_macro(17,PIdx_1) ,param_macro(18,PIdx_1) ,param_macro(19,PIdx_1) ,param_macro(20,PIdx_1) ,param_macro(21,PIdx_1) ,param_macro(22,PIdx_1) ,param_macro(23,PIdx_1) ,param_macro(24,PIdx_1) ,param_macro(25,PIdx_1) ,param_macro(26,PIdx_1) ,param_macro(27,PIdx_1) );} if(cBoolModel[PIdx_1 +6*SMemMat.N]){CuDerivModel_pas(dt, v_1,param_macro(28,PIdx_1) ,param_macro(29,PIdx_1) );}  if(cBoolModel[PIdx_2 +0*SMemMat.N]){CuDerivModel_ca(dt, v_2,ModelStates_2[0],ModelStates_2[1],param_macro(0,PIdx_2) ,param_macro(1,PIdx_2) ,ModelStates_2[8],ModelStates_2[9]);} if(cBoolModel[PIdx_2 +1*SMemMat.N]){CuDerivModel_cad(dt, v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(cBoolModel[PIdx_2 +2*SMemMat.N]){CuDerivModel_kca(dt, v_2,ModelStates_2[3],param_macro(2,PIdx_2) ,param_macro(3,PIdx_2) ,param_macro(4,PIdx_2) ,param_macro(5,PIdx_2) ,ModelStates_2[8]);} if(cBoolModel[PIdx_2 +3*SMemMat.N]){CuDerivModel_km(dt, v_2,ModelStates_2[4],param_macro(6,PIdx_2) ,param_macro(7,PIdx_2) ,param_macro(8,PIdx_2) ,param_macro(9,PIdx_2) ,param_macro(10,PIdx_2) );} if(cBoolModel[PIdx_2 +4*SMemMat.N]){CuDerivModel_kv(dt, v_2,ModelStates_2[5],param_macro(11,PIdx_2) ,param_macro(12,PIdx_2) ,param_macro(13,PIdx_2) ,param_macro(14,PIdx_2) ,param_macro(15,PIdx_2) );} if(cBoolModel[PIdx_2 +5*SMemMat.N]){CuDerivModel_na(dt, v_2,ModelStates_2[6],ModelStates_2[7],param_macro(16,PIdx_2) ,param_macro(17,PIdx_2) ,param_macro(18,PIdx_2) ,param_macro(19,PIdx_2) ,param_macro(20,PIdx_2) ,param_macro(21,PIdx_2) ,param_macro(22,PIdx_2) ,param_macro(23,PIdx_2) ,param_macro(24,PIdx_2) ,param_macro(25,PIdx_2) ,param_macro(26,PIdx_2) ,param_macro(27,PIdx_2) );} if(cBoolModel[PIdx_2 +6*SMemMat.N]){CuDerivModel_pas(dt, v_2,param_macro(28,PIdx_2) ,param_macro(29,PIdx_2) );}  if(cBoolModel[PIdx_3 +0*SMemMat.N]){CuDerivModel_ca(dt, v_3,ModelStates_3[0],ModelStates_3[1],param_macro(0,PIdx_3) ,param_macro(1,PIdx_3) ,ModelStates_3[8],ModelStates_3[9]);} if(cBoolModel[PIdx_3 +1*SMemMat.N]){CuDerivModel_cad(dt, v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(cBoolModel[PIdx_3 +2*SMemMat.N]){CuDerivModel_kca(dt, v_3,ModelStates_3[3],param_macro(2,PIdx_3) ,param_macro(3,PIdx_3) ,param_macro(4,PIdx_3) ,param_macro(5,PIdx_3) ,ModelStates_3[8]);} if(cBoolModel[PIdx_3 +3*SMemMat.N]){CuDerivModel_km(dt, v_3,ModelStates_3[4],param_macro(6,PIdx_3) ,param_macro(7,PIdx_3) ,param_macro(8,PIdx_3) ,param_macro(9,PIdx_3) ,param_macro(10,PIdx_3) );} if(cBoolModel[PIdx_3 +4*SMemMat.N]){CuDerivModel_kv(dt, v_3,ModelStates_3[5],param_macro(11,PIdx_3) ,param_macro(12,PIdx_3) ,param_macro(13,PIdx_3) ,param_macro(14,PIdx_3) ,param_macro(15,PIdx_3) );} if(cBoolModel[PIdx_3 +5*SMemMat.N]){CuDerivModel_na(dt, v_3,ModelStates_3[6],ModelStates_3[7],param_macro(16,PIdx_3) ,param_macro(17,PIdx_3) ,param_macro(18,PIdx_3) ,param_macro(19,PIdx_3) ,param_macro(20,PIdx_3) ,param_macro(21,PIdx_3) ,param_macro(22,PIdx_3) ,param_macro(23,PIdx_3) ,param_macro(24,PIdx_3) ,param_macro(25,PIdx_3) ,param_macro(26,PIdx_3) ,param_macro(27,PIdx_3) );} if(cBoolModel[PIdx_3 +6*SMemMat.N]){CuDerivModel_pas(dt, v_3,param_macro(28,PIdx_3) ,param_macro(29,PIdx_3) );}  if(cBoolModel[PIdx_4 +0*SMemMat.N]){CuDerivModel_ca(dt, v_4,ModelStates_4[0],ModelStates_4[1],param_macro(0,PIdx_4) ,param_macro(1,PIdx_4) ,ModelStates_4[8],ModelStates_4[9]);} if(cBoolModel[PIdx_4 +1*SMemMat.N]){CuDerivModel_cad(dt, v_4,ModelStates_4[2],ModelStates_4[9],ModelStates_4[8]);} if(cBoolModel[PIdx_4 +2*SMemMat.N]){CuDerivModel_kca(dt, v_4,ModelStates_4[3],param_macro(2,PIdx_4) ,param_macro(3,PIdx_4) ,param_macro(4,PIdx_4) ,param_macro(5,PIdx_4) ,ModelStates_4[8]);} if(cBoolModel[PIdx_4 +3*SMemMat.N]){CuDerivModel_km(dt, v_4,ModelStates_4[4],param_macro(6,PIdx_4) ,param_macro(7,PIdx_4) ,param_macro(8,PIdx_4) ,param_macro(9,PIdx_4) ,param_macro(10,PIdx_4) );} if(cBoolModel[PIdx_4 +4*SMemMat.N]){CuDerivModel_kv(dt, v_4,ModelStates_4[5],param_macro(11,PIdx_4) ,param_macro(12,PIdx_4) ,param_macro(13,PIdx_4) ,param_macro(14,PIdx_4) ,param_macro(15,PIdx_4) );} if(cBoolModel[PIdx_4 +5*SMemMat.N]){CuDerivModel_na(dt, v_4,ModelStates_4[6],ModelStates_4[7],param_macro(16,PIdx_4) ,param_macro(17,PIdx_4) ,param_macro(18,PIdx_4) ,param_macro(19,PIdx_4) ,param_macro(20,PIdx_4) ,param_macro(21,PIdx_4) ,param_macro(22,PIdx_4) ,param_macro(23,PIdx_4) ,param_macro(24,PIdx_4) ,param_macro(25,PIdx_4) ,param_macro(26,PIdx_4) ,param_macro(27,PIdx_4) );} if(cBoolModel[PIdx_4 +6*SMemMat.N]){CuDerivModel_pas(dt, v_4,param_macro(28,PIdx_4) ,param_macro(29,PIdx_4) );}  if(cBoolModel[PIdx_5 +0*SMemMat.N]){CuDerivModel_ca(dt, v_5,ModelStates_5[0],ModelStates_5[1],param_macro(0,PIdx_5) ,param_macro(1,PIdx_5) ,ModelStates_5[8],ModelStates_5[9]);} if(cBoolModel[PIdx_5 +1*SMemMat.N]){CuDerivModel_cad(dt, v_5,ModelStates_5[2],ModelStates_5[9],ModelStates_5[8]);} if(cBoolModel[PIdx_5 +2*SMemMat.N]){CuDerivModel_kca(dt, v_5,ModelStates_5[3],param_macro(2,PIdx_5) ,param_macro(3,PIdx_5) ,param_macro(4,PIdx_5) ,param_macro(5,PIdx_5) ,ModelStates_5[8]);} if(cBoolModel[PIdx_5 +3*SMemMat.N]){CuDerivModel_km(dt, v_5,ModelStates_5[4],param_macro(6,PIdx_5) ,param_macro(7,PIdx_5) ,param_macro(8,PIdx_5) ,param_macro(9,PIdx_5) ,param_macro(10,PIdx_5) );} if(cBoolModel[PIdx_5 +4*SMemMat.N]){CuDerivModel_kv(dt, v_5,ModelStates_5[5],param_macro(11,PIdx_5) ,param_macro(12,PIdx_5) ,param_macro(13,PIdx_5) ,param_macro(14,PIdx_5) ,param_macro(15,PIdx_5) );} if(cBoolModel[PIdx_5 +5*SMemMat.N]){CuDerivModel_na(dt, v_5,ModelStates_5[6],ModelStates_5[7],param_macro(16,PIdx_5) ,param_macro(17,PIdx_5) ,param_macro(18,PIdx_5) ,param_macro(19,PIdx_5) ,param_macro(20,PIdx_5) ,param_macro(21,PIdx_5) ,param_macro(22,PIdx_5) ,param_macro(23,PIdx_5) ,param_macro(24,PIdx_5) ,param_macro(25,PIdx_5) ,param_macro(26,PIdx_5) ,param_macro(27,PIdx_5) );} if(cBoolModel[PIdx_5 +6*SMemMat.N]){CuDerivModel_pas(dt, v_5,param_macro(28,PIdx_5) ,param_macro(29,PIdx_5) );}  if(cBoolModel[PIdx_6 +0*SMemMat.N]){CuDerivModel_ca(dt, v_6,ModelStates_6[0],ModelStates_6[1],param_macro(0,PIdx_6) ,param_macro(1,PIdx_6) ,ModelStates_6[8],ModelStates_6[9]);} if(cBoolModel[PIdx_6 +1*SMemMat.N]){CuDerivModel_cad(dt, v_6,ModelStates_6[2],ModelStates_6[9],ModelStates_6[8]);} if(cBoolModel[PIdx_6 +2*SMemMat.N]){CuDerivModel_kca(dt, v_6,ModelStates_6[3],param_macro(2,PIdx_6) ,param_macro(3,PIdx_6) ,param_macro(4,PIdx_6) ,param_macro(5,PIdx_6) ,ModelStates_6[8]);} if(cBoolModel[PIdx_6 +3*SMemMat.N]){CuDerivModel_km(dt, v_6,ModelStates_6[4],param_macro(6,PIdx_6) ,param_macro(7,PIdx_6) ,param_macro(8,PIdx_6) ,param_macro(9,PIdx_6) ,param_macro(10,PIdx_6) );} if(cBoolModel[PIdx_6 +4*SMemMat.N]){CuDerivModel_kv(dt, v_6,ModelStates_6[5],param_macro(11,PIdx_6) ,param_macro(12,PIdx_6) ,param_macro(13,PIdx_6) ,param_macro(14,PIdx_6) ,param_macro(15,PIdx_6) );} if(cBoolModel[PIdx_6 +5*SMemMat.N]){CuDerivModel_na(dt, v_6,ModelStates_6[6],ModelStates_6[7],param_macro(16,PIdx_6) ,param_macro(17,PIdx_6) ,param_macro(18,PIdx_6) ,param_macro(19,PIdx_6) ,param_macro(20,PIdx_6) ,param_macro(21,PIdx_6) ,param_macro(22,PIdx_6) ,param_macro(23,PIdx_6) ,param_macro(24,PIdx_6) ,param_macro(25,PIdx_6) ,param_macro(26,PIdx_6) ,param_macro(27,PIdx_6) );} if(cBoolModel[PIdx_6 +6*SMemMat.N]){CuDerivModel_pas(dt, v_6,param_macro(28,PIdx_6) ,param_macro(29,PIdx_6) );}  if(cBoolModel[PIdx_7 +0*SMemMat.N]){CuDerivModel_ca(dt, v_7,ModelStates_7[0],ModelStates_7[1],param_macro(0,PIdx_7) ,param_macro(1,PIdx_7) ,ModelStates_7[8],ModelStates_7[9]);} if(cBoolModel[PIdx_7 +1*SMemMat.N]){CuDerivModel_cad(dt, v_7,ModelStates_7[2],ModelStates_7[9],ModelStates_7[8]);} if(cBoolModel[PIdx_7 +2*SMemMat.N]){CuDerivModel_kca(dt, v_7,ModelStates_7[3],param_macro(2,PIdx_7) ,param_macro(3,PIdx_7) ,param_macro(4,PIdx_7) ,param_macro(5,PIdx_7) ,ModelStates_7[8]);} if(cBoolModel[PIdx_7 +3*SMemMat.N]){CuDerivModel_km(dt, v_7,ModelStates_7[4],param_macro(6,PIdx_7) ,param_macro(7,PIdx_7) ,param_macro(8,PIdx_7) ,param_macro(9,PIdx_7) ,param_macro(10,PIdx_7) );} if(cBoolModel[PIdx_7 +4*SMemMat.N]){CuDerivModel_kv(dt, v_7,ModelStates_7[5],param_macro(11,PIdx_7) ,param_macro(12,PIdx_7) ,param_macro(13,PIdx_7) ,param_macro(14,PIdx_7) ,param_macro(15,PIdx_7) );} if(cBoolModel[PIdx_7 +5*SMemMat.N]){CuDerivModel_na(dt, v_7,ModelStates_7[6],ModelStates_7[7],param_macro(16,PIdx_7) ,param_macro(17,PIdx_7) ,param_macro(18,PIdx_7) ,param_macro(19,PIdx_7) ,param_macro(20,PIdx_7) ,param_macro(21,PIdx_7) ,param_macro(22,PIdx_7) ,param_macro(23,PIdx_7) ,param_macro(24,PIdx_7) ,param_macro(25,PIdx_7) ,param_macro(26,PIdx_7) ,param_macro(27,PIdx_7) );} if(cBoolModel[PIdx_7 +6*SMemMat.N]){CuDerivModel_pas(dt, v_7,param_macro(28,PIdx_7) ,param_macro(29,PIdx_7) );}  if(cBoolModel[PIdx_8 +0*SMemMat.N]){CuDerivModel_ca(dt, v_8,ModelStates_8[0],ModelStates_8[1],param_macro(0,PIdx_8) ,param_macro(1,PIdx_8) ,ModelStates_8[8],ModelStates_8[9]);} if(cBoolModel[PIdx_8 +1*SMemMat.N]){CuDerivModel_cad(dt, v_8,ModelStates_8[2],ModelStates_8[9],ModelStates_8[8]);} if(cBoolModel[PIdx_8 +2*SMemMat.N]){CuDerivModel_kca(dt, v_8,ModelStates_8[3],param_macro(2,PIdx_8) ,param_macro(3,PIdx_8) ,param_macro(4,PIdx_8) ,param_macro(5,PIdx_8) ,ModelStates_8[8]);} if(cBoolModel[PIdx_8 +3*SMemMat.N]){CuDerivModel_km(dt, v_8,ModelStates_8[4],param_macro(6,PIdx_8) ,param_macro(7,PIdx_8) ,param_macro(8,PIdx_8) ,param_macro(9,PIdx_8) ,param_macro(10,PIdx_8) );} if(cBoolModel[PIdx_8 +4*SMemMat.N]){CuDerivModel_kv(dt, v_8,ModelStates_8[5],param_macro(11,PIdx_8) ,param_macro(12,PIdx_8) ,param_macro(13,PIdx_8) ,param_macro(14,PIdx_8) ,param_macro(15,PIdx_8) );} if(cBoolModel[PIdx_8 +5*SMemMat.N]){CuDerivModel_na(dt, v_8,ModelStates_8[6],ModelStates_8[7],param_macro(16,PIdx_8) ,param_macro(17,PIdx_8) ,param_macro(18,PIdx_8) ,param_macro(19,PIdx_8) ,param_macro(20,PIdx_8) ,param_macro(21,PIdx_8) ,param_macro(22,PIdx_8) ,param_macro(23,PIdx_8) ,param_macro(24,PIdx_8) ,param_macro(25,PIdx_8) ,param_macro(26,PIdx_8) ,param_macro(27,PIdx_8) );} if(cBoolModel[PIdx_8 +6*SMemMat.N]){CuDerivModel_pas(dt, v_8,param_macro(28,PIdx_8) ,param_macro(29,PIdx_8) );}  if(cBoolModel[PIdx_9 +0*SMemMat.N]){CuDerivModel_ca(dt, v_9,ModelStates_9[0],ModelStates_9[1],param_macro(0,PIdx_9) ,param_macro(1,PIdx_9) ,ModelStates_9[8],ModelStates_9[9]);} if(cBoolModel[PIdx_9 +1*SMemMat.N]){CuDerivModel_cad(dt, v_9,ModelStates_9[2],ModelStates_9[9],ModelStates_9[8]);} if(cBoolModel[PIdx_9 +2*SMemMat.N]){CuDerivModel_kca(dt, v_9,ModelStates_9[3],param_macro(2,PIdx_9) ,param_macro(3,PIdx_9) ,param_macro(4,PIdx_9) ,param_macro(5,PIdx_9) ,ModelStates_9[8]);} if(cBoolModel[PIdx_9 +3*SMemMat.N]){CuDerivModel_km(dt, v_9,ModelStates_9[4],param_macro(6,PIdx_9) ,param_macro(7,PIdx_9) ,param_macro(8,PIdx_9) ,param_macro(9,PIdx_9) ,param_macro(10,PIdx_9) );} if(cBoolModel[PIdx_9 +4*SMemMat.N]){CuDerivModel_kv(dt, v_9,ModelStates_9[5],param_macro(11,PIdx_9) ,param_macro(12,PIdx_9) ,param_macro(13,PIdx_9) ,param_macro(14,PIdx_9) ,param_macro(15,PIdx_9) );} if(cBoolModel[PIdx_9 +5*SMemMat.N]){CuDerivModel_na(dt, v_9,ModelStates_9[6],ModelStates_9[7],param_macro(16,PIdx_9) ,param_macro(17,PIdx_9) ,param_macro(18,PIdx_9) ,param_macro(19,PIdx_9) ,param_macro(20,PIdx_9) ,param_macro(21,PIdx_9) ,param_macro(22,PIdx_9) ,param_macro(23,PIdx_9) ,param_macro(24,PIdx_9) ,param_macro(25,PIdx_9) ,param_macro(26,PIdx_9) ,param_macro(27,PIdx_9) );} if(cBoolModel[PIdx_9 +6*SMemMat.N]){CuDerivModel_pas(dt, v_9,param_macro(28,PIdx_9) ,param_macro(29,PIdx_9) );}  if(cBoolModel[PIdx_10 +0*SMemMat.N]){CuDerivModel_ca(dt, v_10,ModelStates_10[0],ModelStates_10[1],param_macro(0,PIdx_10) ,param_macro(1,PIdx_10) ,ModelStates_10[8],ModelStates_10[9]);} if(cBoolModel[PIdx_10 +1*SMemMat.N]){CuDerivModel_cad(dt, v_10,ModelStates_10[2],ModelStates_10[9],ModelStates_10[8]);} if(cBoolModel[PIdx_10 +2*SMemMat.N]){CuDerivModel_kca(dt, v_10,ModelStates_10[3],param_macro(2,PIdx_10) ,param_macro(3,PIdx_10) ,param_macro(4,PIdx_10) ,param_macro(5,PIdx_10) ,ModelStates_10[8]);} if(cBoolModel[PIdx_10 +3*SMemMat.N]){CuDerivModel_km(dt, v_10,ModelStates_10[4],param_macro(6,PIdx_10) ,param_macro(7,PIdx_10) ,param_macro(8,PIdx_10) ,param_macro(9,PIdx_10) ,param_macro(10,PIdx_10) );} if(cBoolModel[PIdx_10 +4*SMemMat.N]){CuDerivModel_kv(dt, v_10,ModelStates_10[5],param_macro(11,PIdx_10) ,param_macro(12,PIdx_10) ,param_macro(13,PIdx_10) ,param_macro(14,PIdx_10) ,param_macro(15,PIdx_10) );} if(cBoolModel[PIdx_10 +5*SMemMat.N]){CuDerivModel_na(dt, v_10,ModelStates_10[6],ModelStates_10[7],param_macro(16,PIdx_10) ,param_macro(17,PIdx_10) ,param_macro(18,PIdx_10) ,param_macro(19,PIdx_10) ,param_macro(20,PIdx_10) ,param_macro(21,PIdx_10) ,param_macro(22,PIdx_10) ,param_macro(23,PIdx_10) ,param_macro(24,PIdx_10) ,param_macro(25,PIdx_10) ,param_macro(26,PIdx_10) ,param_macro(27,PIdx_10) );} if(cBoolModel[PIdx_10 +6*SMemMat.N]){CuDerivModel_pas(dt, v_10,param_macro(28,PIdx_10) ,param_macro(29,PIdx_10) );}  if(cBoolModel[PIdx_11 +0*SMemMat.N]){CuDerivModel_ca(dt, v_11,ModelStates_11[0],ModelStates_11[1],param_macro(0,PIdx_11) ,param_macro(1,PIdx_11) ,ModelStates_11[8],ModelStates_11[9]);} if(cBoolModel[PIdx_11 +1*SMemMat.N]){CuDerivModel_cad(dt, v_11,ModelStates_11[2],ModelStates_11[9],ModelStates_11[8]);} if(cBoolModel[PIdx_11 +2*SMemMat.N]){CuDerivModel_kca(dt, v_11,ModelStates_11[3],param_macro(2,PIdx_11) ,param_macro(3,PIdx_11) ,param_macro(4,PIdx_11) ,param_macro(5,PIdx_11) ,ModelStates_11[8]);} if(cBoolModel[PIdx_11 +3*SMemMat.N]){CuDerivModel_km(dt, v_11,ModelStates_11[4],param_macro(6,PIdx_11) ,param_macro(7,PIdx_11) ,param_macro(8,PIdx_11) ,param_macro(9,PIdx_11) ,param_macro(10,PIdx_11) );} if(cBoolModel[PIdx_11 +4*SMemMat.N]){CuDerivModel_kv(dt, v_11,ModelStates_11[5],param_macro(11,PIdx_11) ,param_macro(12,PIdx_11) ,param_macro(13,PIdx_11) ,param_macro(14,PIdx_11) ,param_macro(15,PIdx_11) );} if(cBoolModel[PIdx_11 +5*SMemMat.N]){CuDerivModel_na(dt, v_11,ModelStates_11[6],ModelStates_11[7],param_macro(16,PIdx_11) ,param_macro(17,PIdx_11) ,param_macro(18,PIdx_11) ,param_macro(19,PIdx_11) ,param_macro(20,PIdx_11) ,param_macro(21,PIdx_11) ,param_macro(22,PIdx_11) ,param_macro(23,PIdx_11) ,param_macro(24,PIdx_11) ,param_macro(25,PIdx_11) ,param_macro(26,PIdx_11) ,param_macro(27,PIdx_11) );} if(cBoolModel[PIdx_11 +6*SMemMat.N]){CuDerivModel_pas(dt, v_11,param_macro(28,PIdx_11) ,param_macro(29,PIdx_11) );}  if(cBoolModel[PIdx_12 +0*SMemMat.N]){CuDerivModel_ca(dt, v_12,ModelStates_12[0],ModelStates_12[1],param_macro(0,PIdx_12) ,param_macro(1,PIdx_12) ,ModelStates_12[8],ModelStates_12[9]);} if(cBoolModel[PIdx_12 +1*SMemMat.N]){CuDerivModel_cad(dt, v_12,ModelStates_12[2],ModelStates_12[9],ModelStates_12[8]);} if(cBoolModel[PIdx_12 +2*SMemMat.N]){CuDerivModel_kca(dt, v_12,ModelStates_12[3],param_macro(2,PIdx_12) ,param_macro(3,PIdx_12) ,param_macro(4,PIdx_12) ,param_macro(5,PIdx_12) ,ModelStates_12[8]);} if(cBoolModel[PIdx_12 +3*SMemMat.N]){CuDerivModel_km(dt, v_12,ModelStates_12[4],param_macro(6,PIdx_12) ,param_macro(7,PIdx_12) ,param_macro(8,PIdx_12) ,param_macro(9,PIdx_12) ,param_macro(10,PIdx_12) );} if(cBoolModel[PIdx_12 +4*SMemMat.N]){CuDerivModel_kv(dt, v_12,ModelStates_12[5],param_macro(11,PIdx_12) ,param_macro(12,PIdx_12) ,param_macro(13,PIdx_12) ,param_macro(14,PIdx_12) ,param_macro(15,PIdx_12) );} if(cBoolModel[PIdx_12 +5*SMemMat.N]){CuDerivModel_na(dt, v_12,ModelStates_12[6],ModelStates_12[7],param_macro(16,PIdx_12) ,param_macro(17,PIdx_12) ,param_macro(18,PIdx_12) ,param_macro(19,PIdx_12) ,param_macro(20,PIdx_12) ,param_macro(21,PIdx_12) ,param_macro(22,PIdx_12) ,param_macro(23,PIdx_12) ,param_macro(24,PIdx_12) ,param_macro(25,PIdx_12) ,param_macro(26,PIdx_12) ,param_macro(27,PIdx_12) );} if(cBoolModel[PIdx_12 +6*SMemMat.N]){CuDerivModel_pas(dt, v_12,param_macro(28,PIdx_12) ,param_macro(29,PIdx_12) );}  if(cBoolModel[PIdx_13 +0*SMemMat.N]){CuDerivModel_ca(dt, v_13,ModelStates_13[0],ModelStates_13[1],param_macro(0,PIdx_13) ,param_macro(1,PIdx_13) ,ModelStates_13[8],ModelStates_13[9]);} if(cBoolModel[PIdx_13 +1*SMemMat.N]){CuDerivModel_cad(dt, v_13,ModelStates_13[2],ModelStates_13[9],ModelStates_13[8]);} if(cBoolModel[PIdx_13 +2*SMemMat.N]){CuDerivModel_kca(dt, v_13,ModelStates_13[3],param_macro(2,PIdx_13) ,param_macro(3,PIdx_13) ,param_macro(4,PIdx_13) ,param_macro(5,PIdx_13) ,ModelStates_13[8]);} if(cBoolModel[PIdx_13 +3*SMemMat.N]){CuDerivModel_km(dt, v_13,ModelStates_13[4],param_macro(6,PIdx_13) ,param_macro(7,PIdx_13) ,param_macro(8,PIdx_13) ,param_macro(9,PIdx_13) ,param_macro(10,PIdx_13) );} if(cBoolModel[PIdx_13 +4*SMemMat.N]){CuDerivModel_kv(dt, v_13,ModelStates_13[5],param_macro(11,PIdx_13) ,param_macro(12,PIdx_13) ,param_macro(13,PIdx_13) ,param_macro(14,PIdx_13) ,param_macro(15,PIdx_13) );} if(cBoolModel[PIdx_13 +5*SMemMat.N]){CuDerivModel_na(dt, v_13,ModelStates_13[6],ModelStates_13[7],param_macro(16,PIdx_13) ,param_macro(17,PIdx_13) ,param_macro(18,PIdx_13) ,param_macro(19,PIdx_13) ,param_macro(20,PIdx_13) ,param_macro(21,PIdx_13) ,param_macro(22,PIdx_13) ,param_macro(23,PIdx_13) ,param_macro(24,PIdx_13) ,param_macro(25,PIdx_13) ,param_macro(26,PIdx_13) ,param_macro(27,PIdx_13) );} if(cBoolModel[PIdx_13 +6*SMemMat.N]){CuDerivModel_pas(dt, v_13,param_macro(28,PIdx_13) ,param_macro(29,PIdx_13) );}

 
 
    }
	//This one looks suspicious but leaving it and will check it later.
   for(int recInd =0;recInd<sim.NRecSites;recInd++){
		VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) +threadIdx.y*Nt*sim.NRecSites+recInd*Nt + Nt-WARPSIZE+PIdx_1]=SMemVHot[WARPSIZE*recInd + PIdx_1];
	}
 
}

__global__ void NeuroGPUKernel(Stim stim,  Sim sim, HMat InMat, MYFTYPE *V,MYFTYPE* VHotGlobal,MYDTYPE CompDepth,MYDTYPE CompFDepth,cudaTextureObject_t tex)
{
	HMat SMemMat;
	MYFTYPE *Vs,*amps,*SMemVHot;
	MYDTYPE offset;
	
	
	offset = InitializeDeviceMemory(stim,sim,InMat,VHotGlobal,CompDepth,CompFDepth,&SMemMat,Vs,amps,SMemVHot);
	runSimulation(SMemMat,InMat,V,stim,sim,VHotGlobal,SMemVHot,amps,offset,tex);

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
	cudaStatus = cudaSetDevice(1);
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
	//cudaStatus = cudaMalloc((void**)&VHotsGlobal, NSets*Nt *stim.NStimuli* sizeof(MYFTYPE));
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
	cudaStatus = cudaMemcpyToSymbol(cE, InMat.e, 416 * sizeof(MYSECONDFTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.f, InMat.f, InMat.N * sizeof(MYSECONDFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cF, InMat.f, 416 * sizeof(MYSECONDFTYPE));
	cudaStatus = cudaMemcpyToSymbol(cKs, InMat.Ks, 416 * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.Ks, InMat.Ks, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	//cudaStatus = cudaMemcpy(Mat_d.SegToComp, InMat.SegToComp, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cSegToComp, InMat.SegToComp, InMat.N * sizeof(MYDTYPE));
	//cudaStatus = cudaMemcpy(Mat_d.boolModel, InMat.boolModel, InMat.N * InMat.NModels * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpyToSymbol(cBoolModel, InMat.boolModel, InMat.N * InMat.NModels * sizeof(MYDTYPE));

	cudaStatus = cudaMemcpyToSymbol(cCm, InMat.Cms, 416 * sizeof(MYFTYPE));
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

	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);  // uHP (Diag)
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE); // bHP (rhs)
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE)+1)*sizeof(MYSECONDFTYPE);
	//offset+=InMat.N*sizeof(MYFTYPE); // Vs

	offset+=WARPSIZE*sim.NRecSites*sizeof(MYFTYPE);//SMemVHot
#ifdef STIMFROMFILE
    offset+=WARPSIZE*sizeof(MYFTYPE);//amps
#endif // STIMFROMFILE
	MYDTYPE PerStimulus=offset-FrameworkMemSize;
	
	MYDTYPE TotalSMem=FrameworkMemSize+PerStimulus*stim.NStimuli;
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
	MYFTYPE *d_modelParams;
	cudaStatus = cudaMalloc((void**)&d_modelParams, NPARAMS * InMat.NComps *NSets * sizeof(MYFTYPE));
	
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}


	// copying
	
	//cudaStatus = cudaMemcpy(d_modelParams, ParamsM, NPARAMS * InMat.NComps * NSets *sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaChannelFormatDesc channelDesc = cudaCreateChannelDesc(32, 0, 0, 0, cudaChannelFormatKindFloat);
	cudaArray* paramsArr;
    cudaMallocArray(&paramsArr, &channelDesc, NPARAMS * InMat.NComps, NKERNEL);



	// create texture object
	cudaResourceDesc resDesc;
	memset(&resDesc, 0, sizeof(resDesc));

	resDesc.resType = cudaResourceTypeArray; 
	resDesc.res.array.array = paramsArr;
	cudaMemcpyToArray(paramsArr, 0, 0, ParamsM, NPARAMS * InMat.NComps *NKERNEL * sizeof(MYFTYPE),
                      cudaMemcpyHostToDevice);

	cudaTextureDesc texDesc;
	memset(&texDesc, 0, sizeof(texDesc));
	texDesc.readMode = cudaReadModeElementType;
	cudaTextureObject_t tex;
	cudaCreateTextureObject(&tex, &resDesc, &texDesc, NULL);

	if(streamID==0){
		
	
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream0>>>(stim_d, sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth,tex); // RRR	
	
	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream0); 
		
	}
	if(streamID==1){
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream1>>>(stim_d, sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth,tex); // RRR

	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream1); 

	}
	if(streamID==2){
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream2>>>(stim_d,  sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth,tex); // RRR
	
	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt *sim.NRecSites *  stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream2); 

	}
	if(streamID==3){
	NeuroGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream3>>>(stim_d, sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth,tex); // RRR
	
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
	
	  stEfork2TimeLoopGPU(stim, sim, ParamsM, InMat, V,CompDepth,CompFDepth,NSets); //RRR sim
	  
	
	


	return cudaStatus;
}
