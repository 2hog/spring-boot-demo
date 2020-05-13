FROM maven AS builder
WORKDIR /usr/src/app
COPY pom.xml ./
RUN mvn verify clean --fail-never
COPY ./ ./
RUN mvn package

FROM openjdk:8
COPY --from=builder /usr/src/app/target/gs-spring-boot-docker-0.1.0.jar /app.jar
CMD java -Djarmode=layertools -jar /app.jar