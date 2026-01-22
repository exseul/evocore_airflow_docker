from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    "owner": "airflow",
    "retries": 0,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    "airflow_db_cleanup",
    default_args=default_args,
    start_date=datetime(2025, 1, 1),
    schedule_interval="@daily",  # 매일 실행
    catchup=False,
) as dag:

    cleanup = BashOperator(
        task_id="cleanup_old_logs",
        bash_command=(
            "airflow db clean "
            "--clean-before-timestamp '{{ macros.ds_add(ds, -30) }}T00:00:00+00:00' "
            "--skip-archive --yes; "
            "find /DATA/POLI/DOCK/evocore/logs/ -mindepth 1 -type f -mtime +30 -delete 2>/dev/null; "
            "find /DATA/POLI/DOCK/evocore/logs/ -mindepth 1 -type d -empty -delete 2>/dev/null || true"
        ),
    )