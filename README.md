# EvoCore Airflow Docker

## 프로젝트 개요
2024~2026 연구 과제의 데이터 분석 시뮬레이터 및 워크플로우 관리를 위한 Apache Airflow 기반 Docker 환경입니다.

## 주요 기능
- **Apache Airflow 2.9.0**: 데이터 파이프라인 및 워크플로우 오케스트레이션
- **CeleryExecutor**: 분산 태스크 처리 및 스케일링
- **지리정보 처리**: Rasterio, GeoPandas, GEE(Google Earth Engine) 지원
- **데이터 분석**: Xarray, Pandas, NumPy 기반 대용량 데이터 처리
- **시계열 분석**: Statsmodels, Pmdarima를 활용한 예측 모델링
- **에이전트 기반 모델링**: Mesa 프레임워크
- **FastAPI 서버**: REST API 제공
- **자동 로그 관리**: 30일 이상 로그 자동 정리

## 시스템 구성
- **Apache Airflow**: 워크플로우 스케줄러, 웹서버, 워커
- **PostgreSQL 13**: 메타데이터 저장소
- **Redis 7.2**: Celery 메시지 브로커
- **Python 3.11**: 런타임 환경
- **Java 17**: Java 연동 작업 지원

## 설치 및 실행

### 사전 요구사항
- Docker
- Docker Compose

### 실행 방법
```bash
# 환경 변수 설정 (필요시)
cp .env.example .env

# 컨테이너 빌드 및 실행
docker-compose up -d --build
```

### 접속 정보
- **Airflow Web UI**: http://localhost:49090
- **기본 계정**: airflow / airflow
- **PostgreSQL**: localhost:5432

## 디렉토리 구조
```
.
├── dags/                    # Airflow DAG 파일
├── logs/                    # Airflow 실행 로그
├── config/                  # 설정 파일
├── plugins/                 # Airflow 플러그인
├── scripts/                 # 유틸리티 스크립트
├── docker-compose.yaml      # Docker Compose 설정
├── Dockerfile              # Airflow 이미지 빌드 설정
└── requirements.txt        # Python 패키지 의존성
```

## 주요 Python 패키지
- 데이터 처리: xarray, pandas, numpy
- 지리정보: geopandas, rasterio, geemap, earthengine-api
- 통계분석: statsmodels, pmdarima, scikit-learn
- 웹 프레임워크: FastAPI, uvicorn
- 시뮬레이션: mesa
- 데이터베이스: SQLAlchemy, psycopg2, pymysql

## 메모리 할당
- Webserver: 16GB
- Scheduler: 16GB
- Worker: 16GB
- Triggerer: 4GB

## 참고사항
- Git에는 기본 코드만 업로드되며, 환경 변수 및 민감한 정보는 제외됩니다
- `/DATA` 및 `/data1/upload_tmp` 디렉토리가 컨테이너에 마운트됩니다
- 로그는 매일 자동으로 정리됩니다 (30일 이상 된 로그 삭제)


## 프로젝트 연도
2024년 ~ 진행중