########## OpenCV 3.3.0 with CUDA 9.0 Support Ubuntu 16.04 ##########

# Achtung! Should you want to install OpenCV on Ubuntu 16.04 without GPU support, simply use this URL:
# https://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/

# Update Ubuntu before installation
# sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove

# Install compiler
# sudo apt-get install -y build-essential

# Requirements
# sudo apt-get install -y python-dev cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python2.7-dev python3.5-dev

# The rest of the libraries
# sudo apt-get install -y python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
# sudo apt-get install -y libv4l-dev
# sudo apt-get install -y libxvidcore-dev libx264-dev
# sudo apt-get install -y libgtk-3-dev
# sudo apt-get install -y libatlas-base-dev gfortran
# sudo apt-get install -y unzip ffmpeg qtbase5-dev
# sudo apt-get install -y libopencv-dev libdc1394-22
# sudo apt-get install -y libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
# sudo apt-get install -y libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev
# sudo apt-get install -y libvorbis-dev v4l-utils vtk6
# sudo apt-get install -y liblapacke-dev libopenblas-dev libgdal-dev checkinstall

# Head to the target directory where you will install OpenCV-3.3.0. In this case: $HOME
cd ~

# Download OpenCV 3.3.0
wget -O opencv-3.3.0.zip https://github.com/opencv/opencv/archive/3.3.0.zip

# Download OpenCV 3.3.0 - contrib version
wget -O opencv_contrib-3.3.0.zip https://github.com/opencv/opencv_contrib/archive/3.3.0.zip

# Unzip downloaded packages
unzip opencv-3.3.0.zip
unzip opencv_contrib-3.3.0.zip

# Change directory to OpenCV-3.3.0
cd opencv-3.3.0

# Make a directory named 'build'
mkdir build

# Head to there
cd build/

# You gotta stop and do some modification at this step.
# OpenCV 3.3.0 needs some modifications due to compatibility problem raising whilst performing Cmake. That's why following steps should be implemented
# for a successful configuration.

# Step 1:
# Change directory to {Installation path of opencv-3.3.0}/opencv-3.3.0/cmake
# Open FindCUDA.cmake file with any text editor, e.g. Atom by issuing "sudo atom FindCUDA.cmake"
# Look for the line with "find_cuda_helper_libs(nppi)" and replace it with:

#  find_cuda_helper_libs(nppial)
#  find_cuda_helper_libs(nppicc)
#  find_cuda_helper_libs(nppicom)
#  find_cuda_helper_libs(nppidei)
#  find_cuda_helper_libs(nppif)
#  find_cuda_helper_libs(nppig)
#  find_cuda_helper_libs(nppim)
#  find_cuda_helper_libs(nppist)
#  find_cuda_helper_libs(nppisu)
#  find_cuda_helper_libs(nppitc)

# Make sure to exclude "#"s and pay attention on indentation for future modification.

# Step 2:
# At the same file, look for the line with ' set(CUDA_npp_LIBRARY "${CUDA_nppc_LIBRARY};${CUDA_nppi_LIBRARY};${CUDA_npps_LIBRARY}" ' and replace it with:

# set(CUDA_npp_LIBRARY "${CUDA_nppc_LIBRARY};${CUDA_nppial_LIBRARY};${CUDA_nppicc_LIBRARY};${CUDA_nppicom_LIBRARY};${CUDA_nppidei_LIBRARY};${CUDA_nppif_LIBRARY};${CUDA_nppig_LIBRARY};${CUDA_nppim_LIBRARY};${CUDA_nppist_LIBRARY};${CUDA_nppisu_LIBRARY};${CUDA_nppitc_LIBRARY};${CUDA_npps_LIBRARY}")

# Step 3:
# At the same file, look for the line with  ' unset(CUDA_nppi_LIBRARY CACHE) ' and replace it with:

# unset(CUDA_nppicc_LIBRARY CACHE)
# unset(CUDA_nppicom_LIBRARY CACHE)
# unset(CUDA_nppidei_LIBRARY CACHE)
# unset(CUDA_nppif_LIBRARY CACHE)
# unset(CUDA_nppig_LIBRARY CACHE)
# unset(CUDA_nppim_LIBRARY CACHE)
# unset(CUDA_nppist_LIBRARY CACHE)
# unset(CUDA_nppisu_LIBRARY CACHE)
# unset(CUDA_nppitc_LIBRARY CACHE)

# Step 4:
# At the same directory, open file named 'OpenCVDetectCUDE.cmake' with any text editor as you did in the previous steps.
# Look for the line with:

# ...
#  set(__cuda_arch_ptx "")
#  if(CUDA_GENERATION STREQUAL "Fermi")
#    set(__cuda_arch_bin "2.0")
#  elseif(CUDA_GENERATION STREQUAL "Kepler")
#    set(__cuda_arch_bin "3.0 3.5 3.7")
#  ...
#  and replace it with:

#  ...
#  set(__cuda_arch_ptx "")
#  if(CUDA_GENERATION STREQUAL "Kepler")
#    set(__cuda_arch_bin "3.0 3.5 3.7")
#  elseif(CUDA_GENERATION STREQUAL "Maxwell")
#    set(__cuda_arch_bin "5.0 5.2")
#  ...

# Step 5:
# At the same file, look for the line with 'set(__cuda_arch_bin "2.0 3.0 3.5 3.7 5.0 5.2 6.0 6.1") ' and replace it with:

# set(__cuda_arch_bin "3.0 3.5 3.7 5.0 5.2 6.0 6.1")

# Step 6 - The last one:
# Head to {Installation path of opencv-3.3.0}/opencv-3.3.0/modules/cudev/include/opencv2/cudev and open file named 'common.hpp' with any text editor.
# Add ' #include <cuda_fp16.h> ' among other include commands. That's it!

### Huge thanks to fine people at stackoverflow for such great solution ###

# Now configure build with given options
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D INSTALL_C_EXAMPLES=OFF \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.0/modules \
      -D FORCE_VTK=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D WITH_CUDA=ON \
      -D ENABLE_FAST_MATH=1 \
      -D CUDA_FAST_MATH=1 \
      -D WITH_CUBLAS=ON \
      -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES --expt-relaxed-constexpr" \
      -D WITH_GSTREAMER=ON \
      -D WITH_FFMPEG=ON \
      -D WITH_GDAL=ON \
      -D WITH_XINE=ON \
      -D BUILD_EXAMPLES=ON ..

# Compile OpenCV with using all processing units
make -j $(($(nproc) + 1))

# Install OpenCV
sudo make install
sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

# Create the necessary links and cache to the most recent shared libraries
sudo ldconfig

# Final update and then manually restart your system.
sudo apt-get update

# Verify installation
# Type in python to the command line and the following commands. Outputs should be like this:

# >>> import cv2
# >>> cv2.__version__
# '3.3.0'

# If yes, congratulations, now you have a CUDA 9.0 compatible OpenCV 3.3.0 on your machine :)
