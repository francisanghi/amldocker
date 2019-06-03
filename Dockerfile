# TO BUILD, RUN `docker build -t aws .`
# TO RUN, call `docker run --rm -ti aws`

FROM amazonlinux:2

RUN yum install gcc openssl-devel bzip2-devel libffi-devel make tar gzip docker -q -y
#RUN yum install -y python3-pip python3 python3-setuptools
#RUN amazon-linux-extras install docker -y
#RUN dockerd &
#RUN service docker start 


# DOWNLOAD PYTHON
WORKDIR /usr/src
RUN curl https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz -o python.tgz
RUN tar xzf python.tgz

# COMPILE PYTHON
WORKDIR Python-3.7.3
RUN ./configure --enable-optimizations
RUN make altinstall

# REMOVE PYTHON
WORKDIR /usr/src
RUN rm python.tgz

# INSTALL NODE
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -
RUN yum -y install nodejs

# INSTALL SERVERLESS
RUN npm install -g serverless

# CONFIGURE SERVERLESS
RiUN serverless config credentials --provider aws --key  --secret

# INSTALL VIRTUAL ENV
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python3.7 get-pip.py --user


# EXAMPLE
WORKDIR /home/tmp
COPY . .

# VENV
RUN pip3.7 install virtualenvwrapper
RUN virtualenv venv --python=python3.7
RUN source venv/bin/activate


# PACKAGING PYTHON WITH PLUGGINS
RUN pip3.7 install -r requirements.txt
#RUN python3.7 handler.py
#RUN npm init --yes
#RUN npm install --save serverless-python-requirements
#RUN serverless deploy


