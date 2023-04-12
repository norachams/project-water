FROM python:3.9-slim-buster

WORKDIR /myportfolio

COPY requirements.txt .

RUN pip3 install -r requirements.txt

CMD ["flask", "run", "_-host=0.0.0.0"]

EXPOSE 5000