NUM_OF_MODELS = 2;
NUM_OF_SEGS = 416;
MAX_NUM_CONSTS_PER_MODEL = 4;
MAX_NUM_CONSTS_GLOBAL = 3;
MAX_NUM_VARS_PER_MODEL_PER_SEG = 5;
MAX_NUM_VARS_PER_MODEL_ALL_SEGS = 6;

ModelsFuncsNames = cell(NUM_OF_MODELS, NUM_OF_FUNCS_PER_MODEL);
ModelsFuncsNames(:, INIT_INDEX) = {'NrnInitModel_'};
ModelsFuncsNames(:, CURRENT_INDEX) = {'NrnCurrent_'};
ModelsFuncsNames(:, STATES_INDEX) = {'NrnStates_'};
ModelsFuncsNames(1,:) = strcat(ModelsFuncsNames(1,:), 'hh2');
ModelsFuncsNames(2,:) = strcat(ModelsFuncsNames(2,:), 'stim');

hasModel = zeros (NUM_OF_SEGS, NUM_OF_MODELS);
for segInd = 2:2
    hasModel(segInd, [1]) = 1;
end
for segInd = 4:14
    hasModel(segInd, [1]) = 1;
end
for segInd = 16:16
    hasModel(segInd, [1]) = 1;
end
for segInd = 18:18
    hasModel(segInd, [1]) = 1;
end
for segInd = 20:20
    hasModel(segInd, [1]) = 1;
end
for segInd = 22:22
    hasModel(segInd, [1]) = 1;
end
for segInd = 24:24
    hasModel(segInd, [1]) = 1;
end
for segInd = 26:26
    hasModel(segInd, [1]) = 1;
end
for segInd = 28:28
    hasModel(segInd, [1]) = 1;
end
for segInd = 30:30
    hasModel(segInd, [1]) = 1;
end
for segInd = 32:32
    hasModel(segInd, [1]) = 1;
end
for segInd = 34:34
    hasModel(segInd, [1]) = 1;
end
for segInd = 36:36
    hasModel(segInd, [1]) = 1;
end
for segInd = 38:42
    hasModel(segInd, [1]) = 1;
end
for segInd = 44:44
    hasModel(segInd, [1]) = 1;
end
for segInd = 46:46
    hasModel(segInd, [1]) = 1;
end
for segInd = 48:48
    hasModel(segInd, [1]) = 1;
end
for segInd = 50:50
    hasModel(segInd, [1]) = 1;
end
for segInd = 52:52
    hasModel(segInd, [1]) = 1;
end
for segInd = 54:54
    hasModel(segInd, [1]) = 1;
end
for segInd = 56:56
    hasModel(segInd, [1]) = 1;
end
for segInd = 58:58
    hasModel(segInd, [1]) = 1;
end
for segInd = 60:60
    hasModel(segInd, [1]) = 1;
end
for segInd = 62:62
    hasModel(segInd, [1]) = 1;
end
for segInd = 64:64
    hasModel(segInd, [1]) = 1;
end
for segInd = 66:66
    hasModel(segInd, [1]) = 1;
end
for segInd = 68:68
    hasModel(segInd, [1]) = 1;
end
for segInd = 70:70
    hasModel(segInd, [1]) = 1;
end
for segInd = 72:72
    hasModel(segInd, [1]) = 1;
end
for segInd = 74:74
    hasModel(segInd, [1]) = 1;
end
for segInd = 76:76
    hasModel(segInd, [1]) = 1;
end
for segInd = 78:78
    hasModel(segInd, [1]) = 1;
end
for segInd = 80:80
    hasModel(segInd, [1]) = 1;
end
for segInd = 82:82
    hasModel(segInd, [1]) = 1;
end
for segInd = 84:88
    hasModel(segInd, [1]) = 1;
end
for segInd = 90:90
    hasModel(segInd, [1]) = 1;
end
for segInd = 92:92
    hasModel(segInd, [1]) = 1;
end
for segInd = 94:94
    hasModel(segInd, [1]) = 1;
end
for segInd = 96:96
    hasModel(segInd, [1]) = 1;
end
for segInd = 98:98
    hasModel(segInd, [1]) = 1;
end
for segInd = 100:100
    hasModel(segInd, [1]) = 1;
end
for segInd = 102:102
    hasModel(segInd, [1]) = 1;
end
for segInd = 104:104
    hasModel(segInd, [1]) = 1;
end
for segInd = 106:106
    hasModel(segInd, [1]) = 1;
end
for segInd = 108:108
    hasModel(segInd, [1]) = 1;
end
for segInd = 110:110
    hasModel(segInd, [1]) = 1;
end
for segInd = 112:112
    hasModel(segInd, [1]) = 1;
end
for segInd = 114:114
    hasModel(segInd, [1]) = 1;
end
for segInd = 116:116
    hasModel(segInd, [1]) = 1;
end
for segInd = 118:118
    hasModel(segInd, [1]) = 1;
end
for segInd = 120:120
    hasModel(segInd, [1]) = 1;
end
for segInd = 122:122
    hasModel(segInd, [1]) = 1;
end
for segInd = 124:124
    hasModel(segInd, [1]) = 1;
end
for segInd = 126:126
    hasModel(segInd, [1]) = 1;
end
for segInd = 128:128
    hasModel(segInd, [1]) = 1;
end
for segInd = 130:130
    hasModel(segInd, [1]) = 1;
end
for segInd = 132:132
    hasModel(segInd, [1]) = 1;
end
for segInd = 134:134
    hasModel(segInd, [1]) = 1;
end
for segInd = 136:136
    hasModel(segInd, [1]) = 1;
end
for segInd = 138:138
    hasModel(segInd, [1]) = 1;
end
for segInd = 140:140
    hasModel(segInd, [1]) = 1;
end
for segInd = 142:142
    hasModel(segInd, [1]) = 1;
end
for segInd = 144:144
    hasModel(segInd, [1]) = 1;
end
for segInd = 146:146
    hasModel(segInd, [1]) = 1;
end
for segInd = 148:171
    hasModel(segInd, [1]) = 1;
end
for segInd = 173:177
    hasModel(segInd, [1]) = 1;
end
for segInd = 179:179
    hasModel(segInd, [1]) = 1;
end
for segInd = 181:181
    hasModel(segInd, [1]) = 1;
end
for segInd = 183:183
    hasModel(segInd, [1]) = 1;
end
for segInd = 185:185
    hasModel(segInd, [1]) = 1;
end
for segInd = 187:187
    hasModel(segInd, [1]) = 1;
end
for segInd = 189:189
    hasModel(segInd, [1]) = 1;
end
for segInd = 191:191
    hasModel(segInd, [1]) = 1;
end
for segInd = 193:193
    hasModel(segInd, [1]) = 1;
end
for segInd = 195:195
    hasModel(segInd, [1]) = 1;
end
for segInd = 197:197
    hasModel(segInd, [1]) = 1;
end
for segInd = 199:199
    hasModel(segInd, [1]) = 1;
end
for segInd = 201:201
    hasModel(segInd, [1]) = 1;
end
for segInd = 203:203
    hasModel(segInd, [1]) = 1;
end
for segInd = 205:205
    hasModel(segInd, [1]) = 1;
end
for segInd = 207:207
    hasModel(segInd, [1]) = 1;
end
for segInd = 209:209
    hasModel(segInd, [1]) = 1;
end
for segInd = 211:211
    hasModel(segInd, [1]) = 1;
end
for segInd = 213:213
    hasModel(segInd, [1]) = 1;
end
for segInd = 215:215
    hasModel(segInd, [1]) = 1;
end
for segInd = 217:217
    hasModel(segInd, [1]) = 1;
end
for segInd = 219:219
    hasModel(segInd, [1]) = 1;
end
for segInd = 221:221
    hasModel(segInd, [1]) = 1;
end
for segInd = 223:223
    hasModel(segInd, [1]) = 1;
end
for segInd = 225:225
    hasModel(segInd, [1]) = 1;
end
for segInd = 227:227
    hasModel(segInd, [1]) = 1;
end
for segInd = 229:229
    hasModel(segInd, [1]) = 1;
end
for segInd = 231:231
    hasModel(segInd, [1]) = 1;
end
for segInd = 233:233
    hasModel(segInd, [1]) = 1;
end
for segInd = 235:235
    hasModel(segInd, [1]) = 1;
end
for segInd = 237:237
    hasModel(segInd, [1]) = 1;
end
for segInd = 239:239
    hasModel(segInd, [1]) = 1;
end
for segInd = 241:241
    hasModel(segInd, [1]) = 1;
end
for segInd = 243:243
    hasModel(segInd, [1]) = 1;
end
for segInd = 245:245
    hasModel(segInd, [1]) = 1;
end
for segInd = 247:247
    hasModel(segInd, [1]) = 1;
end
for segInd = 249:249
    hasModel(segInd, [1]) = 1;
end
for segInd = 251:251
    hasModel(segInd, [1]) = 1;
end
for segInd = 253:257
    hasModel(segInd, [1]) = 1;
end
for segInd = 259:259
    hasModel(segInd, [1]) = 1;
end
for segInd = 261:261
    hasModel(segInd, [1]) = 1;
end
for segInd = 263:263
    hasModel(segInd, [1]) = 1;
end
for segInd = 265:265
    hasModel(segInd, [1]) = 1;
end
for segInd = 267:267
    hasModel(segInd, [1]) = 1;
end
for segInd = 269:269
    hasModel(segInd, [1]) = 1;
end
for segInd = 271:271
    hasModel(segInd, [1]) = 1;
end
for segInd = 273:277
    hasModel(segInd, [1]) = 1;
end
for segInd = 279:279
    hasModel(segInd, [1]) = 1;
end
for segInd = 281:281
    hasModel(segInd, [1]) = 1;
end
for segInd = 283:283
    hasModel(segInd, [1]) = 1;
end
for segInd = 285:285
    hasModel(segInd, [1]) = 1;
end
for segInd = 287:287
    hasModel(segInd, [1]) = 1;
end
for segInd = 289:289
    hasModel(segInd, [1]) = 1;
end
for segInd = 291:291
    hasModel(segInd, [1]) = 1;
end
for segInd = 293:297
    hasModel(segInd, [1]) = 1;
end
for segInd = 299:299
    hasModel(segInd, [1]) = 1;
end
for segInd = 301:301
    hasModel(segInd, [1]) = 1;
end
for segInd = 303:303
    hasModel(segInd, [1]) = 1;
end
for segInd = 305:305
    hasModel(segInd, [1]) = 1;
end
for segInd = 307:307
    hasModel(segInd, [1]) = 1;
end
for segInd = 309:309
    hasModel(segInd, [1]) = 1;
end
for segInd = 311:311
    hasModel(segInd, [1]) = 1;
end
for segInd = 313:313
    hasModel(segInd, [1]) = 1;
end
for segInd = 315:315
    hasModel(segInd, [1]) = 1;
end
for segInd = 317:317
    hasModel(segInd, [1]) = 1;
end
for segInd = 319:319
    hasModel(segInd, [1]) = 1;
end
for segInd = 321:321
    hasModel(segInd, [1]) = 1;
end
for segInd = 323:323
    hasModel(segInd, [1]) = 1;
end
for segInd = 325:325
    hasModel(segInd, [1]) = 1;
end
for segInd = 327:327
    hasModel(segInd, [1]) = 1;
end
for segInd = 329:329
    hasModel(segInd, [1]) = 1;
end
for segInd = 331:331
    hasModel(segInd, [1]) = 1;
end
for segInd = 333:333
    hasModel(segInd, [1]) = 1;
end
for segInd = 335:335
    hasModel(segInd, [1]) = 1;
end
for segInd = 337:337
    hasModel(segInd, [1]) = 1;
end
for segInd = 339:339
    hasModel(segInd, [1]) = 1;
end
for segInd = 341:341
    hasModel(segInd, [1]) = 1;
end
for segInd = 343:343
    hasModel(segInd, [1]) = 1;
end
for segInd = 345:349
    hasModel(segInd, [1]) = 1;
end
for segInd = 351:351
    hasModel(segInd, [1]) = 1;
end
for segInd = 353:353
    hasModel(segInd, [1]) = 1;
end
for segInd = 355:355
    hasModel(segInd, [1]) = 1;
end
for segInd = 357:357
    hasModel(segInd, [1]) = 1;
end
for segInd = 359:359
    hasModel(segInd, [1]) = 1;
end
for segInd = 361:361
    hasModel(segInd, [1]) = 1;
end
for segInd = 363:363
    hasModel(segInd, [1]) = 1;
end
for segInd = 365:365
    hasModel(segInd, [1]) = 1;
end
for segInd = 367:367
    hasModel(segInd, [1]) = 1;
end
for segInd = 369:369
    hasModel(segInd, [1]) = 1;
end
for segInd = 371:371
    hasModel(segInd, [1]) = 1;
end
for segInd = 373:373
    hasModel(segInd, [1]) = 1;
end
for segInd = 375:375
    hasModel(segInd, [1]) = 1;
end
for segInd = 377:377
    hasModel(segInd, [1]) = 1;
end
for segInd = 379:379
    hasModel(segInd, [1]) = 1;
end
for segInd = 381:381
    hasModel(segInd, [1]) = 1;
end
for segInd = 383:383
    hasModel(segInd, [1]) = 1;
end
for segInd = 385:385
    hasModel(segInd, [1]) = 1;
end
for segInd = 387:387
    hasModel(segInd, [1]) = 1;
end
for segInd = 389:389
    hasModel(segInd, [1]) = 1;
end
for segInd = 391:391
    hasModel(segInd, [1]) = 1;
end
for segInd = 393:393
    hasModel(segInd, [1]) = 1;
end
for segInd = 395:395
    hasModel(segInd, [1]) = 1;
end
for segInd = 397:397
    hasModel(segInd, [1]) = 1;
end
for segInd = 399:399
    hasModel(segInd, [1]) = 1;
end
for segInd = 401:401
    hasModel(segInd, [1]) = 1;
end
for segInd = 403:403
    hasModel(segInd, [1]) = 1;
end
for segInd = 405:405
    hasModel(segInd, [1]) = 1;
end
for segInd = 407:407
    hasModel(segInd, [1]) = 1;
end
for segInd = 409:409
    hasModel(segInd, [1]) = 1;
end
for segInd = 411:411
    hasModel(segInd, [1]) = 1;
end
for segInd = 413:413
    hasModel(segInd, [1]) = 1;
end
for segInd = 415:415
    hasModel(segInd, []) = 1;
end
hasModel([2],2)=1;

