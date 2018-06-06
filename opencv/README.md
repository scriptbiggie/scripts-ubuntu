## OpenCV-3.3.0-install.sh

### Please follow the following instructions to make OpenCV 3.3.0 enabled for CUDA 9.0

**Step 1:**
Change directory to **{Installation path of opencv-3.3.0}/opencv-3.3.0/cmake**
Open **FindCUDA.cmake** file with any text editor, e.g. Atom by issuing `sudo atom FindCUDA.cmake`
Look for the line with `find_cuda_helper_libs(nppi)` and replace it with:

```
  find_cuda_helper_libs(nppial)
  find_cuda_helper_libs(nppicc)
  find_cuda_helper_libs(nppicom)
  find_cuda_helper_libs(nppidei)
  find_cuda_helper_libs(nppif)
  find_cuda_helper_libs(nppig)
  find_cuda_helper_libs(nppim)
  find_cuda_helper_libs(nppist)
  find_cuda_helper_libs(nppisu)
  find_cuda_helper_libs(nppitc)
```

**Step 2:**
At the same file, look for the line with `set(CUDA_npp_LIBRARY "${CUDA_nppc_LIBRARY};${CUDA_nppi_LIBRARY};${CUDA_npps_LIBRARY}"` and replace it with:

```
set(CUDA_npp_LIBRARY "${CUDA_nppc_LIBRARY};${CUDA_nppial_LIBRARY};${CUDA_nppicc_LIBRARY};${CUDA_nppicom_LIBRARY};${CUDA_nppidei_LIBRARY};${CUDA_nppif_LIBRARY};${CUDA_nppig_LIBRARY};${CUDA_nppim_LIBRARY};${CUDA_nppist_LIBRARY};${CUDA_nppisu_LIBRARY};${CUDA_nppitc_LIBRARY};${CUDA_npps_LIBRARY}")
```

**Step 3:**
At the same file, look for the line with  `unset(CUDA_nppi_LIBRARY CACHE)` and replace it with:

```
 unset(CUDA_nppicc_LIBRARY CACHE)
 unset(CUDA_nppicom_LIBRARY CACHE)
 unset(CUDA_nppidei_LIBRARY CACHE)
 unset(CUDA_nppif_LIBRARY CACHE)
 unset(CUDA_nppig_LIBRARY CACHE)
 unset(CUDA_nppim_LIBRARY CACHE)
 unset(CUDA_nppist_LIBRARY CACHE)
 unset(CUDA_nppisu_LIBRARY CACHE)
 unset(CUDA_nppitc_LIBRARY CACHE)
```

**Step 4:**
At the same directory, open file named **OpenCVDetectCUDE.cmake** with any text editor as you did in the previous steps.
Look for the line with:

```
 ...
 set(__cuda_arch_ptx "")
 if(CUDA_GENERATION STREQUAL "Fermi")
    set(__cuda_arch_bin "2.0")
  elseif(CUDA_GENERATION STREQUAL "Kepler")
    set(__cuda_arch_bin "3.0 3.5 3.7")
 ...
```
and replace it with:

```
  ...
  set(__cuda_arch_ptx "")
  if(CUDA_GENERATION STREQUAL "Kepler")
    set(__cuda_arch_bin "3.0 3.5 3.7")
  elseif(CUDA_GENERATION STREQUAL "Maxwell")
    set(__cuda_arch_bin "5.0 5.2")
  ...
```

**Step 5:**
At the same file, look for the line with `set(__cuda_arch_bin "2.0 3.0 3.5 3.7 5.0 5.2 6.0 6.1")` and replace it with:

```
 set(__cuda_arch_bin "3.0 3.5 3.7 5.0 5.2 6.0 6.1")
```

 **Step 6 - The last one:**
 Head to **{Installation path of opencv-3.3.0}/opencv-3.3.0/modules/cudev/include/opencv2/cudev** and open file named *common.hpp* with any text editor.
 Add `#include <cuda_fp16.h>` among other include commands. That's it!

*Huge thanks to fine people at stackoverflow for such great solution!*
