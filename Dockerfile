
# Etape 1 : Construction de l'application
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY backend/ .

RUN mvn clean package -DskipTests

# Etape 2 : Execution de l'application
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
