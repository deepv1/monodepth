FROM python:3.6-slim

ENV HOME=/app

WORKDIR $HOME

RUN apt-get update && apt-get install -y git
COPY requirements.txt $HOME/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

COPY . $HOME/

RUN echo "#!/bin/bash \n python monodepth_simple.py --image_path ${FILEPATH:-$HOME/images/test_img.jpg} --checkpoint_path ${MODEL:-~/models/model_cityscapes/model_cityscapes}" > ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
