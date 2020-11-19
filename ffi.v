module ffi

#flag -lffi
#flag -I@VROOT/
#flag @VROOT/ffiv.o
#include "ffiv.h"

pub const (
    DEFAULT_ABI = C.FFI_DEFAULT_ABI
)
pub const (
    OK = C.FFI_OK
    BAD_TYPEDEF = C.FFI_BAD_TYPEDEF
    BAD_ABI = C.FFI_BAD_ABI
)
pub const (
    TYPE_VOID       = C.FFI_TYPE_VOID
    TYPE_INT        = C.FFI_TYPE_INT
    TYPE_FLOAT      = C.FFI_TYPE_FLOAT
    TYPE_DOUBLE     = C.FFI_TYPE_DOUBLE
    //#if 1               =
    TYPE_LONGDOUBLE = C.FFI_TYPE_LONGDOUBLE
    //#else               =
    //FFI_TYPE_LONGDOUBLE = FFI_TYPE_DOUBLE
    //#endif              =
    TYPE_UINT8      = C.FFI_TYPE_UINT8
    TYPE_SINT8      = C.FFI_TYPE_SINT8
    TYPE_UINT16     = C.FFI_TYPE_UINT16
    TYPE_SINT16     = C.FFI_TYPE_SINT16
    TYPE_UINT32     = C.FFI_TYPE_UINT32
    TYPE_SINT32     = C.FFI_TYPE_SINT32
    TYPE_UINT64     = C.FFI_TYPE_UINT64
    TYPE_SINT64     = C.FFI_TYPE_SINT64
    TYPE_STRUCT     = C.FFI_TYPE_STRUCT
    TYPE_POINTER    = C.FFI_TYPE_POINTER
    TYPE_COMPLEX    = C.FFI_TYPE_COMPLEX
    // FFI_TYPE_LAST       FFI_TYPE_COMPLEX
)

pub const (
    type_void    = &C.ffi_type_void
    type_uint8   = &C.ffi_type_uint8
    type_sint8   = &C.ffi_type_sint8
    type_uint16  = &C.ffi_type_uint16
    type_sint16  = &C.ffi_type_sint16
    type_uint32  = &C.ffi_type_uint32
    type_sint32  = &C.ffi_type_sint32
    type_uint64  = &C.ffi_type_uint64
    type_sint64  = &C.ffi_type_sint64
    type_float   = &C.ffi_type_float
    type_double  = &C.ffi_type_double
    type_pointer = &C.ffi_type_pointer
)

struct C._ffi_type {

}
pub type Type = C._ffi_type
fn C.ffi_get_type_obj() &C._ffi_type
fn get_type_obj(ty int) &Type { return C.ffi_get_type_obj(ty) }
fn get_type_obj2(ty int) &Type {
    mut tyobj := &Type{}
    tyobj = voidptr(0)
    if ty == TYPE_VOID {
        tyobj = type_void
    } else if ty == TYPE_INT {
        tyobj = type_sint32
    } else if ty == TYPE_FLOAT {
        tyobj = type_float
    } else if ty == TYPE_DOUBLE {
        tyobj = type_double
    } else if ty == TYPE_LONGDOUBLE {
        // tyobj = type_longdouble
    } else if ty == TYPE_UINT8 {
        tyobj = type_uint8
    } else if ty == TYPE_SINT8 {
        tyobj = type_sint8
    } else if ty == TYPE_UINT16 {
        tyobj = type_uint16
    } else if ty == TYPE_SINT16 {
        tyobj = type_sint16
    } else if ty == TYPE_UINT32 {
        tyobj = type_uint32
    } else if ty == TYPE_SINT32 {
        tyobj = type_sint32
    } else if ty == TYPE_UINT64 {
        tyobj = type_uint64
    } else if ty == TYPE_SINT64 {
        tyobj = type_sint64
    } else if ty == TYPE_POINTER {
        tyobj = type_pointer
    }

    match ty {
        // TYPE_VOID {}
        // TYPE_INT {}
    /* case FFI_TYPE_FLOAT: */
    /*     tyobj = & ffi_type_float; */
    /*     break; */
    /* case FFI_TYPE_DOUBLE: */
    /*     tyobj = & ffi_type_double; */
    /*     break; */
    /* case FFI_TYPE_LONGDOUBLE: */
    /*     break; */
    /*     //    case FFI_TYPE_LONGDOUBLE FFI_TYPE_DOUBLE: */
    /*     // break: */
    /* case FFI_TYPE_UINT8: */
    /*     tyobj = &ffi_type_uint8; */
    /*     break; */
    /* case FFI_TYPE_SINT8: */
    /*     tyobj = &ffi_type_sint8; */
    /*     break; */
    /* case FFI_TYPE_UINT16: */
    /*     tyobj = &ffi_type_uint16; */
    /*     break; */
    /* case FFI_TYPE_SINT16: */
    /*     tyobj = &ffi_type_uint16; */
    /*     break; */
    /* case FFI_TYPE_UINT32: */
    /*     tyobj = &ffi_type_uint32; */
    /*     break; */
    /* case FFI_TYPE_SINT32: */
    /*     tyobj = &ffi_type_sint32; */
    /*     break; */
    /* case FFI_TYPE_UINT64: */
    /*     tyobj = &ffi_type_uint64; */
    /*     break; */
    /* case FFI_TYPE_SINT64: */
    /*     tyobj = &ffi_type_sint64; */
    /*     break; */
    /* case FFI_TYPE_STRUCT: */
    /*     break; */
    /* case FFI_TYPE_POINTER: */
    /*     break; */
    /* case FFI_TYPE_COMPLEX: */
        /*     break; */
        else {}
    }
    return tyobj

}

struct C.ffi_cif {}
pub type Cif = C.ffi_cif

fn C.ffi_prep_cif() int
pub fn prep_cif(cif &Cif, abi int, rtype &Type) int {
    ret := C.ffi_prep_cif(cif, abi, 0, rtype, 0)
    return ret
}

fn C.ffi_call()
pub fn call(cif &Cif, f voidptr /*fn()*/) {
    mut rvalue := u64(0)
    mut avalues := voidptr(0)
    C.ffi_call(cif, f, &rvalue, avalues)
}

pub fn call2(f fn(), args ...voidptr) u64 {
    cif := &Cif{}
    ret := C.ffi_prep_cif(cif, 0, 0, 0, 0)
    C.ffi_call(cif, f, 0, 0)
    return 0
}

fn atypes2obj(atypes []int) []&Type {
    mut res := []&Type{}
    for atype in atypes {
        o := get_type_obj(atype)
        res << o
    }
    return res
}

pub fn call3(f voidptr, atypes []int, avalues []voidptr) u64 {
    assert atypes.len == avalues.len

    argc := atypes.len
    rtype := type_pointer
    atypeso := atypes2obj(atypes)
    atypesc := atypeso.data

    cif := &Cif{}
    rv := C.ffi_prep_cif(cif, DEFAULT_ABI, argc, rtype, atypesc)
    match rv {
        // ffi.OK {}
        // ffi.BAD_TYPEDEF {}
        //ffi.BAD_ABI {}
        else{}
    }
    if rv == ffi.OK {
    } else if rv == ffi.BAD_TYPEDEF {
    } else if rv == ffi.BAD_ABI {
    }

    avaluesc := avalues.data

    mut rvalue := u64(0)
    C.ffi_call(cif, f, &rvalue, avaluesc)
    return rvalue
}
