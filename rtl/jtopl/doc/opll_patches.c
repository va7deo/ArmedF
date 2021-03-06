#include "opll.h"
#include <stdio.h>

opll_patch_t patch_ym2413[opll_patch_max] = {
    { 0x1e, 0x01, 0x00, 0x07,{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x0d, 0x07 },{ 0x00, 0x08 },{ 0x00, 0x01 },{ 0x00, 0x07 } },
    { 0x1a, 0x00, 0x01, 0x05,{ 0x00, 0x00 },{ 0x00, 0x01 },{ 0x00, 0x00 },{ 0x01, 0x00 },{ 0x03, 0x01 },{ 0x00, 0x00 },{ 0x0d, 0x0f },{ 0x08, 0x07 },{ 0x02, 0x01 },{ 0x03, 0x03 } },
    { 0x19, 0x00, 0x00, 0x00,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x00 },{ 0x03, 0x01 },{ 0x02, 0x00 },{ 0x0f, 0x0c },{ 0x02, 0x04 },{ 0x01, 0x02 },{ 0x01, 0x03 } },
    { 0x0e, 0x00, 0x00, 0x07,{ 0x00, 0x00 },{ 0x00, 0x01 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x0a, 0x06 },{ 0x08, 0x04 },{ 0x07, 0x02 },{ 0x00, 0x07 } },
    { 0x1e, 0x00, 0x00, 0x06,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x02, 0x01 },{ 0x00, 0x00 },{ 0x0e, 0x07 },{ 0x00, 0x06 },{ 0x00, 0x02 },{ 0x00, 0x08 } },
    { 0x16, 0x00, 0x00, 0x05,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x01, 0x02 },{ 0x00, 0x00 },{ 0x0e, 0x07 },{ 0x00, 0x01 },{ 0x00, 0x01 },{ 0x00, 0x08 } },
    { 0x1d, 0x00, 0x00, 0x07,{ 0x00, 0x00 },{ 0x00, 0x01 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x08, 0x08 },{ 0x02, 0x01 },{ 0x01, 0x00 },{ 0x00, 0x07 } },
    { 0x2d, 0x01, 0x00, 0x04,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x03, 0x01 },{ 0x00, 0x00 },{ 0x0a, 0x07 },{ 0x02, 0x02 },{ 0x00, 0x00 },{ 0x00, 0x07 } },
    { 0x1b, 0x00, 0x00, 0x06,{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x06, 0x06 },{ 0x04, 0x05 },{ 0x01, 0x01 },{ 0x00, 0x07 } },
    { 0x0b, 0x01, 0x01, 0x00,{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x01 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x00, 0x00 },{ 0x08, 0x0f },{ 0x05, 0x07 },{ 0x07, 0x00 },{ 0x01, 0x07 } },
    { 0x03, 0x01, 0x00, 0x01,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x00 },{ 0x03, 0x01 },{ 0x02, 0x00 },{ 0x0f, 0x0e },{ 0x0a, 0x04 },{ 0x01, 0x00 },{ 0x00, 0x04 } },
    { 0x24, 0x00, 0x00, 0x07,{ 0x00, 0x01 },{ 0x00, 0x01 },{ 0x00, 0x00 },{ 0x01, 0x00 },{ 0x07, 0x01 },{ 0x00, 0x00 },{ 0x0f, 0x0f },{ 0x08, 0x08 },{ 0x02, 0x01 },{ 0x02, 0x02 } },
    { 0x0c, 0x00, 0x00, 0x05,{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x00, 0x01 },{ 0x01, 0x00 },{ 0x00, 0x00 },{ 0x0c, 0x0f },{ 0x02, 0x05 },{ 0x02, 0x04 },{ 0x00, 0x02 } },
    { 0x15, 0x00, 0x00, 0x03,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x0c, 0x09 },{ 0x09, 0x05 },{ 0x00, 0x00 },{ 0x03, 0x02 } },
    { 0x09, 0x00, 0x00, 0x03,{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x01, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x01 },{ 0x02, 0x00 },{ 0x0f, 0x0e },{ 0x01, 0x04 },{ 0x04, 0x01 },{ 0x00, 0x03 } },

    { 0x18, 0x00, 0x01, 0x07,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x00 },{ 0x00, 0x00 },{ 0x0d, 0x00 },{ 0x0f, 0x00 },{ 0x06, 0x00 },{ 0x0a, 0x00 } },
    { 0x00, 0x00, 0x00, 0x00,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x01, 0x00 },{ 0x00, 0x00 },{ 0x0c, 0x00 },{ 0x08, 0x00 },{ 0x0a, 0x00 },{ 0x07, 0x00 } },
    { 0x00, 0x00, 0x00, 0x00,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x05, 0x00 },{ 0x00, 0x00 },{ 0x0f, 0x00 },{ 0x08, 0x00 },{ 0x05, 0x00 },{ 0x09, 0x00 } },
    { 0x00, 0x00, 0x00, 0x00,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x01 },{ 0x00, 0x00 },{ 0x00, 0x0f },{ 0x00, 0x08 },{ 0x00, 0x06 },{ 0x00, 0x0d } },
    { 0x00, 0x00, 0x00, 0x00,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x01 },{ 0x00, 0x00 },{ 0x00, 0x0d },{ 0x00, 0x08 },{ 0x00, 0x04 },{ 0x00, 0x08 } },
    { 0x00, 0x00, 0x00, 0x00,{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x00 },{ 0x00, 0x01 },{ 0x00, 0x00 },{ 0x00, 0x0a },{ 0x00, 0x0a },{ 0x00, 0x05 },{ 0x00, 0x05 } }
};

void make_bin(char *data) {
    for( int k=0; k<opll_patch_max; k++ ) {
        opll_patch_t *p = &patch_ym2413[k];
        int d[8];
        d[0]=(p->am[0]<<7)
          | (p->vib[0]<<6)
          | (p->et[0]<<5)
          | (p->ksr[0]<<4)
          | (p->multi[0]);
        d[1]=(p->am[1]<<7)
          | (p->vib[1]<<6)
          | (p->et[1]<<5)
          | (p->ksr[1]<<4)
          | (p->multi[1]);
        d[2]=(p->ksl[0]<<6) | (p->tl);
        d[3]=(p->ksl[1]<<6) | (p->dc<<4)
            | (p->dm<<3) | (p->fb);
        d[4]=(p->ar[0]<<4) | (p->dr[0]);
        d[5]=(p->ar[1]<<4) | (p->dr[1]);
        d[6]=(p->sl[0]<<4) | (p->rr[0]);
        d[7]=(p->sl[1]<<4) | (p->rr[1]);
        for( int j=0; j<8; j++ ) {
            *data++ = d[j];
        }
    }
}

int main() {
    char data[8*21];
    make_bin(data);
    for( int j=0;j<21;j++ ) {
        printf("    patch[%02d]=64'h",j+1);
        char *p = data+8*(j+1)-1;
        for( int k=7; k>=0; k-- ) {
            printf("%02X",(unsigned)(*p--)&0xff);
        }
        printf(";\n");
    }
    return 0;
}

