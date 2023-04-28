FROM python:3.11-slim

WORKDIR /usr/src/app

RUN pip install poetry~=1.4
RUN poetry config virtualenvs.create false

COPY ./pyproject.toml pyproject.toml
COPY ./poetry.lock poetry.lock

RUN poetry install
RUN opentelemetry-bootstrap --action=install

COPY ./ /usr/src/app/

EXPOSE 8000

CMD ["uvicorn", "main:app", "--log-level", "critical","--proxy-headers", "--host", "0.0.0.0", "--port", "8000"]
