FROM python:latest
ADD requirements.txt /requirements.txt
ADD group4 /group4
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "/group4/main.py"]