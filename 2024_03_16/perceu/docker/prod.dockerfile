FROM python:3

WORKDIR /usr/src/app

RUN apt update
RUN apt -y install build-essential python3-venv python3-dev libpq-dev

COPY requirements-prod.txt ./
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements-prod.txt

COPY manage.py ./

COPY grupysm ./grupysm

CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "grupysm.wsgi:application"]