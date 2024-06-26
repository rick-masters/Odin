package sys_windows

foreign import "system:Ole32.lib"

//objbase.h
COINIT :: enum DWORD {
	APARTMENTTHREADED = 0x2,
	MULTITHREADED,
	DISABLE_OLE1DDE   = 0x4,
	SPEED_OVER_MEMORY = 0x8,
}

IUnknown :: struct {
	using Vtbl: ^IUnknownVtbl,
}
IUnknownVtbl :: struct {
	QueryInterface: proc "system" (This: ^IUnknown, riid: REFIID, ppvObject: ^rawptr) -> HRESULT,
	AddRef:         proc "system" (This: ^IUnknown) -> ULONG,
	Release:        proc "system" (This: ^IUnknown) -> ULONG,
}

LPUNKNOWN :: ^IUnknown

@(default_calling_convention="system")
foreign Ole32 {
	CoInitializeEx :: proc(reserved: rawptr, co_init: COINIT) -> HRESULT ---
	CoUninitialize :: proc() ---

	CoCreateInstance :: proc(
		rclsid: REFCLSID,
		pUnkOuter: LPUNKNOWN,
		dwClsContext: DWORD,
		riid: REFIID,
		ppv: ^LPVOID,
	) -> HRESULT ---

	CoTaskMemFree :: proc(pv: rawptr) ---
}
