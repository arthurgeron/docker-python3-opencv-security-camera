FROM resin/armv7hf-debian

RUN [ "cross-build-start" ]
RUN apt-get update && \
    apt-get install -y --force-yes \
    python3 python3-numpy python3-nose python3-pandas \
    python python-numpy python-nose python-pandas \
    pep8 python-pip python3-pip python-wheel \
    python-sphinx \
    wget \
    zip \
    unzip \
    sed && \
    pip install --upgrade setuptools && \
    pip3 install --upgrade setuptools

RUN apt-get install -y --force-yes cmake && \
    wget https://github.com/opencv/opencv/archive/3.3.0.zip \
    && unzip 3.3.0.zip \
    # && sed -i 's/#if NPY_INTERNAL_BUILD/#ifndef NPY_INTERNAL_BUILD\n#define NPY_INTERNAL_BUILD/g' /usr/local/lib/python3.4/site-packages/numpy/core/include/numpy/npy_common.h \
    && mkdir /opencv-3.3.0/cmake_binary \
    && cd /opencv-3.3.0/cmake_binary \
    && cmake -D BUILD_TIFF=ON \
    -DCMAKE_TOOLCHAIN_FILE=/opencv-3.3.0/platforms/linux/arm-gnueabi.toolchain.cmake \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=OFF \
    -DENABLE_AVX=ON \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python3) \
    -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    && make install \
    && rm /3.3.0.zip \
    && rm -r /opencv-3.3.0 \
    && cd ../.. 

RUN git clone https://github.com/arthurgeron/picamera \
  && cd picamera \
  && pip3 install -r requirements.txt \
  && chmod +x main.py \
  && cd .. 

RUN [ "cross-build-end" ]  
#Expose port 80
EXPOSE 80
#Default command
# CMD ["picamera/main.py"]    

