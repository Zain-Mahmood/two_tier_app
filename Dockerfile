FROM python:latest
RUN pip install flask
ADD app.py /app.py
ADD management.py /management.py
ADD spartans.json /spartans.json
ADD spartan.py /spartan.py
ENTRYPOINT ["python", "app.py", "management.py", "spartans.json", "spartan.py"]

