#include <ffiv.h>

ffi_type* ffi_get_type_obj(int ty) {
    ffi_type* tyobj = 0;
    switch (ty) {
    case FFI_TYPE_VOID:
        tyobj = & ffi_type_void;
        break;
    case FFI_TYPE_INT:
        tyobj = & ffi_type_sint32;
        break;
    case FFI_TYPE_FLOAT:
        tyobj = & ffi_type_float;
        break;
    case FFI_TYPE_DOUBLE:
        tyobj = & ffi_type_double;
        break;
    case FFI_TYPE_LONGDOUBLE:
        break;
        //    case FFI_TYPE_LONGDOUBLE FFI_TYPE_DOUBLE:
        // break:
    case FFI_TYPE_UINT8:
        tyobj = &ffi_type_uint8;
        break;
    case FFI_TYPE_SINT8:
        tyobj = &ffi_type_sint8;
        break;
    case FFI_TYPE_UINT16:
        tyobj = &ffi_type_uint16;
        break;
    case FFI_TYPE_SINT16:
        tyobj = &ffi_type_uint16;
        break;
    case FFI_TYPE_UINT32:
        tyobj = &ffi_type_uint32;
        break;
    case FFI_TYPE_SINT32:
        tyobj = &ffi_type_sint32;
        break;
    case FFI_TYPE_UINT64:
        tyobj = &ffi_type_uint64;
        break;
    case FFI_TYPE_SINT64:
        tyobj = &ffi_type_sint64;
        break;
    case FFI_TYPE_STRUCT:
        break;
    case FFI_TYPE_POINTER:
        break;
    case FFI_TYPE_COMPLEX:
        break;
    }
    return tyobj;
}
