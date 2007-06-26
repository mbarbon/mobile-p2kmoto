#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <p2kmoto.h>

#include "const-c.inc"

#define Mobile_P2kMoto_FS_FileInfo struct p2k_fileInfo
#define Mobile_P2kMoto_Java_Midlet struct p2k_perl_Midlet

static SV* p2k_perl_callback;

#define p2k_perl_min( a, b ) ( (a) < (b) ? (a) : (b) )

void
p2k_perl_setbuf( SV* sv, char* dest, size_t size )
{
    dTHX;
    STRLEN len;
    char* buf;

    buf = SvPVbyte( sv, len );
    strncpy( dest, buf, p2k_perl_min( size - 1, len ) );
    dest[size - 1] = 0;
}

void
p2k_perl_onFile( struct p2k_fileInfo file )
{
    dTHX;
    dSP;

    ENTER;
    SAVETMPS;

    SV* info = sv_2mortal( sv_setref_pv( newSViv( 0 ),
                                         "Mobile::P2kMoto::FS::FileInfo",
                                         &file ) );

    PUSHMARK( SP );
    XPUSHs( info );
    PUTBACK;

    call_sv( p2k_perl_callback, G_DISCARD | G_VOID | G_EVAL );

    FREETMPS;
    LEAVE;
}

/* from moto4lin/moto_ui/midlet.h */
struct p2k_perl_Midlet_m4lin {
    char showInMenu;
    char b1[2]; /* 0x00 */
    char idx;   /* Position in list */
    char name[33]; /* Midlet Name */
    char vendor[38];  /* Midlet Vendor */
    char b2;  /* b76 1 */
    char b3[3]; /* 0x00 */
    char b4; /* b80 1 */
    char b5[3]; /* 0x00 */
    char b6; /* b84 */
    char b7; /* 0x00 */
    char b8; /* 0x01 */
    char b9[3]; /* 0x00 */
    char size[3]; /* Midlet size */
    char bA[10]; /* 0x00 */
    char ico1; /* 01 - Nonstandart icon */
    char ico2[5];
    char menuName[33];
    char startupClass[519];
};

/* from moto4lin/moto_ui/midlet.h + guesses */
struct p2k_perl_Midlet_v360 {
    char a1;
    char showInMenu;
    char b1[3]; /* 0x00 */
    char idx;   /* Position in list */
    char name[33]; /* Midlet Name */
    char vendor[33];  /* Midlet Vendor */
    char a2[20];
    char a3[3]; /*  4 bytes big endian x 3 (version ) */
    char b2;  /* b76 1 */
    char b3[3]; /* 0x00 */
    char b4; /* b80 1 */
    char b5[3]; /* 0x00 */
    char b6; /* b84 */
    char b7; /* 0x00 */
    char b8; /* 0x01 */
    char b9[3]; /*  4 bytes big endian */
    char size[3]; /* Midlet size */
    char bA[11]; /* 0x00 */
    char f1[4];
    char aF[25];
    char menuName[33];
    char startupClass[519];
    char f2[4];
};

#define p2k_perl_Midlet p2k_perl_Midlet_v360

MODULE = Mobile::P2kMoto PACKAGE = Mobile::P2kMoto::FS::FileInfo

int
Mobile_P2kMoto_FS_FileInfo::id()
  CODE:
    RETVAL = THIS->id;
  OUTPUT: RETVAL

const char*
Mobile_P2kMoto_FS_FileInfo::name()
  CODE:
    RETVAL = THIS->name;
  OUTPUT: RETVAL

int
Mobile_P2kMoto_FS_FileInfo::size()
  CODE:
    RETVAL = THIS->size;
  OUTPUT: RETVAL

int
Mobile_P2kMoto_FS_FileInfo::owner()
  CODE:
    RETVAL = THIS->owner;
  OUTPUT: RETVAL

int
Mobile_P2kMoto_FS_FileInfo::attributes()
  CODE:
    RETVAL = THIS->attr;
  OUTPUT: RETVAL

MODULE = Mobile::P2kMoto PACKAGE = Mobile::P2kMoto PREFIX = p2k_

INCLUDE: const-xs.inc

int
p2k_closePhone()
        
int
p2k_detectPhone()

int
p2k_findPhone()

void
p2k_getACMdevice(dev)
    char* dev

int
p2k_getATproduct()

int
p2k_getATvendor()

#if 0 /* later */

##struct p2k_devInfo*
##p2k_getDevList()

#endif

int
p2k_getP2Kproduct()

int
p2k_getP2Kvendor()

#if 0 /* later */

##int
##p2k_getPhoneModel(buf)
##    unsigned char* buf

##int
##p2k_getDriveNames(buf)
##    unsigned char* buf

#endif

void
p2k_init()

int
p2k_openPhone(timeout)
    int timeout


int
p2k_reboot()

void
p2k_setACMdevice(dev)
    char* dev

void
p2k_setATconfig(vendor, product)
    unsigned int vendor
    unsigned int product

void
p2k_setP2Kconfig(vendor, product)
    unsigned int vendor
    unsigned int product

int
p2k_setP2Kmode(timeout)
    int timeout

int
p2k_suspend()

#if 0 /* later */

##int
##p2k_readSeem(x, y, seemBuf, seemBufSize)
##    int x
##    int y
##    unsigned char* seemBuf
##    int seemBufSize

##int
##p2k_writeSeem(x, y, seemBuf, seemSize)
##    int x
##    int y
##    unsigned char* seemBuf
##    int seemSize

#endif

MODULE = Mobile::P2kMoto  PACKAGE = Mobile::P2kMoto::FS PREFIX = p2k_FSAC_

int
p2k_FSAC_close()

int
p2k_FSAC_createDir(dirname)
    char* dirname

int
p2k_FSAC_delete(fname)
    char* fname

int
p2k_FSAC_fileList(onGetFile)
    SV* onGetFile
  CODE:
    p2k_perl_callback = onGetFile;
    RETVAL = p2k_FSAC_fileList( p2k_perl_onFile );
    if( SvTRUE( ERRSV ) )
    {
        croak( Nullch );
    }
  OUTPUT: RETVAL

#if 0 /* later */

##int
##p2k_FSAC_getVersion(buf)
##    char* buf

#endif

int
p2k_FSAC_getVolumeFreeSpace(volume)
    char* volume

#if 0 /* later */

##int
##p2k_FSAC_getVolumes(buf)
##    char* buf

#endif

int
p2k_FSAC_open(fname, attr)
    char* fname
    unsigned char attr

int
p2k_FSAC_read(buf, size)
    unsigned char* buf
    int size

int
p2k_FSAC_removeDir(dirname)
    char* dirname

int
p2k_FSAC_searchRequest(request)
    char* request

int
p2k_FSAC_seek(offset, dir)
    unsigned long offset
    char dir

int
p2k_FSAC_write(tbuf, size)
    unsigned char* tbuf
    int size

MODULE=Mobile::P2kMoto PACKAGE=Mobile::P2kMoto::Java

MODULE=Mobile::P2kMoto PACKAGE=Mobile::P2kMoto::Java::Midlet

static int
Mobile_P2kMoto_Java_Midlet::byte_size()
  CODE:
    RETVAL = sizeof(struct p2k_perl_Midlet);
  OUTPUT: RETVAL

Mobile_P2kMoto_Java_Midlet*
Mobile_P2kMoto_Java_Midlet::new()
  CODE:
    RETVAL = malloc( sizeof(struct p2k_perl_Midlet) );
    memset( RETVAL, 0, sizeof(struct p2k_perl_Midlet) );
    RETVAL->b8 = 0x01;
    RETVAL->f1[1] = 0x02;
    RETVAL->f1[3] = 0x01;
    RETVAL->f2[0] = 0x02;
  OUTPUT: RETVAL

int
Mobile_P2kMoto_Java_Midlet::show_in_menu()
  CODE:
    RETVAL = THIS->showInMenu;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_show_in_menu( val )
    int val
  CODE:
    THIS->showInMenu = (char) val;

int
Mobile_P2kMoto_Java_Midlet::index()
  CODE:
    RETVAL = THIS->idx;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_index( val )
    int val
  CODE:
    THIS->idx = (char) val;

const char*
Mobile_P2kMoto_Java_Midlet::name()
  CODE:
    RETVAL = THIS->name;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_name( val )
    SV* val
  CODE:
    p2k_perl_setbuf( val, THIS->name, sizeof(THIS->name) );

const char*
Mobile_P2kMoto_Java_Midlet::vendor()
  CODE:
    RETVAL = THIS->vendor;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_vendor( val )
    SV* val
  CODE:
    p2k_perl_setbuf( val, THIS->vendor, sizeof(THIS->vendor) );

void
Mobile_P2kMoto_Java_Midlet::version()
  PPCODE:
    XPUSHs( newSViv( THIS->b2 ) );
    XPUSHs( newSViv( THIS->b4 ) );
    XPUSHs( newSViv( THIS->b6 ) );

void
Mobile_P2kMoto_Java_Midlet::set_version( v1, v2, v3 )
    int v1
    int v2
    int v3
  CODE:
    THIS->b2 = (char) v1;
    THIS->b4 = (char) v2;
    THIS->b6 = (char) v3;

int
Mobile_P2kMoto_Java_Midlet::size()
  PREINIT:
    union sz {
        int  size_i;
        char size_c[4];
    } size_u;
  CODE:
    size_u.size_i = 0;
    size_u.size_c[2] = THIS->size[0]; /* endianness? what? */
    size_u.size_c[1] = THIS->size[1];
    size_u.size_c[0] = THIS->size[2];
    RETVAL = size_u.size_i;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_size( size )
    int size;
  PREINIT:
    union sz {
        int  size_i;
        char size_c[4];
    } size_u;
  CODE:
    size_u.size_i = size;
    THIS->size[0] = size_u.size_c[2]; /* endianness? what? */
    THIS->size[1] = size_u.size_c[1];
    THIS->size[2] = size_u.size_c[0];

#if 0

int
Mobile_P2kMoto_Java_Midlet::icon_flag()
  CODE:
    RETVAL = THIS->ico1;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_icon_flag( val )
    int val
  CODE:
    THIS->ico1 = (char) val;

#endif

const char*
Mobile_P2kMoto_Java_Midlet::menu_name()
  CODE:
    RETVAL = THIS->menuName;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_menu_name( val )
    SV* val
  CODE:
    p2k_perl_setbuf( val, THIS->menuName, sizeof(THIS->menuName) );

const char*
Mobile_P2kMoto_Java_Midlet::startup_class()
  CODE:
    RETVAL = THIS->startupClass;
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_startup_class( val )
    SV* val
  CODE:
    p2k_perl_setbuf( val, THIS->startupClass, sizeof(THIS->startupClass) );

SV*
Mobile_P2kMoto_Java_Midlet::bytes()
  CODE:
    RETVAL = newSVpvn( (char*) THIS, sizeof(struct p2k_perl_Midlet) );
  OUTPUT: RETVAL

void
Mobile_P2kMoto_Java_Midlet::set_bytes( val )
    SV* val
  PREINIT:
    char* buf;
    STRLEN len;
  CODE:
    buf = SvPVbyte( val, len );
    memcpy( (char*) THIS, buf, p2k_perl_min( len, sizeof(struct p2k_perl_Midlet) ) );

