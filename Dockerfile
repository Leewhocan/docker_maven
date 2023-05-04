FROM maven:latest AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ ./src/
RUN mvn package

FROM openjdk:11-jre-slim
WORKDIR /app

COPY --from=build /app/target/docker_maven-1.0-SNAPSHOT.jar ./my-app.jar

EXPOSE 8080
CMD ["java", "-jar", "my-app.jar"]
