FROM python:3.7-alpine

COPY ./django_blog/requirements.txt  /app/

RUN set -ex && apk add --no-cache --virtual .build-deps postgresql-dev build-base 
RUN python -m venv /env && \
    /env/bin/pip install --upgrade pip && \
    /env/bin/pip install --no-cache-dir -r /app/requirements.txt
RUN apk add --virtual rundeps $(scanelf --needed --nobanner --recursive /env \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u) && apk del .build-deps

COPY ./django_blog/  /app
WORKDIR /app

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 8000

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
