# build stage 
FROM python:3.12.1-alpine3.19 as builder

RUN apk --no-cache upgrade

RUN apk add --no-cache python3-dev \
    && apk add py3-pip \
    && pip3 install --upgrade pip

WORKDIR /build

COPY src/ .

RUN python3 -m venv /build/venv
RUN . /build/venv/bin/activate && \
    python3 -m ensurepip --upgrade && \
    python3 -m pip install -r /build/requirements.txt

# Runtime
FROM python:3.12.1-alpine3.19 as release

RUN apk --no-cache upgrade

WORKDIR /app

COPY --from=builder /build /build
COPY src/app.py .
COPY docker-start-app.sh /docker-start-app.sh
RUN chmod +x /docker-start-app.sh

EXPOSE 5000

CMD ["/docker-start-app.sh"]
