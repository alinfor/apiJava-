# Use the official Maven/Java image to build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY ./back /app
RUN mvn clean package -DskipTests -pl akdemia-gp4e-ws -am

# Use a smaller JRE base image for running the application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/akdemia-gp4e-ws/target/*.jar app.jar

# Expose the port that Spring Boot listens on (ensure it matches your application.yml configuration)
EXPOSE 8090

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
