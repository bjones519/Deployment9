FROM python:3.9

RUN git clone https://github.com/bjones519/Deployment9.git

WORKDIR Deployment9/backend

RUN pip install pip --upgrade
RUN pip install -r requirements.txt
RUN python manage.py

EXPOSE 8000

CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]