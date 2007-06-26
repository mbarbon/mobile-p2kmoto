#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant_9 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     P2K_E_BUG P2K_E_CPH P2K_E_OLD */
  /* Offset 8 gives the best switch position.  */
  switch (name[8]) {
  case 'D':
    if (memEQ(name, "P2K_E_OL", 8)) {
    /*                       D     */
#ifdef P2K_E_OLD
      *iv_return = P2K_E_OLD;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'G':
    if (memEQ(name, "P2K_E_BU", 8)) {
    /*                       G     */
#ifdef P2K_E_BUG
      *iv_return = P2K_E_BUG;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'H':
    if (memEQ(name, "P2K_E_CP", 8)) {
    /*                       H     */
#ifdef P2K_E_CPH
      *iv_return = P2K_E_CPH;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_12 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     P2K_E_CPH_00 P2K_E_CPH_01 P2K_E_CPH_03 P2K_PHONE_AT P2K_SEEK_END */
  /* Offset 11 gives the best switch position.  */
  switch (name[11]) {
  case '0':
    if (memEQ(name, "P2K_E_CPH_0", 11)) {
    /*                          0      */
#ifdef P2K_E_CPH_00
      *iv_return = P2K_E_CPH_00;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case '1':
    if (memEQ(name, "P2K_E_CPH_0", 11)) {
    /*                          1      */
#ifdef P2K_E_CPH_01
      *iv_return = P2K_E_CPH_01;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case '3':
    if (memEQ(name, "P2K_E_CPH_0", 11)) {
    /*                          3      */
#ifdef P2K_E_CPH_03
      *iv_return = P2K_E_CPH_03;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'D':
    if (memEQ(name, "P2K_SEEK_EN", 11)) {
    /*                          D      */
#ifdef P2K_SEEK_END
      *iv_return = P2K_SEEK_END;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'T':
    if (memEQ(name, "P2K_PHONE_A", 11)) {
    /*                          T      */
#ifdef P2K_PHONE_AT
      *iv_return = P2K_PHONE_AT;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_13 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     P2K_E_CPH_02a P2K_E_CPH_02b P2K_E_INPDATA P2K_E_INPSIZE P2K_E_NOPHONE
     P2K_E_OUTDATA P2K_PHONE_P2K */
  /* Offset 10 gives the best switch position.  */
  switch (name[10]) {
  case '0':
    if (memEQ(name, "P2K_E_CPH_02a", 13)) {
    /*                         ^         */
#ifdef P2K_E_CPH_02a
      *iv_return = P2K_E_CPH_02a;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "P2K_E_CPH_02b", 13)) {
    /*                         ^         */
#ifdef P2K_E_CPH_02b
      *iv_return = P2K_E_CPH_02b;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'A':
    if (memEQ(name, "P2K_E_INPDATA", 13)) {
    /*                         ^         */
#ifdef P2K_E_INPDATA
      *iv_return = P2K_E_INPDATA;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "P2K_E_OUTDATA", 13)) {
    /*                         ^         */
#ifdef P2K_E_OUTDATA
      *iv_return = P2K_E_OUTDATA;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'I':
    if (memEQ(name, "P2K_E_INPSIZE", 13)) {
    /*                         ^         */
#ifdef P2K_E_INPSIZE
      *iv_return = P2K_E_INPSIZE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'O':
    if (memEQ(name, "P2K_E_NOPHONE", 13)) {
    /*                         ^         */
#ifdef P2K_E_NOPHONE
      *iv_return = P2K_E_NOPHONE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'P':
    if (memEQ(name, "P2K_PHONE_P2K", 13)) {
    /*                         ^         */
#ifdef P2K_PHONE_P2K
      *iv_return = P2K_PHONE_P2K;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(P2K_E_ANSWER_E001 P2K_E_ANSWER_E002 P2K_E_BUFFER_TOOLONG
	       P2K_E_BUG P2K_E_CANT_CLAIMIFACE P2K_E_CANT_CLOSE P2K_E_CANT_OPEN
	       P2K_E_CANT_SETCONFIG P2K_E_CPH P2K_E_CPH_00 P2K_E_CPH_01
	       P2K_E_CPH_02a P2K_E_CPH_02b P2K_E_CPH_03
	       P2K_E_INCORRECT_SEEMSIZE P2K_E_INPDATA P2K_E_INPSIZE
	       P2K_E_NOPHONE P2K_E_NOT_CONNECTED P2K_E_OLD P2K_E_OUTDATA
	       P2K_PHONE_AT P2K_PHONE_NONE P2K_PHONE_P2K P2K_SEEK_BEGIN
	       P2K_SEEK_CURRENT P2K_SEEK_END));

print constant_types(); # macro defs
foreach (C_constant ("Mobile::P2kMoto", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "#### XS Section:\n";
print XS_constant ("Mobile::P2kMoto", $types);
__END__
   */

  switch (len) {
  case 9:
    return constant_9 (aTHX_ name, iv_return);
    break;
  case 12:
    return constant_12 (aTHX_ name, iv_return);
    break;
  case 13:
    return constant_13 (aTHX_ name, iv_return);
    break;
  case 14:
    /* Names all of length 14.  */
    /* P2K_PHONE_NONE P2K_SEEK_BEGIN */
    /* Offset 4 gives the best switch position.  */
    switch (name[4]) {
    case 'P':
      if (memEQ(name, "P2K_PHONE_NONE", 14)) {
      /*                   ^                */
#ifdef P2K_PHONE_NONE
        *iv_return = P2K_PHONE_NONE;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'S':
      if (memEQ(name, "P2K_SEEK_BEGIN", 14)) {
      /*                   ^                */
#ifdef P2K_SEEK_BEGIN
        *iv_return = P2K_SEEK_BEGIN;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 15:
    if (memEQ(name, "P2K_E_CANT_OPEN", 15)) {
#ifdef P2K_E_CANT_OPEN
      *iv_return = P2K_E_CANT_OPEN;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 16:
    /* Names all of length 16.  */
    /* P2K_E_CANT_CLOSE P2K_SEEK_CURRENT */
    /* Offset 6 gives the best switch position.  */
    switch (name[6]) {
    case 'C':
      if (memEQ(name, "P2K_E_CANT_CLOSE", 16)) {
      /*                     ^                */
#ifdef P2K_E_CANT_CLOSE
        *iv_return = P2K_E_CANT_CLOSE;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'E':
      if (memEQ(name, "P2K_SEEK_CURRENT", 16)) {
      /*                     ^                */
#ifdef P2K_SEEK_CURRENT
        *iv_return = P2K_SEEK_CURRENT;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 17:
    /* Names all of length 17.  */
    /* P2K_E_ANSWER_E001 P2K_E_ANSWER_E002 */
    /* Offset 16 gives the best switch position.  */
    switch (name[16]) {
    case '1':
      if (memEQ(name, "P2K_E_ANSWER_E00", 16)) {
      /*                               1      */
#ifdef P2K_E_ANSWER_E001
        *iv_return = P2K_E_ANSWER_E001;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case '2':
      if (memEQ(name, "P2K_E_ANSWER_E00", 16)) {
      /*                               2      */
#ifdef P2K_E_ANSWER_E002
        *iv_return = P2K_E_ANSWER_E002;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 19:
    if (memEQ(name, "P2K_E_NOT_CONNECTED", 19)) {
#ifdef P2K_E_NOT_CONNECTED
      *iv_return = P2K_E_NOT_CONNECTED;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 20:
    /* Names all of length 20.  */
    /* P2K_E_BUFFER_TOOLONG P2K_E_CANT_SETCONFIG */
    /* Offset 6 gives the best switch position.  */
    switch (name[6]) {
    case 'B':
      if (memEQ(name, "P2K_E_BUFFER_TOOLONG", 20)) {
      /*                     ^                    */
#ifdef P2K_E_BUFFER_TOOLONG
        *iv_return = P2K_E_BUFFER_TOOLONG;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'C':
      if (memEQ(name, "P2K_E_CANT_SETCONFIG", 20)) {
      /*                     ^                    */
#ifdef P2K_E_CANT_SETCONFIG
        *iv_return = P2K_E_CANT_SETCONFIG;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 21:
    if (memEQ(name, "P2K_E_CANT_CLAIMIFACE", 21)) {
#ifdef P2K_E_CANT_CLAIMIFACE
      *iv_return = P2K_E_CANT_CLAIMIFACE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 24:
    if (memEQ(name, "P2K_E_INCORRECT_SEEMSIZE", 24)) {
#ifdef P2K_E_INCORRECT_SEEMSIZE
      *iv_return = P2K_E_INCORRECT_SEEMSIZE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

