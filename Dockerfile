FROM tomcat:9-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY WebContent/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
