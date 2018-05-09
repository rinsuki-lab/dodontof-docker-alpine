FROM alpine:3.7

RUN apk add --update h2o ruby wget unzip sudo ruby-json
RUN ln -s /usr/bin/ruby /usr/local/bin/ruby

RUN wget -O dodontof.zip https://www.dropbox.com/s/mq5zsph5quqwzg1/DodontoF_Ver.1.49.00_okitegami.zip?dl=1 && \
    unzip dodontof.zip && \
    mv DodontoF_WebSet /app

WORKDIR /app/public_html/DodontoF/

RUN chown -R nobody ../../
RUN chmod 705 . DodontoFServer.rb saveDataTempSpace fileUploadSpace replayDataUploadSpace
RUN chmod 600 log.txt log.txt.0
RUN chmod 705 ../imageUploadSpace ../imageUploadSpace/smallImages
RUN chmod 705 ../../saveData

RUN echo "h2o ALL=(nobody) NOPASSWD: ALL" >> /etc/sudoers

COPY h2o.conf /etc/

WORKDIR /
CMD [ "h2o" ]

EXPOSE 8080