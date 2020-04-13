FROM python:3.6.10-alpine3.11
WORKDIR /app
COPY backend.py backend.py
COPY requirements.txt ./requirements.txt
RUN ["pip3", "install", "-r", "requirements.txt"]
CMD ["python3", "backend.py"]