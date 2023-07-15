FROM alpine as builder

RUN apk update && apk add git maven 

RUN wget https://github.com/skmdab/spring-boot-mongo-docker.git

WORKDIR /app/spring-boot-mongo-docker

RUN mvn clean package

FROM tomcat:8-jdk8-corretto

COPY --from=builder /app/spring-boot-mongo-docker/target/spring-boot-mongo*.jar /usr/local/tomcat/webapps/
