From tomcat:8.0.51-jre8-alpine
RUN rm -rf /user/local/tomcat/webapps/*
COPY ./build/libs/Batchreports-0.0.1-SNAPSHOT.jar /user/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh","run"]