FROM apache/airflow:2.9.0-python3.11

# root 사용자로 패키지 설치 진행
USER root

# 시스템 패키지 설치 - rasterio 의존성 포함
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    wget \
    vim \
    gdal-bin \
    libgdal-dev \
    gcc \
    g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/jovyan/.jupyter \
    && chown -R 777 /home/jovyan

# Set JAVA_HOME 환경 변수
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
ENV LD_LIBRARY_PATH=$JAVA_HOME/lib/server:$LD_LIBRARY_PATH

# GDAL 환경변수 설정 (rasterio를 위해 필요)
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Python 환경변수 설정
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages
ENV PATH=/usr/local/bin:$PATH

# Python 패키지 설치 - 캐시 사용하지 않아 이미지 크기 줄임
COPY requirements.txt ./requirements.txt
USER airflow
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir wheel setuptools && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir airflow-code-editor

ENV TZ=Asia/Seoul