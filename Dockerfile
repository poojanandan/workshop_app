# 1. Base image: an official Java 21 runtime (JRE) on Ubuntu
FROM eclipse-temurin:21-jre

# 2. Create a non-root user to run the app (fixes DS-0002)
RUN groupadd --system app && useradd --system --gid app --no-create-home app

# 3. All following commands run inside /app in the image
WORKDIR /app

# 4. Copy the jar we built with Maven, owned by the non-root user
COPY --chown=app:app target/workshop-app.jar app.jar

# 5. Run as the non-root user
USER app

# 6. Document the port the app listens on
EXPOSE 8081

# 7. Health check: succeeds if the app accepts connections (fixes DS-0026)
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
  CMD ["bash", "-c", "exec 3<>/dev/tcp/127.0.0.1/8081"]

# 8. Command that runs when a container starts
ENTRYPOINT ["java", "-jar", "app.jar"]
