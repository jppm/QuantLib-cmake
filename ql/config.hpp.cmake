/* ${CONFIG_HPP_CMAKE} */

/* Define to 1 if you have the <dlfcn.h> header file. */
${HAVE_DLFCN_H}

/* Define to 1 if you have the <inttypes.h> header file. */
${HAVE_INTTYPES_H}

/* Define to 1 if you have the <memory.h> header file. */
${HAVE_MEMORY_H}

/* Define to 1 if you have the <stdint.h> header file. */
${HAVE_STDINT_H}

/* Define to 1 if you have the <stdlib.h> header file. */
${HAVE_STDLIB_H}

/* Define to 1 if you have the <strings.h> header file. */
${HAVE_STRINGS_H}

/* Define to 1 if you have the <string.h> header file. */
${HAVE_STRING_H}

/* Define to 1 if you have the <sys/stat.h> header file. */
${HAVE_SYS_STAT_H}

/* Define to 1 if you have the <sys/types.h> header file. */
${HAVE_SYS_TYPES_H}

/* Define to 1 if you have the <unistd.h> header file. */
${HAVE_UNISTD_H}

/* Define to the sub-directory in which libtool stores uninstalled libraries.
   */
#undef LT_OBJDIR

/* Name of package */
#define PACKAGE "${PACKAGE}"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "${PACKAGE_BUGREPORT}"

/* Define to the full name of this package. */
#define PACKAGE_NAME "${PACKAGE_NAME}"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "${PACKAGE_STRING}"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "${PACKAGE_TARNAME}"

/* Define to the home page for this package. */
#define PACKAGE_URL "${PACKAGE_URL}"

/* Define to the version of this package. */
#define PACKAGE_VERSION "${PACKAGE_VERSION}"

/* Define this if you want to disable deprecated code. */
${QL_DISABLE_DEPRECATED}

/* Define this if you want to enable sessions. */
${QL_ENABLE_SESSIONS}

/* Define this if tracing messages should allowed (whether they are actually
   emitted will depend on run-time settings.) */
${QL_ENABLE_TRACING}

/* Define this if error messages should include current function information. */
${QL_ERROR_FUNCTIONS}

/* Define this if error messages should include file and line information. */
${QL_ERROR_LINES}

/* Define this if extra safety checks should be performed. This can degrade
   performance. */
${QL_EXTRA_SAFETY_CHECKS}

/* Define this if your compiler defines asinh in <cmath>. */
${QL_HAVE_ASINH}

/* Define this if your compiler supports the long long type. */
${QL_HAVE_LONG_LONG}

/* Define this if negative yield rates should be allowed. This might not be
   safe. */
${QL_NEGATIVE_RATES}

/* Define this if your compiler does not support Boost::uBLAS. */
${QL_NO_UBLAS_SUPPORT}

/* Define if running on a Mac OS X machine. */
${QL_PATCH_DARWIN}

/* Define if running on a Sun Solaris machine. */
${QL_PATCH_SOLARIS}

/* Define this to use indexed coupons instead of par coupons in floating legs.
   */
${QL_USE_INDEXED_COUPON}

/* Define to 1 if you have the ANSI C header files. */
${STDC_HEADERS}

/* Version number of package */
#define VERSION "${VERSION}"

