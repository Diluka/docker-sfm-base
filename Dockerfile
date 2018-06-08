FROM ubuntu:16.04

RUN apt-get update && apt-get -y install \
    build-essential cmake git nano vim \
    libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev \
    libxxf86vm-dev libxxf86vm1 libxmu-dev libxi-dev libxrandr-dev gcc gcc-multilib \
    libopencv-dev \
    libboost-all-dev \
    libcgal-dev libcgal-qt5-dev \
    libatlas-base-dev libsuitesparse-dev \
    libgoogle-glog-dev \
    python-dev python-numpy python-opencv python-pip python-pyexiv2 python-pyproj python-scipy python-yaml \
    freeglut3-dev libglew-dev libglfw3-dev \
    && apt-get autoremove && apt-get clean

# Install Eigen
ADD eigen /opt/eigen
RUN mkdir -p /opt/eigen_build && cd /opt/eigen_build \
    && cmake . /opt/eigen \
    && make -j && make install \
    && rm -rf /opt/eigen_build

# Install Ceres
ADD ceres-solver /opt/ceres-solver
RUN mkdir -p /opt/ceres_build \
    && cd /opt/ceres_build \
    && cmake . /opt/ceres-solver/ -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF \
    && make -j && make install \
    && rm -rf /opt/ceres_build

