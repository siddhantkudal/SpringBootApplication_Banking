FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests=true

FROM openjdk:17.0.1-jdk-slim
#FROM gcr.io/distroless/java17
WORKDIR /app 

COPY --from=builder /app/target/*.jar /app/bank.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/bank.jar"]