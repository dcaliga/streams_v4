/* $Id: ex13.mc,v 1.1 2007/07/09 16:25:17 hammes Exp $ */

/*
 * Copyright 2005 SRC Computers, Inc.  All Rights Reserved.
 *
 *	Manufactured in the United States of America.
 *
 * SRC Computers, Inc.
 * 4240 N Nevada Avenue
 * Colorado Springs, CO 80907
 * (v) (719) 262-0213
 * (f) (719) 262-0223
 *
 * No permission has been granted to distribute this software
 * without the express permission of SRC Computers, Inc.
 *
 * This program is distributed WITHOUT ANY WARRANTY OF ANY KIND.
 */

#include <libmap.h>


void subr (int64_t In[], int64_t Out[], int num, int *nret, int64_t *time, int mapnum) {
    OBM_BANK_A (AL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_C (CL, int64_t, MAX_OBM_SIZE)
    int64_t t0, t1;
    Stream_64 S0, S1;

    read_timer (&t0);


    #pragma src parallel sections
    {
    #pragma src section
	{
    	int i;
    	int64_t v0,v1;

        for (i=0; i<num; i++) {
           v0 = AL[i];

   	       put_stream_64 (&S0, v0, 1);
	       get_stream_64 (&S1, &v1);
	    }
	}

    #pragma src section
	{
	    int i;
	    int64_t v0,v1;

        for (i=0; i<num; i++) {
	       get_stream_64 (&S0, &v1);
	       put_stream_64 (&S1, v1, 1);
        }
    }

    }

    read_timer (&t1);

    *time = t1 - t0;

    }

