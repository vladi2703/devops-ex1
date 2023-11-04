FROM alpine:latest

RUN apk add --no-cache python3-dev \
    && apk add py3-pip \
    && pip3 install --upgrade pip

COPY src/ .

RUN pip3 install -r requirements.txt

EXPOSE 5000

CMD [ "python3", "app.py" ]


