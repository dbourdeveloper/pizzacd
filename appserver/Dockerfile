FROM python:3.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*
RUN pip install pipenv

ENV APP_USER pizza
ENV APP_HOME /home/$APP_USER
RUN groupadd -g 1000 $APP_USER && \
    useradd -u 1000 -g 1000 -G sudo --create-home --home-dir $APP_HOME --shell /bin/bash $APP_USER

WORKDIR $APP_HOME

COPY --chown=1000:1000 Pipfile $APP_HOME/Pipfile
COPY --chown=1000:1000 Pipfile.lock $APP_HOME/Pipfile.lock
RUN pipenv install --dev --deploy --system
COPY --chown=1000:1000 . $APP_HOME/

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

USER $APP_USER

CMD ["bin/startup.sh"]