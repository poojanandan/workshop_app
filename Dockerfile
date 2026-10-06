# 1. Base image: an official Java 21 runtime (JRE) on Ubuntu
FROM eclipse-temurin:21-jre

# 2. All following commands run inside /app in the image
WORKDIR /app

# 3. Copy the jar we built with Maven into the image
COPY target/workshop-app.jar app.jar

# 4. Document that the app listens on 8081
EXPOSE 8081

# 5. Command that runs when a container starts
ENTRYPOINT ["java", "-jar", "app.jar"]
