FROM fedora:29

LABEL name="Docker build for API testing using the robot framework"

RUN dnf upgrade -y && dnf install -y python37

ADD . /apiTest
WORKDIR /apiTest

RUN pip3 install -r requirements.txt

ENTRYPOINT ["sh","suiteRun.sh"]
