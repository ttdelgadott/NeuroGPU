#include "CudaStuff.cuh"
#include "AllModels.cu"
#include "AllModels.cuh"


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
	CurJ = InMat.CompByLevel32[2]-1;
	LRelIndex=InMat.LRelStarts[CurLevel];
	LRelIndex=LRelIndex+InMat.LRelEnds[CurLevel];
	for(CurLevel=0;CurLevel<=Depth;CurLevel++) {
		
		for(LRelIndex=InMat.LRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
		//for(LRelIndex=InMat.LRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
			JumctionI=InMat.CompByLevel32[LRelIndex*WARPSIZE+PIdx]-1;
			for(i=InMat.SegStartI[JumctionI]-1;i<InMat.SegEndI[JumctionI];i++) {
				MYSECONDFTYPE uHPm1=uHP[i-1];
			
				uHP[i]=uHP[i]-InMat.e[i-1]*(InMat.f[i-1]/uHPm1); // So far same as paper parallel
				uHPm1=uHP[i-1];
				MYSECONDFTYPE bHPm1=bHP[i-1];
				bHP[i]=bHP[i]-bHPm1*InMat.e[i-1]/uHPm1; // bH is y
			}
		}
		if(CurLevel<Depth) {
			for(LRelIndex=InMat.FLRelStarts[CurLevel];LRelIndex<=InMat.FLRelEnds[CurLevel];LRelIndex++){ 
				CurB=InMat.CompByFLevel32[(LRelIndex)*WARPSIZE+PIdx]-1;//RB i inserted another  -1 into the index RB 2 i removed the-1 from the curlevel 
				CurJ=InMat.Fathers[CurB]-1;
				MYDTYPE St=InMat.RelStarts[CurB];
				MYDTYPE En=InMat.RelEnds[CurB];
				for(j=St;j<=En;j++) {
					t=InMat.RelVec[j-1]-1;
					MYSECONDFTYPE uHPm1=uHP[t-1];
					uHP[CurJ]-=InMat.e[t-1]*(InMat.f[t-1]/uHPm1); 
					uHPm1=uHP[t-1];
					MYSECONDFTYPE bHPm1=bHP[t-1];
					bHP[CurJ]-=bHPm1*InMat.e[t-1]/uHPm1; 
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
	// PX[PIdx_1]=PX[PIdx_1]/PF[PIdx_1]; // PF[PIdx_1]=-InMat.f[PIdx_1]/PF[PIdx_1];
#define THISCOMMANDHERE2(VARILP) PX[PIdx_ ## VARILP ]=PX[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ]; PF[PIdx_ ## VARILP ]=-InMat.f[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE2)

	PX[InMat.N]=0;
	PF[InMat.N]=1;
	for(i=0;i<LognDepth;i++) {	
		// NextID_1=InMat.FIdxs[i*InMat.N+PIdx_1]-1; // MYFTYPE OldPXj_1=PX[PIdx_1]; // MYFTYPE OldPXNextID_1=PX[NextID_1]; // PX[PIdx_1]=OldPXj_1+OldPXNextID_1*PF[PIdx_1];
#define THISCOMMANDHERE3(VARILP) NextID_ ## VARILP =InMat.FIdxs[i*InMat.N+PIdx_ ## VARILP ]-1; MYFTYPE OldPXj_ ## VARILP =PX[PIdx_ ## VARILP ]; MYFTYPE OldPXNextID_ ## VARILP =PX[NextID_ ## VARILP ]; PX[PIdx_ ## VARILP ]=OldPXj_ ## VARILP +OldPXNextID_ ## VARILP *PF[PIdx_ ## VARILP ];
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
  for(LRelIndex=InMat.LRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
   JumctionI=InMat.CompByLevel32[LRelIndex*WARPSIZE+PIdx_1]-1;
   // for i=(SegEndI(JumctionI)):-1:(SegStartI(JumctionI)-1)
   for(i=InMat.SegEndI[JumctionI]-1;i>=(InMat.SegStartI[JumctionI]-2);i--) {
    // k=KsB(i+1);
     k=InMat.KsB[i+1];
	 
    // bPX(i)=(bH(i)-bPX(k)*f(i))/uH(i);
   Out[i]=(bHP[i]-Out[k]*InMat.f[i])/uHP[i];
   }
  }
 }
 } 

#endif

__device__ MYDTYPE InitializeDeviceMemory(Stim stim,Sim sim, HMat InMat,MYFTYPE* VHotGlobal,MYDTYPE CompDepth,MYDTYPE CompFDepth,HMat *SMemMat, MYFTYPE* Vs,MYFTYPE* amps,MYFTYPE* SMemVHot)
{
	//Configure IDs 

	MYDTYPE StimID=threadIdx.y;
	
#define THISCOMMANDHEREE1(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1));
	SUPERILPMACRO(THISCOMMANDHEREE1)
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
	SMemMat->e = (MYSECONDFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYSECONDFTYPE);
	//f indicates the subdiagonal.
	SMemMat->f = (MYSECONDFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYSECONDFTYPE);

	//Copy e,f from the device memory to the shared memory. - Move this to constant RBSConstant
	// SMemMat.e[PIdx_3]=InMat.e[PIdx_3]; // SMemMat.f[PIdx_3]=InMat.f[PIdx_3];
#define THISCOMMANDHEREE6(VARILP) SMemMat.e[PIdx_ ## VARILP ]=InMat.e[PIdx_ ## VARILP ]; SMemMat.f[PIdx_ ## VARILP ]=InMat.f[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE6)
	InMat.e=SMemMat->e;
	InMat.f=SMemMat->f;
	//Copy e,f from the device memory to the shared memory. - Move this to constant RBSConstant
	SMemMat->Cms = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
	
#define THISCOMMANDHEREE7(VARILP) SMemMat->Cms[PIdx_ ## VARILP ]=InMat.Cms[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE7)
	// discrete
	//BKSUB is the different parallelism we use
#ifdef BKSUB1
	//Copying FIdxs (Father indexes) from device to shared mem
		SMemMat->FIdxs = (MYDTYPE*) &smem[offset];
		offset+=InMat.N*SMemMat->LognDepth*sizeof(MYDTYPE);
		for(int i=0;i<SMemMat->LognDepth;i++) {
			// SMemMat->FIdxs[i*InMat.N+PIdx_3]=InMat.FIdxs[i*InMat.N+PIdx_3];
#define THISCOMMANDHEREE8(VARILP) SMemMat->FIdxs[i*InMat.N+PIdx_ ## VARILP ]=InMat.FIdxs[i*InMat.N+PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE8)
}
#endif 
#ifdef BKSUB2
		SMemMat->KsB =  (MYDTYPE*) &smem[offset];
		offset+=(SMemMat->N+1)*sizeof(MYDTYPE);		
		SMemMat->KsB[InMat.N]=InMat.KsB[InMat.N];

		// SMemMat->KsB[PIdx_3]=InMat.KsB[PIdx_3];
#define THISCOMMANDHEREE9(VARILP) SMemMat->KsB[PIdx_ ## VARILP ]=InMat.KsB[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE9)
#endif	
	//Copying Ks (ParentSegment) from device to shared
	SMemMat->Ks = (MYDTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYDTYPE);
	// SMemMat->Ks[PIdx_3]=InMat.Ks[PIdx_3];
#define THISCOMMANDHEREE10(VARILP) SMemMat->Ks[PIdx_ ## VARILP ]=InMat.Ks[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE10)
	
	//Copying SegToComp from device to shared
	SMemMat->SegToComp = (MYDTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYDTYPE);
	// SMemMat->Ks[PIdx_3]=InMat.Ks[PIdx_3];
#define THISCOMMANDHEREE11(VARILP) SMemMat->SegToComp[PIdx_ ## VARILP ]=InMat.SegToComp[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE11)
	SMemMat->boolModel= (MYDTYPE*) &smem[offset];
	offset+=InMat.N*SMemMat->NModels*sizeof(MYDTYPE);
	// SMemMat->boolModel[PIdx_3]=InMat.boolModel[PIdx_3];
#define THISCOMMANDHEREE12(VARILP) for(int ii=0;ii<SMemMat->NModels;ii++) {SMemMat->boolModel[PIdx_ ## VARILP+ii*SMemMat->N]=InMat.boolModel[PIdx_ ## VARILP+ii*SMemMat->N];}
	SUPERILPMACRO(THISCOMMANDHERE12)
	
	SMemMat->RelStarts = (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	SMemMat->RelEnds = (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	SMemMat->RelVec = (MYDTYPE*) &smem[offset];
	offset+=InMat.nCallForFather*sizeof(MYDTYPE);
	SMemMat->SegStartI = (MYDTYPE*) &smem[offset];
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);
	SMemMat->SegEndI = (MYDTYPE*) &smem[offset];
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);

	SMemMat->Fathers= (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	// 3
	SMemMat->CompByLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	offset+=WARPSIZE*(CompDepth)*sizeof(MYDTYPE);
	SMemMat->CompByFLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	offset+=WARPSIZE*(CompFDepth)*sizeof(MYDTYPE);
	SMemMat->LRelStarts = (MYDTYPE*) &smem[offset];
	offset+=SMemMat->nLRel*sizeof(MYDTYPE);
	SMemMat->LRelEnds = (MYDTYPE*) &smem[offset];
	offset+=SMemMat->nLRel*sizeof(MYDTYPE);
	SMemMat->FLRelStarts = (MYDTYPE*) &smem[offset];
	offset+=SMemMat->nFLRel*sizeof(MYDTYPE);
	SMemMat->FLRelEnds = (MYDTYPE*) &smem[offset];
	offset+=SMemMat->nFLRel*sizeof(MYDTYPE);
	// Moving back to MYFTYPEs - make sure that the address is good for MYFTYPE (is modulu 4).
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	MYDTYPE ConstantMemSize=offset;
	//if(PIdx_1<InMat.nFathers) { SMemMat->RelStarts[PIdx_1]=InMat.RelStarts[PIdx_1];SMemMat->RelEnds[PIdx_1]=InMat.RelEnds[PIdx_1];SMemMat->Fathers[PIdx_1]=InMat.Fathers[PIdx_1];}
	#define THISCOMMANDHEREE13(VARILP) if(PIdx_ ## VARILP<InMat.nFathers){ SMemMat->RelStarts[PIdx_ ## VARILP]=InMat.RelStarts[PIdx_ ## VARILP];SMemMat->RelEnds[PIdx_ ## VARILP]=InMat.RelEnds[PIdx_ ## VARILP];SMemMat->Fathers[PIdx_ ## VARILP]=InMat.Fathers[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHERE13)
	//if(PIdx_1<InMat.nCallForFather) {SMemMat->RelVec[PIdx_1]=InMat.RelVec[PIdx_1];}
	#define THISCOMMANDHEREE14(VARILP) if(PIdx_ ## VARILP<InMat.nCallForFather){SMemMat->RelVec[PIdx_ ## VARILP]=InMat.RelVec[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHERE14)
	//if(PIdx_1<InMat.nCallForFather+1) {SMemMat->SegStartI[PIdx_1]=InMat.SegStartI[PIdx_1];SMemMat->SegEndI[PIdx_1]=InMat.SegEndI[PIdx_1];}
	#define THISCOMMANDHEREE15(VARILP) if(PIdx_ ## VARILP<InMat.nCallForFather+1){SMemMat->SegStartI[PIdx_ ## VARILP]=InMat.SegStartI[PIdx_ ## VARILP];SMemMat->SegEndI[PIdx_ ## VARILP]=InMat.SegEndI[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHERE15)
	__syncthreads();
	for(int i=0;i<CompDepth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByLevel32[WARPSIZE*i+PIdx_1];}
	//#define THISCOMMANDHEREE123(VARILP) for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_ ## VARILP]=InMat.CompByLevel32[WARPSIZE*i+PIdx_ ## VARILP];}
	//for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByLevel32[WARPSIZE*i+PIdx_1];}for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_2]=InMat.CompByLevel32[WARPSIZE*i+PIdx_2];}for(int i=0;i<=SMemMat->Depth;i++) {SMemMat->CompByLevel32[WARPSIZE*i+PIdx_3]=InMat.CompByLevel32[WARPSIZE*i+PIdx_3];}
	for(int i=0;i<CompFDepth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_1];}
	//#define THISCOMMANDHEREE124(VARILP) for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_ ## VARILP]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_ ## VARILP];}
	//for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_1];}for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_2]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_2];}for(int i=0;i<SMemMat->Depth;i++) {SMemMat->CompByFLevel32[WARPSIZE*i+PIdx_3]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_3];}
	//if(PIdx_1<InMat.nLRel) {SMemMat->LRelStarts[PIdx_1]=InMat.LRelStarts[PIdx_1];SMemMat->LRelEnds[PIdx_1]=InMat.LRelEnds[PIdx_1];}
	#define THISCOMMANDHEREE16(VARILP) if(PIdx_ ## VARILP<InMat.nLRel){SMemMat->LRelStarts[PIdx_ ## VARILP]=InMat.LRelStarts[PIdx_ ## VARILP];SMemMat->LRelEnds[PIdx_ ## VARILP]=InMat.LRelEnds[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHERE16)
	__syncthreads();
	//if(PIdx_1<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_1]=InMat.FLRelStarts[PIdx_1];SMemMat->FLRelEnds[PIdx_1]=InMat.FLRelEnds[PIdx_1];}
	#define THISCOMMANDHEREE1SMemMat17(VARILP) if(PIdx_ ## VARILP<InMat.nFLRel) {SMemMat->FLRelStarts[PIdx_ ## VARILP]=InMat.FLRelStarts[PIdx_ ## VARILP];SMemMat->FLRelEnds[PIdx_ ## VARILP]=InMat.FLRelEnds[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHERE17)

	//RBS This works now where all models are in the same comps we need to genreralize it.
	//RBS  This code should be generated with calling all models init and defining all states.
	return offset;
}	
__device__ void runSimulation(HMat SMemMat,HMat InMat,MYFTYPE* ParamsM,MYFTYPE* V,Stim stim,Sim sim,MYFTYPE* VHotGlobal,MYFTYPE* SMemVHot,MYFTYPE* amps,MYDTYPE offset)
{
	MYFTYPE *Vs;
	MYSECONDFTYPE *uHP,*bHP;
		// For solving the matrix
#ifdef BKSUB2
    MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(InMat.N+2*WARPSIZE)*sizeof(MYFTYPE);
#endif
#ifdef BKSUB1
   MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(InMat.N+WARPSIZE + sim.NRecSites*WARPSIZE)*sizeof(MYFTYPE);
#endif
	//MYDTYPE PerStimulus;
	//PerStimulus = InMat.N+2;
	offset+=PerStimulus*threadIdx.y;
	uHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	bHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	Vs = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
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
	#define THISCOMMANDHEREE18(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1));
	SUPERILPMACRO(THISCOMMANDHERE18)

	 #define THISCOMMANDHEREE19(VARILP) MYFTYPE isModel_ ## VARILP , dVec_ ## VARILP , Vmid_ ## VARILP ; MYFTYPE ModelStates_ ## VARILP [NSTATES]; MYFTYPE v_ ## VARILP =V[PIdx_ ## VARILP ]; MYFTYPE dv_ ## VARILP;
	SUPERILPMACRO(THISCOMMANDHERE19)

	 #define THISCOMMANDHEREE20(VARILP) MYSECONDFTYPE sumCurrents_ ## VARILP=0 ,sumCurrentsDv_ ## VARILP=0; MYFTYPE  sumConductivity_ ## VARILP=0 ,sumConductivityDv_ ## VARILP=0 ;
	SUPERILPMACRO(THISCOMMANDHERE20)
	// end for model in init
	SUPERILPMACRO(SET_STATES)
	#define THISCOMMANDHEREE21(VARILP) MYDTYPE SonNo_ ## VARILP =InMat.SonNoVec[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHERE21)
	
	#define THISCOMMANDHEREE22(VARILP) Vs[PIdx_ ## VARILP ]=V[PIdx_ ## VARILP ];bHP[PIdx_ ## VARILP]=0;dv_ ## VARILP =0;
	SUPERILPMACRO(THISCOMMANDHERE22)

	// MYDTYPE parentIndex_3; // MYDTYPE Eidx_3; // Eidx_3 = SMemMat.N-PIdx_3;
	#define THISCOMMANDHEREE23(VARILP) MYDTYPE parentIndex_ ## VARILP ; MYDTYPE Eidx_ ## VARILP ; Eidx_ ## VARILP = SMemMat.N-PIdx_ ## VARILP -1;
	SUPERILPMACRO(THISCOMMANDHERE23)
	// RRRXXX This probably should be in ILP too!
	if(Eidx_1>SMemMat.N-1){
		Eidx_1=SMemMat.N-1;
	}
	MYDTYPE perThreadParamMSize = SMemMat.NComps*NPARAMS;
	SUPERILPMACRO(SET_PARAMS001)
	SUPERILPMACRO(SET_PARAMS002)
	SUPERILPMACRO(SET_PARAMS003)
	SUPERILPMACRO(SET_PARAMS004)
	SUPERILPMACRO(SET_PARAMS005)
	SUPERILPMACRO(SET_PARAMS006)
	SUPERILPMACRO(SET_PARAMS007)
	SUPERILPMACRO(SET_PARAMS008)
	SUPERILPMACRO(SET_PARAMS009)
	SUPERILPMACRO(SET_PARAMS010)
	SUPERILPMACRO(SET_PARAMS011)
	SUPERILPMACRO(SET_PARAMS012)
	SUPERILPMACRO(SET_PARAMS013)
	SUPERILPMACRO(SET_PARAMS014)
	SUPERILPMACRO(SET_PARAMS015)
	SUPERILPMACRO(SET_PARAMS016)
	SUPERILPMACRO(SET_PARAMS017)
	SUPERILPMACRO(SET_PARAMS018)
	SUPERILPMACRO(SET_PARAMS019)
	SUPERILPMACRO(SET_PARAMS020)
	SUPERILPMACRO(SET_PARAMS021)
	SUPERILPMACRO(SET_PARAMS022)
	SUPERILPMACRO(SET_PARAMS023)
	SUPERILPMACRO(SET_PARAMS024)
	SUPERILPMACRO(SET_PARAMS025)
	SUPERILPMACRO(SET_PARAMS026)
	SUPERILPMACRO(SET_PARAMS027)
	SUPERILPMACRO(SET_PARAMS028)
	SUPERILPMACRO(SET_PARAMS029)
	SUPERILPMACRO(SET_PARAMS030)
	SUPERILPMACRO(CALL_TO_INIT_STATES_CU)
	
		// parentIndex_3 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_3];
#define THISCOMMANDHEREE24(VARILP) parentIndex_ ## VARILP =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_ ## VARILP ];
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
#define THISCOMMANDHEREE25(VARILP) MYSECONDFTYPE rhs_ ## VARILP ,D_ ## VARILP; MYFTYPE gModel_ ## VARILP ,StimCurrent_ ## VARILP;
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
			SMemVHot[recInd*WARPSIZE+i%(WARPSIZE)]=Vs[sim.RecSites[recInd]];
		}
		 // rhs_3=0; // D_3=0;// StimCurrent_3=0;
#define THISCOMMANDHEREE26(VARILP) rhs_ ## VARILP =0; D_ ## VARILP =0; sumCurrents_ ## VARILP=0; sumConductivity_ ## VARILP=0; sumCurrentsDv_ ## VARILP=0; sumConductivityDv_ ## VARILP=0;StimCurrent_ ## VARILP =0;
	SUPERILPMACRO(THISCOMMANDHERE26)
		// Before matrix
		// if(t>=stimDel && t<stimDel+stimDur && PIdx_3 == stimLoc){StimCurrent_3 = 100*stimAmp/stimArea;}
#ifndef STIMFROMFILE
    #define THISCOMMANDHEREE27(VARILP) if(t>=stimDel && t<stimDel+stimDur && PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP  = 100*stimAmp/stimArea;}
	SUPERILPMACRO(THISCOMMANDHERE27)
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
    
    #define THISCOMMANDHEREE28(VARILP) if(PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP = 100*amps[i%WARPSIZE]/stimArea;}
	SUPERILPMACRO(THISCOMMANDHERE28)
#endif // STIMFROMFILE
	SUPERILPMACRO(CALL_TO_BREAK_DV_CU)
	SUPERILPMACRO(CALL_TO_BREAK_CU)

	// gModel_3 = (sumCurrentsDv_3-sumCurrents_3)/0.001; 
#define THISCOMMANDHEREE29(VARILP) gModel_ ## VARILP  = (sumCurrentsDv_ ## VARILP -sumCurrents_ ## VARILP )/EPS_V;  
	SUPERILPMACRO(THISCOMMANDHERE29)
	
#define THISCOMMANDHEREE30(VARILP) rhs_ ## VARILP =StimCurrent_ ## VARILP -sumCurrents_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHERE30)
#define THISCOMMANDHEREE31(VARILP) D_ ## VARILP =gModel_ ## VARILP +SMemMat.Cms[PIdx_ ## VARILP ]/(dt*1000); D_ ## VARILP -=SMemMat.f[SMemMat.N-PIdx_ ## VARILP -1];
	SUPERILPMACRO(THISCOMMANDHERE31)
   
    //this should be out and correct SMemMat.Ks
	if(PIdx_1==0) {
		parentIndex_1=0;
	};
#define THISCOMMANDHEREE32(VARILP)  dv_ ## VARILP +=bHP[SMemMat.N-parentIndex_ ## VARILP -1]-bHP[SMemMat.N-PIdx_ ## VARILP -1]; rhs_ ## VARILP -=SMemMat.f[SMemMat.N-PIdx_ ## VARILP -1]*dv_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHERE32)
		// D_3=sumConductivity_3+SMemMat.Cms[PIdx_3]/(sim.dt*1000); // D_3-=SMemMat.f[SMemMat.N-PIdx_3-1];
		// bHP[SMemMat.N-PIdx_3-1]=rhs_3; // uHP[SMemMat.N-PIdx_3-1]=D_3;
#define THISCOMMANDHEREE33(VARILP) bHP[SMemMat.N-PIdx_ ## VARILP -1]=rhs_ ## VARILP ; uHP[SMemMat.N-PIdx_ ## VARILP -1]=D_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE33)
		syncthreads();
		// if(SonNo_3==1) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#define THISCOMMANDHEREE34(VARILP) if(SonNo_ ## VARILP ==1) {bHP[SMemMat.N-parentIndex_ ## VARILP -1]+=SMemMat.e[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[SMemMat.N-parentIndex_ ## VARILP -1]-=SMemMat.e[Eidx_ ## VARILP ];}
		SUPERILPMACRO(THISCOMMANDHERE34)
		// if(SonNo_3==2) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#define THISCOMMANDHEREE35(VARILP) if(SonNo_ ## VARILP ==2) {bHP[SMemMat.N-parentIndex_ ## VARILP -1]+=SMemMat.e[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[SMemMat.N-parentIndex_ ## VARILP -1]-=SMemMat.e[Eidx_ ## VARILP ];}
		SUPERILPMACRO(THISCOMMANDHERE35)
		syncthreads();
		BeforeLU(SMemMat,uHP,bHP,SMemMat.Depth);
#ifdef BKSUB1
		BkSub(SMemMat, PX,PF,uHP,bHP,SMemMat.LognDepth);
		#define THISCOMMANDHEREE36(VARILP) Vmid_ ## VARILP =PX[SMemMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ; Vs[PIdx_ ## VARILP ]+=Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE36)
#endif

		
#ifdef BKSUB2
		#define THISCOMMANDHEREE37(VARILP) MYFTYPE vTemp_ ## VARILP=Vs[PIdx_ ## VARILP];
		SUPERILPMACRO(THISCOMMANDHERE37)
		syncthreads();
		BkSub(SMemMat,uHP,bHP,Vs,SMemMat.Depth);
		syncthreads();
		PX=Vs;

#define THISCOMMANDHEREE38(VARILP) Vmid_ ## VARILP =PX[SMemMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE38)
		syncthreads(); 
#define THISCOMMANDHEREE39(VARILP) Vs[PIdx_ ## VARILP ]= vTemp_ ## VARILP +Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHERE39)
#endif		
            t+=0.5*dt;

        

//      if(SMemMat.boolModel[PIdx_1 +0*SMemMat.N]){CuDerivModel_ca(dt, v_1,ModelStates_1[0],ModelStates_1[1],p0_1 ,p1_1 ,ModelStates_1[8],ModelStates_1[9]);} if(SMemMat.boolModel[PIdx_1 +1*SMemMat.N]){CuDerivModel_cad(dt, v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(SMemMat.boolModel[PIdx_1 +2*SMemMat.N]){CuDerivModel_kca(dt, v_1,ModelStates_1[3],p2_1 ,p3_1 ,p4_1 ,p5_1 ,ModelStates_1[8]);} if(SMemMat.boolModel[PIdx_1 +3*SMemMat.N]){CuDerivModel_km(dt, v_1,ModelStates_1[4],p6_1 ,p7_1 ,p8_1 ,p9_1 ,p10_1 );} if(SMemMat.boolModel[PIdx_1 +4*SMemMat.N]){CuDerivModel_kv(dt, v_1,ModelStates_1[5],p11_1 ,p12_1 ,p13_1 ,p14_1 ,p15_1 );} if(SMemMat.boolModel[PIdx_1 +5*SMemMat.N]){CuDerivModel_na(dt, v_1,ModelStates_1[6],ModelStates_1[7],p16_1 ,p17_1 ,p18_1 ,p19_1 ,p20_1 ,p21_1 ,p22_1 ,p23_1 ,p24_1 ,p25_1 ,p26_1 ,p27_1 );}  if(SMemMat.boolModel[PIdx_2 +0*SMemMat.N]){CuDerivModel_ca(dt, v_2,ModelStates_2[0],ModelStates_2[1],p0_2 ,p1_2 ,ModelStates_2[8],ModelStates_2[9]);} if(SMemMat.boolModel[PIdx_2 +1*SMemMat.N]){CuDerivModel_cad(dt, v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(SMemMat.boolModel[PIdx_2 +2*SMemMat.N]){CuDerivModel_kca(dt, v_2,ModelStates_2[3],p2_2 ,p3_2 ,p4_2 ,p5_2 ,ModelStates_2[8]);} if(SMemMat.boolModel[PIdx_2 +3*SMemMat.N]){CuDerivModel_km(dt, v_2,ModelStates_2[4],p6_2 ,p7_2 ,p8_2 ,p9_2 ,p10_2 );} if(SMemMat.boolModel[PIdx_2 +4*SMemMat.N]){CuDerivModel_kv(dt, v_2,ModelStates_2[5],p11_2 ,p12_2 ,p13_2 ,p14_2 ,p15_2 );} if(SMemMat.boolModel[PIdx_2 +5*SMemMat.N]){CuDerivModel_na(dt, v_2,ModelStates_2[6],ModelStates_2[7],p16_2 ,p17_2 ,p18_2 ,p19_2 ,p20_2 ,p21_2 ,p22_2 ,p23_2 ,p24_2 ,p25_2 ,p26_2 ,p27_2 );}  if(SMemMat.boolModel[PIdx_3 +0*SMemMat.N]){CuDerivModel_ca(dt, v_3,ModelStates_3[0],ModelStates_3[1],p0_3 ,p1_3 ,ModelStates_3[8],ModelStates_3[9]);} if(SMemMat.boolModel[PIdx_3 +1*SMemMat.N]){CuDerivModel_cad(dt, v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(SMemMat.boolModel[PIdx_3 +2*SMemMat.N]){CuDerivModel_kca(dt, v_3,ModelStates_3[3],p2_3 ,p3_3 ,p4_3 ,p5_3 ,ModelStates_3[8]);} if(SMemMat.boolModel[PIdx_3 +3*SMemMat.N]){CuDerivModel_km(dt, v_3,ModelStates_3[4],p6_3 ,p7_3 ,p8_3 ,p9_3 ,p10_3 );} if(SMemMat.boolModel[PIdx_3 +4*SMemMat.N]){CuDerivModel_kv(dt, v_3,ModelStates_3[5],p11_3 ,p12_3 ,p13_3 ,p14_3 ,p15_3 );} if(SMemMat.boolModel[PIdx_3 +5*SMemMat.N]){CuDerivModel_na(dt, v_3,ModelStates_3[6],ModelStates_3[7],p16_3 ,p17_3 ,p18_3 ,p19_3 ,p20_3 ,p21_3 ,p22_3 ,p23_3 ,p24_3 ,p25_3 ,p26_3 ,p27_3 );}
		SUPERILPMACRO(CALL_TO_DERIV_CU)
#endif
 
 
    }
	//This one looks suspicious but leaving it and will check it later.
   for(int recInd =0;recInd<sim.NRecSites;recInd++){
		VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) +threadIdx.y*Nt*sim.NRecSites+recInd*Nt + Nt-WARPSIZE+PIdx_1]=SMemVHot[WARPSIZE*recInd + PIdx_1];
	}
 
}	
	
__global__ void stEfork2TimeLoopGPUKernel(Stim stim, MYFTYPE* ParamsM, Sim sim, HMat InMat, MYFTYPE *V,MYFTYPE* VHotGlobal,MYDTYPE CompDepth,MYDTYPE CompFDepth)
{
	MYDTYPE StimID=threadIdx.y;
	MYDTYPE NeuronID = blockIdx.x;

	
	// MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2);

	MYFTYPE t=0;
	
	// MYFTYPE isModel_3, dVec_3, Vmid_3; // MYFTYPE ModelStates_3[NSTATES]; // MYFTYPE v_3=V[PIdx_3]; // RRR -65?
#ifdef HH
#define THISCOMMANDHEREE2(VARILP) MYFTYPE isModel_ ## VARILP , dVec_ ## VARILP , Vmid_ ## VARILP ; MYFTYPE ModelStates_ ## VARILP [NSTATES]; MYFTYPE v_ ## VARILP =V[PIdx_ ## VARILP ]; MYFTYPE dv_ ## VARILP;
	SUPERILPMACRO(THISCOMMANDHEREE2)
#endif
#ifdef PAS
#define THISCOMMANDHEREE2(VARILP) MYFTYPE isModel_ ## VARILP , dVec_ ## VARILP , Vmid_ ## VARILP ;  MYSECONDFTYPE v_ ## VARILP =V[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE2)
#endif
	__shared__ HMat SMemMat;
	SMemMat.N=InMat.N;
	SMemMat.NComps=InMat.NComps;
	SMemMat.Depth=InMat.Depth;
	SMemMat.NModels=InMat.NModels;
	SMemMat.LognDepth=InMat.LognDepth;
	SMemMat.nFathers=InMat.nFathers;
	SMemMat.nCallForFather=InMat.nCallForFather;
	SMemMat.nLRel=InMat.nLRel;
	SMemMat.nFLRel=InMat.nFLRel;
	// RRRXXX Put in a FOR loop, up to NPARAM or something like that
	// MYFTYPE p1_3,p2_3,p3_3,p4_3,p5_3,p6_3; // p1_3=ParamsM[0*SMemMat.N+PIdx_3]; // p2_3=ParamsM[1*SMemMat.N+PIdx_3]; // p3_3=ParamsM[2*SMemMat.N+PIdx_3]; // p5_3=ParamsM[4*SMemMat.N+PIdx_3]; // p6_3=ParamsM[5*SMemMat.N+PIdx_3];
#ifdef HH
	//RBS This code should be generated with the number of params now 17
	

#endif

#ifdef PAS
#define THISCOMMANDHEREE3(VARILP) MYFTYPE p1_ ## VARILP ,p2_ ## VARILP; p1_ ## VARILP =ParamsM[0*SMemMat.N+PIdx_ ## VARILP ]; p2_ ## VARILP =ParamsM[1*SMemMat.N+PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE3)
#endif
	// MYFTYPE sumCurrents_3, sumConductivity_3; // MYFTYPE sumCurrentsDv_3, sumConductivityDv_3;
#define THISCOMMANDHEREE5(VARILP) MYSECONDFTYPE sumCurrents_ ## VARILP=0 ,sumCurrentsDv_ ## VARILP=0; MYFTYPE  sumConductivity_ ## VARILP=0 ,sumConductivityDv_ ## VARILP=0 ;
	SUPERILPMACRO(THISCOMMANDHEREE5)
	// end for model in init
	MYDTYPE offset=0;
	// CONSTANTS
	// MYFTYPEs
	
	SMemMat.e = (MYSECONDFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYSECONDFTYPE);
	SMemMat.f = (MYSECONDFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYSECONDFTYPE);
	// SMemMat.e[PIdx_3]=InMat.e[PIdx_3]; // SMemMat.f[PIdx_3]=InMat.f[PIdx_3];
#define THISCOMMANDHEREE6(VARILP) SMemMat.e[PIdx_ ## VARILP ]=InMat.e[PIdx_ ## VARILP ]; SMemMat.f[PIdx_ ## VARILP ]=InMat.f[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE6)

	InMat.e=SMemMat.e;
	InMat.f=SMemMat.f;
	SMemMat.Cms = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);

	// SMemMat.Cms[PIdx_3]=InMat.Cms[PIdx_3];
#define THISCOMMANDHEREE7(VARILP) SMemMat.Cms[PIdx_ ## VARILP ]=InMat.Cms[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE7)
	
	// 1

	// discrete
#ifdef BKSUB1
		SMemMat.FIdxs = (MYDTYPE*) &smem[offset];
		offset+=InMat.N*SMemMat.LognDepth*sizeof(MYDTYPE);
		for(int i=0;i<SMemMat.LognDepth;i++) {
			// SMemMat.FIdxs[i*InMat.N+PIdx_3]=InMat.FIdxs[i*InMat.N+PIdx_3];
#define THISCOMMANDHEREE8(VARILP) SMemMat.FIdxs[i*InMat.N+PIdx_ ## VARILP ]=InMat.FIdxs[i*InMat.N+PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE8)
	}
#endif 
#ifdef BKSUB2
		SMemMat.KsB =  (MYDTYPE*) &smem[offset];
		offset+=(SMemMat.N+1)*sizeof(MYDTYPE);		
		SMemMat.KsB[InMat.N]=InMat.KsB[InMat.N];

		// SMemMat.KsB[PIdx_3]=InMat.KsB[PIdx_3];
#define THISCOMMANDHEREE9(VARILP) SMemMat.KsB[PIdx_ ## VARILP ]=InMat.KsB[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE9)

#endif
	SMemMat.Ks = (MYDTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYDTYPE);

	// SMemMat.Ks[PIdx_3]=InMat.Ks[PIdx_3];
#define THISCOMMANDHEREE10(VARILP) SMemMat.Ks[PIdx_ ## VARILP ]=InMat.Ks[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE10)

	SMemMat.SegToComp = (MYDTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYDTYPE);

	// SMemMat.Ks[PIdx_3]=InMat.Ks[PIdx_3];
#define THISCOMMANDHEREE10A(VARILP) SMemMat.SegToComp[PIdx_ ## VARILP ]=InMat.SegToComp[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE10A)

	SMemMat.boolModel= (MYDTYPE*) &smem[offset];
	offset+=InMat.N*SMemMat.NModels*sizeof(MYDTYPE);
	
	// SMemMat.boolModel[PIdx_3]=InMat.boolModel[PIdx_3];
#define THISCOMMANDHEREE11(VARILP) for(int ii=0;ii<SMemMat.NModels;ii++) {SMemMat.boolModel[PIdx_ ## VARILP+ii*SMemMat.N]=InMat.boolModel[PIdx_ ## VARILP+ii*SMemMat.N];}
	SUPERILPMACRO(THISCOMMANDHEREE11)

	// 2
	// MYDTYPE SonNo_3=InMat.SonNoVec[PIdx_3];
#define THISCOMMANDHEREE12(VARILP) MYDTYPE SonNo_ ## VARILP =InMat.SonNoVec[PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE12)

	
	SMemMat.RelStarts = (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	SMemMat.RelEnds = (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	SMemMat.RelVec = (MYDTYPE*) &smem[offset];
	offset+=InMat.nCallForFather*sizeof(MYDTYPE);
	SMemMat.SegStartI = (MYDTYPE*) &smem[offset];
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);
	SMemMat.SegEndI = (MYDTYPE*) &smem[offset];
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);

	SMemMat.Fathers= (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	// 3
	SMemMat.CompByLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	offset+=WARPSIZE*(CompDepth)*sizeof(MYDTYPE);
	SMemMat.CompByFLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	offset+=WARPSIZE*(CompFDepth)*sizeof(MYDTYPE);
	SMemMat.LRelStarts = (MYDTYPE*) &smem[offset];
	offset+=SMemMat.nLRel*sizeof(MYDTYPE);
	SMemMat.LRelEnds = (MYDTYPE*) &smem[offset];
	offset+=SMemMat.nLRel*sizeof(MYDTYPE);
	SMemMat.FLRelStarts = (MYDTYPE*) &smem[offset];
	offset+=SMemMat.nFLRel*sizeof(MYDTYPE);
	SMemMat.FLRelEnds = (MYDTYPE*) &smem[offset];
	offset+=SMemMat.nFLRel*sizeof(MYDTYPE);
	// Moving back to MYFTYPEs - make sure that the address is good for MYFTYPE (is modulu 4).
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	MYDTYPE ConstantMemSize=offset;
	//if(PIdx_1<InMat.nFathers) { SMemMat.RelStarts[PIdx_1]=InMat.RelStarts[PIdx_1];SMemMat.RelEnds[PIdx_1]=InMat.RelEnds[PIdx_1];SMemMat.Fathers[PIdx_1]=InMat.Fathers[PIdx_1];}
	#define THISCOMMANDHEREE120(VARILP) if(PIdx_ ## VARILP<InMat.nFathers){ SMemMat.RelStarts[PIdx_ ## VARILP]=InMat.RelStarts[PIdx_ ## VARILP];SMemMat.RelEnds[PIdx_ ## VARILP]=InMat.RelEnds[PIdx_ ## VARILP];SMemMat.Fathers[PIdx_ ## VARILP]=InMat.Fathers[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHEREE120)
	//if(PIdx_1<InMat.nCallForFather) {SMemMat.RelVec[PIdx_1]=InMat.RelVec[PIdx_1];}
	#define THISCOMMANDHEREE121(VARILP) if(PIdx_ ## VARILP<InMat.nCallForFather){SMemMat.RelVec[PIdx_ ## VARILP]=InMat.RelVec[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHEREE121)
	//if(PIdx_1<InMat.nCallForFather+1) {SMemMat.SegStartI[PIdx_1]=InMat.SegStartI[PIdx_1];SMemMat.SegEndI[PIdx_1]=InMat.SegEndI[PIdx_1];}
	#define THISCOMMANDHEREE122(VARILP) if(PIdx_ ## VARILP<InMat.nCallForFather+1){SMemMat.SegStartI[PIdx_ ## VARILP]=InMat.SegStartI[PIdx_ ## VARILP];SMemMat.SegEndI[PIdx_ ## VARILP]=InMat.SegEndI[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHEREE122)
	__syncthreads();
	for(int i=0;i<CompDepth;i++) {SMemMat.CompByLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByLevel32[WARPSIZE*i+PIdx_1];}
	//#define THISCOMMANDHEREE123(VARILP) for(int i=0;i<=SMemMat.Depth;i++) {SMemMat.CompByLevel32[WARPSIZE*i+PIdx_ ## VARILP]=InMat.CompByLevel32[WARPSIZE*i+PIdx_ ## VARILP];}
	//SUPERILPMACRO(THISCOMMANDHEREE123)
	for(int i=0;i<CompFDepth;i++) {SMemMat.CompByFLevel32[WARPSIZE*i+PIdx_1]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_1];}
	//#define THISCOMMANDHEREE124(VARILP) for(int i=0;i<SMemMat.Depth;i++) {SMemMat.CompByFLevel32[WARPSIZE*i+PIdx_ ## VARILP]=InMat.CompByFLevel32[WARPSIZE*i+PIdx_ ## VARILP];}
	//SUPERILPMACRO(THISCOMMANDHEREE124)
	//if(PIdx_1<InMat.nLRel) {SMemMat.LRelStarts[PIdx_1]=InMat.LRelStarts[PIdx_1];SMemMat.LRelEnds[PIdx_1]=InMat.LRelEnds[PIdx_1];}
	#define THISCOMMANDHEREE125(VARILP) if(PIdx_ ## VARILP<InMat.nLRel){SMemMat.LRelStarts[PIdx_ ## VARILP]=InMat.LRelStarts[PIdx_ ## VARILP];SMemMat.LRelEnds[PIdx_ ## VARILP]=InMat.LRelEnds[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHEREE125)
	__syncthreads();
	//if(PIdx_1<InMat.nFLRel) {SMemMat.FLRelStarts[PIdx_1]=InMat.FLRelStarts[PIdx_1];SMemMat.FLRelEnds[PIdx_1]=InMat.FLRelEnds[PIdx_1];}
	#define THISCOMMANDHEREE126(VARILP) if(PIdx_ ## VARILP<InMat.nFLRel) {SMemMat.FLRelStarts[PIdx_ ## VARILP]=InMat.FLRelStarts[PIdx_ ## VARILP];SMemMat.FLRelEnds[PIdx_ ## VARILP]=InMat.FLRelEnds[PIdx_ ## VARILP];}
	SUPERILPMACRO(THISCOMMANDHEREE126)
	#ifdef HH
	//RBS This works now where all models are in the same comps we need to genreralize it.
	//RBS  This code should be generated with calling all models init and defining all states.
//#define THISCOMMANDHEREE4(VARILP) ModelStates_ ## VARILP [0]=0; ModelStates_ ## VARILP [1]=0; ModelStates_ ## VARILP [2]=0;
	SUPERILPMACRO(SET_STATES)
#endif
	MYDTYPE perThreadParamMSize = SMemMat.NComps*NPARAMS;
	// MYFTYPE p0_1 ,p1_1 ,p2_1 ,p3_1 ,p4_1 ,p5_1 ,p6_1 ,p7_1 ,p8_1 ,p9_1 ,p10_1 ,p11_1 ,p12_1 ,p13_1 ,p14_1 ,p15_1 ,p16_1 ,p17_1 ,p18_1 ,p19_1 ,p20_1 ,p21_1 ,p22_1 ,p23_1 ,p24_1 ,p25_1 ,p26_1 ,p27_1 ;p0_1 =ParamsM[NeuronID*perThreadParamMSize +0*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p1_1 =ParamsM[NeuronID*perThreadParamMSize +1*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p2_1 =ParamsM[NeuronID*perThreadParamMSize +2*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p3_1 =ParamsM[NeuronID*perThreadParamMSize +3*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p4_1 =ParamsM[NeuronID*perThreadParamMSize +4*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p5_1 =ParamsM[NeuronID*perThreadParamMSize +5*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p6_1 =ParamsM[NeuronID*perThreadParamMSize +6*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p7_1 =ParamsM[NeuronID*perThreadParamMSize +7*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p8_1 =ParamsM[NeuronID*perThreadParamMSize +8*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p9_1 =ParamsM[NeuronID*perThreadParamMSize +9*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p10_1 =ParamsM[NeuronID*perThreadParamMSize +10*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p11_1 =ParamsM[NeuronID*perThreadParamMSize +11*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p12_1 =ParamsM[NeuronID*perThreadParamMSize +12*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p13_1 =ParamsM[NeuronID*perThreadParamMSize +13*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p14_1 =ParamsM[NeuronID*perThreadParamMSize +14*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p15_1 =ParamsM[NeuronID*perThreadParamMSize +15*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p16_1 =ParamsM[NeuronID*perThreadParamMSize +16*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p17_1 =ParamsM[NeuronID*perThreadParamMSize +17*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p18_1 =ParamsM[NeuronID*perThreadParamMSize +18*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p19_1 =ParamsM[NeuronID*perThreadParamMSize +19*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p20_1 =ParamsM[NeuronID*perThreadParamMSize +20*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p21_1 =ParamsM[NeuronID*perThreadParamMSize +21*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p22_1 =ParamsM[NeuronID*perThreadParamMSize +22*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p23_1 =ParamsM[NeuronID*perThreadParamMSize +23*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p24_1 =ParamsM[NeuronID*perThreadParamMSize +24*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p25_1 =ParamsM[NeuronID*perThreadParamMSize +25*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p26_1 =ParamsM[NeuronID*perThreadParamMSize +26*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];p27_1 =ParamsM[NeuronID*perThreadParamMSize +27*SMemMat.NComps+SMemMat.SegToComp[PIdx_1] ];MYFTYPE p0_2 ,p1_2 ,p2_2 ,p3_2 ,p4_2 ,p5_2 ,p6_2 ,p7_2 ,p8_2 ,p9_2 ,p10_2 ,p11_2 ,p12_2 ,p13_2 ,p14_2 ,p15_2 ,p16_2 ,p17_2 ,p18_2 ,p19_2 ,p20_2 ,p21_2 ,p22_2 ,p23_2 ,p24_2 ,p25_2 ,p26_2 ,p27_2 ;p0_2 =ParamsM[NeuronID*perThreadParamMSize +0*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p1_2 =ParamsM[NeuronID*perThreadParamMSize +1*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p2_2 =ParamsM[NeuronID*perThreadParamMSize +2*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p3_2 =ParamsM[NeuronID*perThreadParamMSize +3*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p4_2 =ParamsM[NeuronID*perThreadParamMSize +4*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p5_2 =ParamsM[NeuronID*perThreadParamMSize +5*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p6_2 =ParamsM[NeuronID*perThreadParamMSize +6*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p7_2 =ParamsM[NeuronID*perThreadParamMSize +7*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p8_2 =ParamsM[NeuronID*perThreadParamMSize +8*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p9_2 =ParamsM[NeuronID*perThreadParamMSize +9*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p10_2 =ParamsM[NeuronID*perThreadParamMSize +10*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p11_2 =ParamsM[NeuronID*perThreadParamMSize +11*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p12_2 =ParamsM[NeuronID*perThreadParamMSize +12*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p13_2 =ParamsM[NeuronID*perThreadParamMSize +13*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p14_2 =ParamsM[NeuronID*perThreadParamMSize +14*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p15_2 =ParamsM[NeuronID*perThreadParamMSize +15*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p16_2 =ParamsM[NeuronID*perThreadParamMSize +16*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p17_2 =ParamsM[NeuronID*perThreadParamMSize +17*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p18_2 =ParamsM[NeuronID*perThreadParamMSize +18*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p19_2 =ParamsM[NeuronID*perThreadParamMSize +19*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p20_2 =ParamsM[NeuronID*perThreadParamMSize +20*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p21_2 =ParamsM[NeuronID*perThreadParamMSize +21*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p22_2 =ParamsM[NeuronID*perThreadParamMSize +22*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p23_2 =ParamsM[NeuronID*perThreadParamMSize +23*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p24_2 =ParamsM[NeuronID*perThreadParamMSize +24*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p25_2 =ParamsM[NeuronID*perThreadParamMSize +25*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p26_2 =ParamsM[NeuronID*perThreadParamMSize +26*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];p27_2 =ParamsM[NeuronID*perThreadParamMSize +27*SMemMat.NComps+SMemMat.SegToComp[PIdx_2] ];MYFTYPE p0_3 ,p1_3 ,p2_3 ,p3_3 ,p4_3 ,p5_3 ,p6_3 ,p7_3 ,p8_3 ,p9_3 ,p10_3 ,p11_3 ,p12_3 ,p13_3 ,p14_3 ,p15_3 ,p16_3 ,p17_3 ,p18_3 ,p19_3 ,p20_3 ,p21_3 ,p22_3 ,p23_3 ,p24_3 ,p25_3 ,p26_3 ,p27_3 ;p0_3 =ParamsM[NeuronID*perThreadParamMSize +0*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p1_3 =ParamsM[NeuronID*perThreadParamMSize +1*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p2_3 =ParamsM[NeuronID*perThreadParamMSize +2*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p3_3 =ParamsM[NeuronID*perThreadParamMSize +3*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p4_3 =ParamsM[NeuronID*perThreadParamMSize +4*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p5_3 =ParamsM[NeuronID*perThreadParamMSize +5*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p6_3 =ParamsM[NeuronID*perThreadParamMSize +6*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p7_3 =ParamsM[NeuronID*perThreadParamMSize +7*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p8_3 =ParamsM[NeuronID*perThreadParamMSize +8*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p9_3 =ParamsM[NeuronID*perThreadParamMSize +9*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p10_3 =ParamsM[NeuronID*perThreadParamMSize +10*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p11_3 =ParamsM[NeuronID*perThreadParamMSize +11*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p12_3 =ParamsM[NeuronID*perThreadParamMSize +12*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p13_3 =ParamsM[NeuronID*perThreadParamMSize +13*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p14_3 =ParamsM[NeuronID*perThreadParamMSize +14*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p15_3 =ParamsM[NeuronID*perThreadParamMSize +15*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p16_3 =ParamsM[NeuronID*perThreadParamMSize +16*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p17_3 =ParamsM[NeuronID*perThreadParamMSize +17*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p18_3 =ParamsM[NeuronID*perThreadParamMSize +18*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p19_3 =ParamsM[NeuronID*perThreadParamMSize +19*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p20_3 =ParamsM[NeuronID*perThreadParamMSize +20*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p21_3 =ParamsM[NeuronID*perThreadParamMSize +21*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p22_3 =ParamsM[NeuronID*perThreadParamMSize +22*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p23_3 =ParamsM[NeuronID*perThreadParamMSize +23*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p24_3 =ParamsM[NeuronID*perThreadParamMSize +24*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p25_3 =ParamsM[NeuronID*perThreadParamMSize +25*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p26_3 =ParamsM[NeuronID*perThreadParamMSize +26*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];p27_3 =ParamsM[NeuronID*perThreadParamMSize +27*SMemMat.NComps+SMemMat.SegToComp[PIdx_3] ];
	SUPERILPMACRO(SET_PARAMS)	
	SUPERILPMACRO(CALL_TO_INIT_STATES_CU)
	// Per STIMULUS
	// MYFTYPEs
	 int Nt=stim.Nt;
	// For solving the matrix
#ifdef BKSUB2
    MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(InMat.N+2*WARPSIZE)*sizeof(MYFTYPE);
#endif
#ifdef BKSUB1
   MYDTYPE PerStimulus=((InMat.N+2)*2*sizeof(MYSECONDFTYPE))+(InMat.N+WARPSIZE + sim.NRecSites*WARPSIZE)*sizeof(MYFTYPE);
#endif
	offset+=PerStimulus*threadIdx.y;
	MYSECONDFTYPE *uHP,*bHP,*PX,*PF;
	MYFTYPE *Vs;
	uHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	bHP = (MYSECONDFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	Vs = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
	// Vs[PIdx_3]=V[PIdx_3];
#define THISCOMMANDHEREE13(VARILP) Vs[PIdx_ ## VARILP ]=V[PIdx_ ## VARILP ];bHP[PIdx_ ## VARILP]=0;dv_ ## VARILP =0;
	SUPERILPMACRO(THISCOMMANDHEREE13)
	PX=bHP;
	PF=uHP;
	MYFTYPE *SMemVHot;
	SMemVHot = (MYFTYPE*) &smem[offset];
	offset+=WARPSIZE*sim.NRecSites*sizeof(MYFTYPE);
	MYFTYPE *amps;
    amps = (MYFTYPE*) &smem[offset];
    offset+=WARPSIZE*sizeof(MYFTYPE);
	// MYDTYPE parentIndex_3; // MYDTYPE Eidx_3; // Eidx_3 = SMemMat.N-PIdx_3;
#define THISCOMMANDHEREE14(VARILP) MYDTYPE parentIndex_ ## VARILP ; MYDTYPE Eidx_ ## VARILP ; Eidx_ ## VARILP = SMemMat.N-PIdx_ ## VARILP -1;
	SUPERILPMACRO(THISCOMMANDHEREE14)
	// RRRXXX This probably should be in ILP too!
	if(Eidx_1>SMemMat.N-1){
		Eidx_1=SMemMat.N-1;
	}
	// parentIndex_3 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_3];
#define THISCOMMANDHEREE15(VARILP) parentIndex_ ## VARILP =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_ ## VARILP ];
	SUPERILPMACRO(THISCOMMANDHEREE15)	
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
#define THISCOMMANDHEREE16(VARILP) MYSECONDFTYPE rhs_ ## VARILP ,D_ ## VARILP; MYFTYPE gModel_ ## VARILP ,StimCurrent_ ## VARILP;
SUPERILPMACRO(THISCOMMANDHEREE16)
   // MYSECONDFTYPE rhs_1 ,D_1; MYFTYPE gModel_1 ,StimCurrent_1;MYSECONDFTYPE rhs_2 ,D_2; MYFTYPE gModel_2 ,StimCurrent_2;MYSECONDFTYPE rhs_3 ,D_3; MYFTYPE gModel_3 ,StimCurrent_3;
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
			SMemVHot[recInd*WARPSIZE+i%(WARPSIZE)]=Vs[sim.RecSites[recInd]];
		}
		 // rhs_3=0; // D_3=0;// StimCurrent_3=0;
#define THISCOMMANDHEREE17(VARILP) rhs_ ## VARILP =0; D_ ## VARILP =0; sumCurrents_ ## VARILP=0; sumConductivity_ ## VARILP=0; sumCurrentsDv_ ## VARILP=0; sumConductivityDv_ ## VARILP=0;StimCurrent_ ## VARILP =0;
	SUPERILPMACRO(THISCOMMANDHEREE17)
		// Before matrix
		// if(t>=stimDel && t<stimDel+stimDur && PIdx_3 == stimLoc){StimCurrent_3 = 100*stimAmp/stimArea;}
#ifndef STIMFROMFILE
    #define THISCOMMANDHEREE18A(VARILP) if(t>=stimDel && t<stimDel+stimDur && PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP  = 100*stimAmp/stimArea;}
	SUPERILPMACRO(THISCOMMANDHEREE18A)
   // if(t>=stimDel && t<stimDel+stimDur && PIdx_1  == stimLoc){StimCurrent_1  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_2  == stimLoc){StimCurrent_2  = 100*stimAmp/stimArea;}if(t>=stimDel && t<stimDel+stimDur && PIdx_3  == stimLoc){StimCurrent_3  = 100*stimAmp/stimArea;}
 
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
    
    #define THISCOMMANDHEREE18B(VARILP) if(PIdx_ ## VARILP  == stimLoc){StimCurrent_ ## VARILP = 100*amps[i%WARPSIZE]/stimArea;}
	SUPERILPMACRO(THISCOMMANDHEREE18B)
    //if(PIdx_1  == stimLoc){StimCurrent_1 = 100*amps[i%WARPSIZE]/stim.area;}if(PIdx_2  == stimLoc){StimCurrent_2 = 100*amps[i%WARPSIZE]/stim.area;}if(PIdx_3  == stimLoc){StimCurrent_3 = 100*amps[i%WARPSIZE]/stim.area;}
#endif // STIMFROMFILE
 
#ifdef HH
	//#define THISCOMMANDHEREE19(VARILP) if(SMemMat.boolModel[PIdx_ ## VARILP ]==1) {CuBreakpointModel_kv(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001 ,ModelStates_ ## VARILP [0], p1_ ## VARILP ,p2_ ## VARILP ,p3_ ## VARILP ,p4_ ## VARILP ,p5_ ## VARILP);} if(SMemMat.boolModel[PIdx_ ## VARILP+SMemMat.N ]==1) {CuBreakpointModel_na(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001 ,ModelStates_ ## VARILP [1],ModelStates_ ## VARILP [2], p6_ ## VARILP ,p7_ ## VARILP ,p8_ ## VARILP ,p9_ ## VARILP ,p10_ ## VARILP,p11_ ## VARILP ,p12_ ## VARILP ,p13_ ## VARILP ,p14_ ## VARILP ,p15_ ## VARILP,p16_ ## VARILP ,p17_ ## VARILP);}
	SUPERILPMACRO(CALL_TO_BREAK_DV_CU)
//#define THISCOMMANDHEREE20(VARILP) if(SMemMat.boolModel[PIdx_ ## VARILP ]==1) {CuBreakpointModel_kv(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP [0], p1_ ## VARILP ,p2_ ## VARILP ,p3_ ## VARILP ,p4_ ## VARILP ,p5_ ## VARILP);} if(SMemMat.boolModel[PIdx_ ## VARILP+SMemMat.N ]==1) {CuBreakpointModel_na(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP [1],ModelStates_ ## VARILP [2], p6_ ## VARILP ,p7_ ## VARILP ,p8_ ## VARILP ,p9_ ## VARILP ,p10_ ## VARILP,p11_ ## VARILP ,p12_ ## VARILP ,p13_ ## VARILP ,p14_ ## VARILP ,p15_ ## VARILP,p16_ ## VARILP ,p17_ ## VARILP);}
	SUPERILPMACRO(CALL_TO_BREAK_CU)
#endif
	// gModel_3 = (sumCurrentsDv_3-sumCurrents_3)/0.001; 
#define THISCOMMANDHEREE21(VARILP) gModel_ ## VARILP  = (sumCurrentsDv_ ## VARILP -sumCurrents_ ## VARILP )/EPS_V;  
	SUPERILPMACRO(THISCOMMANDHEREE21)
		// rhs_3=StimCurrent_3-sumCurrents_3; // dv_3=Vs[parentIndex_3]-Vs[PIdx_3]; // rhs_3-=SMemMat.f[SMemMat.N-PIdx_3-1]*dv_3;
#define THISCOMMANDHEREE22(VARILP) rhs_ ## VARILP =StimCurrent_ ## VARILP -sumCurrents_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHEREE22)
#define THISCOMMANDHEREE24(VARILP) D_ ## VARILP =gModel_ ## VARILP +SMemMat.Cms[PIdx_ ## VARILP ]/(dt*1000); D_ ## VARILP -=SMemMat.f[SMemMat.N-PIdx_ ## VARILP -1];
SUPERILPMACRO(THISCOMMANDHEREE24)
   // D_1 =gModel_1 +SMemMat.Cms[PIdx_1 ]/(dt*1000); D_1 -=SMemMat.f[SMemMat.N-PIdx_1 -1];D_2 =gModel_2 +SMemMat.Cms[PIdx_2 ]/(dt*1000); D_2 -=SMemMat.f[SMemMat.N-PIdx_2 -1];D_3 =gModel_3 +SMemMat.Cms[PIdx_3 ]/(dt*1000); D_3 -=SMemMat.f[SMemMat.N-PIdx_3 -1];
    //this should be out and correct SMemMat.Ks
	if(PIdx_1==0) {
		parentIndex_1=0;
	};
#define THISCOMMANDHEREE25(VARILP)  dv_ ## VARILP +=bHP[SMemMat.N-parentIndex_ ## VARILP -1]-bHP[SMemMat.N-PIdx_ ## VARILP -1]; rhs_ ## VARILP -=SMemMat.f[SMemMat.N-PIdx_ ## VARILP -1]*dv_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHEREE25)
		// D_3=sumConductivity_3+SMemMat.Cms[PIdx_3]/(sim.dt*1000); // D_3-=SMemMat.f[SMemMat.N-PIdx_3-1];
		// bHP[SMemMat.N-PIdx_3-1]=rhs_3; // uHP[SMemMat.N-PIdx_3-1]=D_3;
#define THISCOMMANDHEREE26(VARILP) bHP[SMemMat.N-PIdx_ ## VARILP -1]=rhs_ ## VARILP ; uHP[SMemMat.N-PIdx_ ## VARILP -1]=D_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHEREE26)
		syncthreads();
		// if(SonNo_3==1) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#define THISCOMMANDHEREE27(VARILP) if(SonNo_ ## VARILP ==1) {bHP[SMemMat.N-parentIndex_ ## VARILP -1]+=SMemMat.e[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[SMemMat.N-parentIndex_ ## VARILP -1]-=SMemMat.e[Eidx_ ## VARILP ];}
	SUPERILPMACRO(THISCOMMANDHEREE27)
		// if(SonNo_3==2) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#define THISCOMMANDHEREE28(VARILP) if(SonNo_ ## VARILP ==2) {bHP[SMemMat.N-parentIndex_ ## VARILP -1]+=SMemMat.e[Eidx_ ## VARILP ]*dv_ ## VARILP ;uHP[SMemMat.N-parentIndex_ ## VARILP -1]-=SMemMat.e[Eidx_ ## VARILP ];}
	SUPERILPMACRO(THISCOMMANDHEREE28)
		syncthreads();
		BeforeLU(SMemMat,uHP,bHP,SMemMat.Depth);
#ifdef BKSUB1
		BkSub(SMemMat, PX,PF,uHP,bHP,SMemMat.LognDepth);
		#define THISCOMMANDHEREE29(VARILP) Vmid_ ## VARILP =PX[SMemMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ; Vs[PIdx_ ## VARILP ]+=Vmid_ ## VARILP ;
	SUPERILPMACRO(THISCOMMANDHEREE29)
#endif

		
#ifdef BKSUB2
		#define THISCOMMANDHEREE290(VARILP) MYFTYPE vTemp_ ## VARILP=Vs[PIdx_ ## VARILP];
		SUPERILPMACRO(THISCOMMANDHEREE290);
		syncthreads();
		BkSub(SMemMat,uHP,bHP,Vs,SMemMat.Depth);
		syncthreads();
		PX=Vs;

#define THISCOMMANDHEREE29(VARILP) Vmid_ ## VARILP =PX[SMemMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHEREE29)
		syncthreads(); 
#define THISCOMMANDHEREE291(VARILP) Vs[PIdx_ ## VARILP ]= vTemp_ ## VARILP +Vmid_ ## VARILP ;
		SUPERILPMACRO(THISCOMMANDHEREE291)
#endif		
            t+=0.5*dt;
#ifdef HH
        
//#define THISCOMMANDHEREE30(VARILP) if(SMemMat.boolModel[PIdx_ ## VARILP ]==1) {CuDerivModel_kv(dt,v_ ## VARILP ,ModelStates_ ## VARILP [0], p1_ ## VARILP ,p2_ ## VARILP ,p3_ ## VARILP ,p4_ ## VARILP ,p5_ ## VARILP);} if(SMemMat.boolModel[PIdx_ ## VARILP+SMemMat.N ]==1) {CuDerivModel_na(dt,v_ ## VARILP ,ModelStates_ ## VARILP [1],ModelStates_ ## VARILP [2], p6_ ## VARILP ,p7_ ## VARILP ,p8_ ## VARILP ,p9_ ## VARILP ,p10_ ## VARILP,p11_ ## VARILP ,p12_ ## VARILP ,p13_ ## VARILP ,p14_ ## VARILP ,p15_ ## VARILP,p16_ ## VARILP ,p17_ ## VARILP);}//RBS should be generated automatically
//      if(SMemMat.boolModel[PIdx_1 +0*SMemMat.N]){CuDerivModel_ca(dt, v_1,ModelStates_1[0],ModelStates_1[1],p0_1 ,p1_1 ,ModelStates_1[8],ModelStates_1[9]);} if(SMemMat.boolModel[PIdx_1 +1*SMemMat.N]){CuDerivModel_cad(dt, v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(SMemMat.boolModel[PIdx_1 +2*SMemMat.N]){CuDerivModel_kca(dt, v_1,ModelStates_1[3],p2_1 ,p3_1 ,p4_1 ,p5_1 ,ModelStates_1[8]);} if(SMemMat.boolModel[PIdx_1 +3*SMemMat.N]){CuDerivModel_km(dt, v_1,ModelStates_1[4],p6_1 ,p7_1 ,p8_1 ,p9_1 ,p10_1 );} if(SMemMat.boolModel[PIdx_1 +4*SMemMat.N]){CuDerivModel_kv(dt, v_1,ModelStates_1[5],p11_1 ,p12_1 ,p13_1 ,p14_1 ,p15_1 );} if(SMemMat.boolModel[PIdx_1 +5*SMemMat.N]){CuDerivModel_na(dt, v_1,ModelStates_1[6],ModelStates_1[7],p16_1 ,p17_1 ,p18_1 ,p19_1 ,p20_1 ,p21_1 ,p22_1 ,p23_1 ,p24_1 ,p25_1 ,p26_1 ,p27_1 );}  if(SMemMat.boolModel[PIdx_2 +0*SMemMat.N]){CuDerivModel_ca(dt, v_2,ModelStates_2[0],ModelStates_2[1],p0_2 ,p1_2 ,ModelStates_2[8],ModelStates_2[9]);} if(SMemMat.boolModel[PIdx_2 +1*SMemMat.N]){CuDerivModel_cad(dt, v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(SMemMat.boolModel[PIdx_2 +2*SMemMat.N]){CuDerivModel_kca(dt, v_2,ModelStates_2[3],p2_2 ,p3_2 ,p4_2 ,p5_2 ,ModelStates_2[8]);} if(SMemMat.boolModel[PIdx_2 +3*SMemMat.N]){CuDerivModel_km(dt, v_2,ModelStates_2[4],p6_2 ,p7_2 ,p8_2 ,p9_2 ,p10_2 );} if(SMemMat.boolModel[PIdx_2 +4*SMemMat.N]){CuDerivModel_kv(dt, v_2,ModelStates_2[5],p11_2 ,p12_2 ,p13_2 ,p14_2 ,p15_2 );} if(SMemMat.boolModel[PIdx_2 +5*SMemMat.N]){CuDerivModel_na(dt, v_2,ModelStates_2[6],ModelStates_2[7],p16_2 ,p17_2 ,p18_2 ,p19_2 ,p20_2 ,p21_2 ,p22_2 ,p23_2 ,p24_2 ,p25_2 ,p26_2 ,p27_2 );}  if(SMemMat.boolModel[PIdx_3 +0*SMemMat.N]){CuDerivModel_ca(dt, v_3,ModelStates_3[0],ModelStates_3[1],p0_3 ,p1_3 ,ModelStates_3[8],ModelStates_3[9]);} if(SMemMat.boolModel[PIdx_3 +1*SMemMat.N]){CuDerivModel_cad(dt, v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(SMemMat.boolModel[PIdx_3 +2*SMemMat.N]){CuDerivModel_kca(dt, v_3,ModelStates_3[3],p2_3 ,p3_3 ,p4_3 ,p5_3 ,ModelStates_3[8]);} if(SMemMat.boolModel[PIdx_3 +3*SMemMat.N]){CuDerivModel_km(dt, v_3,ModelStates_3[4],p6_3 ,p7_3 ,p8_3 ,p9_3 ,p10_3 );} if(SMemMat.boolModel[PIdx_3 +4*SMemMat.N]){CuDerivModel_kv(dt, v_3,ModelStates_3[5],p11_3 ,p12_3 ,p13_3 ,p14_3 ,p15_3 );} if(SMemMat.boolModel[PIdx_3 +5*SMemMat.N]){CuDerivModel_na(dt, v_3,ModelStates_3[6],ModelStates_3[7],p16_3 ,p17_3 ,p18_3 ,p19_3 ,p20_3 ,p21_3 ,p22_3 ,p23_3 ,p24_3 ,p25_3 ,p26_3 ,p27_3 );}
	    SUPERILPMACRO(CALL_TO_DERIV_CU)
#endif
 
 
    }
   for(int recInd =0;recInd<sim.NRecSites;recInd++){
		VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) +threadIdx.y*Nt*sim.NRecSites+recInd*Nt + Nt-WARPSIZE+PIdx_1]=SMemVHot[WARPSIZE*recInd + PIdx_1];
	}
 
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

__constant__ MYDTYPE* constKs;

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
	


	cudaStatus = cudaMalloc((void**)&Mat_d.e, InMat.N * sizeof(MYSECONDFTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.f, InMat.N * sizeof(MYSECONDFTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.Ks, InMat.N * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SegToComp, InMat.N * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.boolModel, InMat.N * InMat.NModels* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.Cms, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SonNoVec, InMat.N* sizeof(MYDTYPE));
	
	cudaStatus = cudaMalloc((void**)&Mat_d.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	
	cudaStatus = cudaMalloc((void**)&Mat_d.RelStarts, InMat.nFathers * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.RelEnds, (InMat.nFathers) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.RelVec, InMat.nCallForFather * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SegEndI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&VHotsGlobal, NSets*Nt *stim.NStimuli* sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&VHotsGlobal, NSets*sim_d.NRecSites*Nt *stim.NStimuli* sizeof(MYFTYPE));
	// 32 data
#ifdef BKSUB1
	cudaStatus = cudaMalloc((void**)&Mat_d.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE));
#endif
#ifdef BKSUB2
	cudaStatus = cudaMalloc((void**)&Mat_d.KsB, (InMat.N +1)* sizeof(MYDTYPE));
#endif
	cudaStatus = cudaMalloc((void**)&Mat_d.CompByLevel32, (CompDepth)*WARPSIZE* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.CompByFLevel32, (CompFDepth)*WARPSIZE* sizeof(MYDTYPE));

	cudaStatus = cudaMalloc((void**)&Mat_d.LRelStarts, Mat_d.nLRel* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.LRelEnds, Mat_d.nLRel* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.FLRelStarts, Mat_d.nFLRel* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.FLRelEnds, Mat_d.nFLRel* sizeof(MYDTYPE));

	

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
	cudaStatus = cudaMalloc((void**)&Mat_d.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	cudaStatus = cudaMemcpy(Mat_d.e, InMat.e, InMat.N * sizeof(MYSECONDFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.f, InMat.f, InMat.N * sizeof(MYSECONDFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.Ks, InMat.Ks, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SegToComp, InMat.SegToComp, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(Mat_d.boolModel, InMat.boolModel, InMat.N * InMat.NModels * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.Cms, InMat.Cms, InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SonNoVec, InMat.SonNoVec, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(Mat_d.Fathers, InMat.Fathers, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(Mat_d.RelStarts, InMat.RelStarts, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.RelEnds, InMat.RelEnds, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.RelVec, InMat.RelVec, InMat.nCallForFather* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SegStartI, InMat.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SegEndI, InMat.SegEndI, (InMat.nCallForFather+1)* sizeof(MYDTYPE), cudaMemcpyHostToDevice);

	
	
	// 32 data
#ifdef BKSUB1
	cudaStatus = cudaMemcpy(Mat_d.FIdxs, InMat.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
#endif
#ifdef BKSUB2
	cudaStatus = cudaMemcpy(Mat_d.KsB, InMat.KsB,(InMat.N+1)*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
#endif

	cudaStatus = cudaMemcpy(Mat_d.CompByLevel32, InMat.CompByLevel32, (CompDepth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.CompByFLevel32, InMat.CompByFLevel32, (CompFDepth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);

	cudaStatus = cudaMemcpy(Mat_d.LRelStarts, InMat.LRelStarts,InMat.nLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.LRelEnds, InMat.LRelEnds,InMat.nLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.FLRelStarts, InMat.FLRelStarts,InMat.nFLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.FLRelEnds, InMat.FLRelEnds,InMat.nFLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);

	
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
	offset+=InMat.N*sizeof(MYSECONDFTYPE);
	offset+=InMat.N*sizeof(MYSECONDFTYPE);
	offset+=InMat.N*sizeof(MYFTYPE);
	// 1 - e,f,Cms
#ifdef BKSUB1
	offset+=InMat.N*InMat.LognDepth*sizeof(MYDTYPE);
#endif
	offset+=InMat.N*sizeof(MYDTYPE);
	offset+=InMat.N*sizeof(MYDTYPE);
	offset+=InMat.N*InMat.NModels*sizeof(MYDTYPE);
	// 2 FIdxs, Ks, SegToComp,boolModel
	offset+=InMat.nFathers*sizeof(MYDTYPE); // RelStarts
	offset+=InMat.nFathers*sizeof(MYDTYPE); // RelEnds
	offset+=InMat.nCallForFather*sizeof(MYDTYPE); // RelVec
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE); // SegStartI
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE); // SegEndI
	offset+=InMat.nFathers*sizeof(MYDTYPE); // Fathers
	// 3 RelStarts RelEnds RelVec SegStartI SegEndI Fathers
	offset+=WARPSIZE*(CompDepth)*sizeof(MYDTYPE);
	offset+=WARPSIZE*(CompFDepth)*sizeof(MYDTYPE);
	// 4 CompByLevel32 CompByFLevel32
	offset+=Mat_d.nLRel*sizeof(MYDTYPE);
	offset+=Mat_d.nLRel*sizeof(MYDTYPE);
	offset+=Mat_d.nFLRel*sizeof(MYDTYPE);
	offset+=Mat_d.nFLRel*sizeof(MYDTYPE);
#ifdef BKSUB2
	offset+=(Mat_d.N+1)*sizeof(MYDTYPE);
#endif
	// 5 LRelStarts LRelEnds FLRelStarts  FLRelEnds KsB
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE))*sizeof(MYSECONDFTYPE);
	MYDTYPE FrameworkMemSize=offset;
//PerStimulus

	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE);  // uHP (Diag)
	offset+=(InMat.N+2)*sizeof(MYSECONDFTYPE); // bHP (rhs)
	offset=ceilf(MYSECONDFTYPE(offset)/sizeof(MYSECONDFTYPE)+1)*sizeof(MYSECONDFTYPE);
	offset+=InMat.N*sizeof(MYFTYPE); // Vs

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
	if(streamID==0){
		stEfork2TimeLoopGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream0>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR	

	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream0); 
		
	}
	if(streamID==1){
	stEfork2TimeLoopGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream1>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR

	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt * sim.NRecSites * stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream1); 

	}
	if(streamID==2){
	stEfork2TimeLoopGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream2>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR
	
	cudaStatus = cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal],currKernelRun * Nt *sim.NRecSites *  stim.NStimuli* sizeof(MYFTYPE), cudaMemcpyDeviceToHost,stream2); 

	}
	if(streamID==3){
	stEfork2TimeLoopGPUKernel<<<currKernelRun, blockDim,TotalSMem,stream3>>>(stim_d, &d_modelParams[prevRuns*memSizeForModelParams], sim_d, Mat_d, V_d,&VHotsGlobal[prevRuns*memSizeForVHotGlobal],CompDepth,CompFDepth); // RRR
	
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
