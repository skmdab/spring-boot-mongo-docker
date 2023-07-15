FROM alpine as builder

RUN apk update && apk add git openjdk8 maven

RUN git clone https://github.com/skmdab/spring-boot-mongo-docker.git

WORKDIR /spring-boot-mongo-docker

RUN mvn clean package

FROM openjdk:8-alpine

COPY --from=builder /spring-boot-mongo-docker/target/spring-boot-mongo*.jar /opt/

WORKDIR /opt

EXPOSE 8080

CMD ["java","-jar","/spring-boot-mongo*.jar"]
