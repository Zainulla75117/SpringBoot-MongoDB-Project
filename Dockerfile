FROM openjdk:8-alpine

RUN apk update && apk add --no-cache bash

RUN mkdir -p /opt/app

ENV PROJECT_HOME /opt/app

COPY target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

COPY src/main/resources/static/ $PROJECT_HOME/static/

WORKDIR $PROJECT_HOME

EXPOSE 8080

# Starting the application
CMD ["java", "-jar", "./spring-boot-mongo.jar"]
