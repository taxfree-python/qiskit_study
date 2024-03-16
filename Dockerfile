FROM python:3.11

WORKDIR /notebook

# Poetry のインストール
ENV POETRY_VERSION=1.1.13
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# プロジェクトファイルのコピー
COPY pyproject.toml poetry.lock* /notebook/

# 依存関係のインストール
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# ポート8888を開放(JupyterLab用)
EXPOSE 8888

# JupyterLab を起動
CMD ["poetry", "run", "jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]

# docker run -p 8888:8888 -v "$(pwd)/notebooks:/notebook" jupyter-poetry-env