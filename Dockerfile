FROM python:alpine

WORKDIR /code

RUN apk update && apk add --no-cache tor curl  

COPY ./requirements.txt /tmp/requirements.txt

RUN pip3 install -r /tmp/requirements.txt

RUN echo "Log notice stdout" >> /etc/tor/torrc
RUN echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc
RUN echo "ControlPort 9051" >> /etc/tor/torrc
RUN echo "# CookieAuthentication 1" >> /etc/tor/torrc
RUN echo "# HashedControlPassword 16:E600ADC1B52C80BB6022A0E999A7734571A451EB6AE50FED489B72E3DF" >> /etc/tor/torrc
RUN echo "HiddenServiceDir /var/lib/tor/web/" >> /etc/tor/torrc
RUN echo "HiddenServicePort 80 127.0.0.1:5000" >> /etc/tor/torrc
RUN chown -R tor /etc/tor

COPY ./project .

RUN echo "python3 server.py &" >> /start.sh
RUN echo "tor -f /etc/tor/torrc &" >> /start.sh

RUN echo "sleep 5" >> /start.sh
RUN echo "cat /var/lib/tor/web/hostname" >> /start.sh

RUN echo "while true; do sleep 60; done" >> /start.sh

RUN chmod +x /start.sh

EXPOSE 9050
EXPOSE 9051

CMD /start.sh
