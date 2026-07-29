FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /workspace

COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
COPY src ./src

RUN chmod +x mvnw && ./mvnw -B -DskipTests clean package

FROM eclipse-temurin:21-jre
WORKDIR /app

COPY --from=build /workspace/target/devops-integration.jar /app/app.jar

EXPOSE 8082
ENV JAVA_OPTS=""

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]
