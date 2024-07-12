# Utiliser l'image de base officielle de Maven pour construire le projet
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY ./back /app
RUN mvn clean package -DskipTests -pl akdemia-gp4e-ws -am

# Utiliser l'image de base officielle OpenJDK pour exécuter l'application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/akdemia-gp4e-ws/target/*.jar app.jar

# Exposer le port sur lequel l'application écoute
EXPOSE 8090

# Commande pour démarrer l'application
CMD ["java", "-jar", "app.jar"]
