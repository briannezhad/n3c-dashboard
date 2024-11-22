# Use the official Tomcat image from the Docker Hub
FROM tomcat:9.0

# Copy your custom server.xml
COPY config/server.xml /usr/local/tomcat/conf/server.xml
COPY config/rewrite.config /usr/local/tomcat/conf/Catalina/localhost/

# Copy the WAR file to the webapps directory of Tomcat
COPY config/n3c-dashboard-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
COPY config/context.xml /usr/local/tomcat/webapps/META-INF

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]